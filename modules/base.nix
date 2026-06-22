# Base module with common config that should apply to everything.

{
  inputs,
  ...
}:
{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nix.registry.homelab.flake = inputs.self;

  nix.registry.nixpkgs.flake = inputs.nixpkgs;
}
