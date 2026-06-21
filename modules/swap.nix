# Get some swap to survive NixOS builds.

{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.homelab.swap;
in
{
  options.homelab.swap = {
    enable = lib.mkEnableOption "download more ram";

    device = lib.mkOption {
      type = lib.types.str;
      description = "Device to mount the swap file";
      default = "/var/lib/swapfile";
    };

    size = lib.mkOption {
      type = lib.types.ints.unsigned;
      description = "Size of the swap in MB";
      default = 2048;
    };
  };

  config = lib.mkIf cfg.enable {
    swapDevices = [
      {
        device = cfg.device;
        size = cfg.size;
      }
    ];
  };
}
