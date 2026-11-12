{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
  };

  outputs =
    { self, nixpkgs, ... }@inputs:
    let
      systems = [
        "aarch64-linux"
        "x86_64-linux"
      ];

      forEachSystem = nixpkgs.lib.genAttrs systems;

      pkgsFor =
        system:
        import nixpkgs {
          inherit system;
          overlays = [ self.overlays.default ];
        };
    in
    {
      nixosModules.default = nixpkgs.lib.filesystem.listFilesRecursive ./modules;

      overlays.default = final: prev: {
        ubootRenegade = final.callPackage ./pkgs/uboot-renegade.nix { };
        homed = final.callPackage ./pkgs/homed.nix { };
        zhaquirkSnzb04pr2 = final.callPackage ./pkgs/zha-quirk-snzb04pr2.nix { };
      };

      legacyPackages = forEachSystem pkgsFor;

      devShells = forEachSystem (system: {
        default = (pkgsFor system).mkShell {
          packages = with (pkgsFor system); [
            cargo
            rustfmt
            clippy
            # This brings in rust source for rust-analyzer
            rustc
          ];
        };
      });

      # This sets the default formatter for `nix fmt`
      formatter = forEachSystem (system: (pkgsFor system).nixfmt-tree);

      nixosConfigurations =
        let
          # Auto-import all modules. Each module must be behind an enable flag.
          nixosSystem =
            args:
            nixpkgs.lib.nixosSystem (
              args
              // {
                modules =
                  self.nixosModules.default
                  ++ (args.modules or [ ])
                  ++ [
                    { nixpkgs.overlays = [ self.overlays.default ]; }
                  ];

                specialArgs = (
                  (args.specialArgs or { })
                  // {
                    inherit inputs;
                  }
                );
              }
            );
        in
        {
          homemac = nixosSystem {
            system = "x86_64-linux";
            modules = [
              ./configurations/homemac/configuration.nix
            ];
          };

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

          orbvm = nixosSystem {
            system = "aarch64-linux";
            modules = [
              ./configurations/orbvm/configuration.nix
            ];
          };
        };

      checks = {
        x86_64-linux = {
          devShell = self.devShells.x86_64-linux.default;
          homemac = self.nixosConfigurations.homemac.config.system.build.toplevel;
        };
        aarch64-linux = {
          inherit (pkgsFor "aarch64-linux") homed zhaquirkSnzb04pr2 ubootRenegade;
          devShell = self.devShells.aarch64-linux.default;
          homepi = self.nixosConfigurations.homepi.config.system.build.toplevel;
          homeroc = self.nixosConfigurations.homeroc.config.system.build.toplevel;
          orbvm = self.nixosConfigurations.orbvm.config.system.build.toplevel;
        };
      };
    };
}
