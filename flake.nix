{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.homepi = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      modules = [
        ./homepi/configuration.nix
      ];
    };
  };
}