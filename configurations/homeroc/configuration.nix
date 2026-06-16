# Configuration for a Raspberry Pi 3 Model B Vi.2

{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:

{
  imports = [
    # Inherits the default aarch64 partition layouts and generic-extlinux setup
    # https://sourcegraph.com/r/github.com/NixOS/nixpkgs@1da598155d27977d91c47e51a9c84ce91f2717fd/-/blob/nixos/modules/installer/sd-card/sd-image-aarch64.nix
    (modulesPath + "/installer/sd-card/sd-image-aarch64.nix")
  ];

  # We may need/want this. At the very least we'll want the wifi db
  # hardware.enableRedistributableFirmware = true;

  nixpkgs.config.allowUnfree = true; # needed for ubootRock64
  # at the time of writing the u-boot version from FireFly hasn't been successfully ported yet
  # so we use the one from Rock64
  sdImage.postBuildCommands = with pkgs; ''
    dd if=${ubootRock64}/idbloader.img of=$img conv=fsync,notrunc bs=512 seek=64
    dd if=${ubootRock64}/u-boot.itb of=$img conv=fsync,notrunc bs=512 seek=16384
  '';

  # For the hardware serial console (UART) if you use a console cable
  boot.kernelParams = lib.mkForce [
    "console=ttyS2,1500000n8"
    "console=tty1"
  ];

  # --- Memory Management for 2GB RAM ---
  # NixOS rebuilding is heavy. Without swap, a 2GB Roc will hit Out-Of-Memory (OOM) errors and freeze during updates.
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 1024; # 1GB Swap file
    }
  ];

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.05"; # Did you read the comment?
}
