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
          homed = final.callPackage ./pkgs/homed.nix { };
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

                # Use the overlayed pkgs in the modules
                # Inject inputs for nix flake registry
                specialArgs = (
                  (args.specialArgs or { })
                  // {
                    inherit pkgs inputs;
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
            cargo
            rustfmt
            clippy
            rustc
          ];

          # RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";

          shellHook = ''
            exec zsh
          '';
        };
      };

      # This sets the default formatter for `nix fmt`
      formatter.${system} = pkgs.nixfmt-tree;
    };
}
