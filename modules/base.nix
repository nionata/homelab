# Base module with common config that should apply to everything.

{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Flakes only. Drops nix-channel and its NIX_PATH fallback, so <nixpkgs>
  # resolves solely through the flake registry.
  nix.channel.enable = false;

  # Pin `nixpkgs` in the flake registry to the nixpkgs this system was built from.
  nixpkgs.flake.setFlakeRegistry = true;

  boot.zfs.forceImportRoot = false;
}
