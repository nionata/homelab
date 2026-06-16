{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
  };

  outputs =
    { self, nixpkgs, ... }@inputs:
    let
      system = "aarch64-linux";
      legacyPackages = nixpkgs.legacyPackages.${system};

      nixosModules = nixpkgs.lib.filesystem.listFilesRecursive ./modules;
    in
    {
      inherit nixosModules;

      legacyPackages.${system} = legacyPackages;

      nixosConfigurations =
        let
          # Auto-import all modules. Each module must be behind an enable flag.
          nixosSystem =
            args:
            nixpkgs.lib.nixosSystem (
              args
              // {
                modules = nixosModules ++ (args.modules or [ ]);
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
        };

      # This sets the default formatter for `nix fmt`
      formatter.${system} = legacyPackages.nixfmt-tree;
    };
}
