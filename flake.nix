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

                specialArgs = (
                  (args.specialArgs or { })
                  // {
                    # Inject inputs for nix flake registry
                    inherit inputs;
                    # Use the overlayed pkgs in the modules
                    _pkgs = pkgs;
                    # pass the system in
                    # system = args.system;
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
            # This brings in rust source for rust-analyzer
            rustc
          ];
        };
      };

      # This sets the default formatter for `nix fmt`
      formatter.${system} = pkgs.nixfmt-tree;
    };
}
