{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
  };

  outputs =
    { self, nixpkgs, ... }@inputs:
    let
      system = "aarch64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations.homepi = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          ./homepi/configuration.nix
        ];
      };

      # This sets the default formatter for `nix fmt`
      formatter.${system} = pkgs.nixfmt-tree;
    };
}
