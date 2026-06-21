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

  # --- Raspberry Pi 3 Specific Hardware & Firmware ---
  # Essential firmware for the Pi 3's Broadcom Wi-Fi, Bluetooth, and VideoCore GPU
  hardware.enableRedistributableFirmware = true;
  # For the hardware serial console (UART) if you use a console cable
  # On Pi 3, ttyS1 or ttyAMA0 is used depending on Bluetooth allocation
  boot.kernelParams = lib.mkForce [
    "console=ttyS1,115200n8"
    "console=tty0"
  ];

  homelab = {
    enable = true;
    hostName = "homepi";
    swap.enable = true;
    splash = true;
  };

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
