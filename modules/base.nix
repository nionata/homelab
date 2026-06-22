# Base module with common config that should apply to everything.

{
  modulesPath,
  inputs,
  _pkgs,
  system,
  ...
}:
{
  imports = [
    (modulesPath + "/misc/nixpkgs/read-only.nix")
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nix.registry.homelab.flake = inputs.self;

  nix.registry.nixpkgs.flake = inputs.nixpkgs;

  nixpkgs.pkgs = _pkgs;
  # nixpkgs.system = system;
}
