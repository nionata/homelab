{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
  };

  outputs =
    { self, nixpkgs, ... }@inputs:
    let
      system = "aarch64-linux";

      overlays = [
        (final: prev: {
          ubootRenegade = final.callPackage ./pkgs/uboot-renegade.nix { };
        })
      ];

      pkgs = import nixpkgs {
        inherit system overlays;
      };

      nixosModules = nixpkgs.lib.filesystem.listFilesRecursive ./modules;
    in
    {
      inherit nixosModules;

      legacyPackages.${system} = pkgs;

      nixosConfigurations =
        let
          # Auto-import all modules. Each module must be behind an enable flag.
          nixosSystem =
            args:
            nixpkgs.lib.nixosSystem (
              args
              // {
                modules = nixosModules ++ (args.modules or [ ]);

                # Force NixOS to use our pre-instantiated pkgs
                specialArgs = (
                  (args.specialArgs or { })
                  // {
                    inherit pkgs;
                  }
                );
              }
            );
        in
        {
          homepi = nixosSystem {
            system = "aarch64-linux";
            modules = [
              ./configurations/homepi/configuration.nix
            ];
          };

          homeroc = nixosSystem {
            system = "aarch64-linux";
            modules = [
              ./configurations/homeroc/configuration.nix
            ];
          };
        };

      devShells.${system} = {
        default = pkgs.mkShell {
          packages = with pkgs; [
            # Infra
            vim
            less
            openssh
            git
            # Shell
            zsh
            fzf
            starship
            # Lang
            cargo
            rustfmt
            clippy
            rust-analyzer
          ];

          RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";

          shellHook = ''
            exec zsh
          '';
        };
      };

      # This sets the default formatter for `nix fmt`
      formatter.${system} = pkgs.nixfmt-tree;
    };
}
