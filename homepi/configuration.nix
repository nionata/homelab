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

  # --- Bootloader Configuration ---
  # Raspberry Pi 3 boots natively using the generic extlinux structure
  # included in the standard aarch64 SD image.
  boot.loader.grub.enable = false;
  # Enables the generation of /boot/extlinux/extlinux.conf
  boot.loader.generic-extlinux-compatible.enable = true;

  # --- Raspberry Pi 3 Specific Hardware & Firmware ---
  # Essential firmware for the Pi 3's Broadcom Wi-Fi, Bluetooth, and VideoCore GPU
  hardware.enableRedistributableFirmware = true;
  # For the hardware serial console (UART) if you use a console cable
  # On Pi 3, ttyS1 or ttyAMA0 is used depending on Bluetooth allocation
  boot.kernelParams = lib.mkForce [
    "console=ttyS1,115200n8"
    "console=tty0"
  ];

  # --- Memory Management for 1GB RAM ---
  # NixOS rebuilding is heavy. Without swap, a 1GB Pi 3 will hit Out-Of-Memory (OOM)
  # errors and freeze during updates.
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 2048; # 2GB Swap file
    }
  ];

  # --- Networking ---
  networking = {
    hostName = "homepi";
    wireless.enable = true; # Enables wpa_supplicant for Wi-Fi
    networkmanager.enable = true; # Configure network connections interactively with nmcli or nmtui.
  };

  networking.interfaces.enu1u1 = {
    # Explicitly enable DHCP on this interface
    useDHCP = true;
    # Static address as a fallback for direct debug
    ipv4.addresses = [
      {
        address = "192.168.99.1";
        prefixLength = 24; # Subnet mask 255.255.255.0
      }
    ];
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true; # Allows resolving other .local items over IPv4
    openFirewall = true; # Automatically opens UDP port 5353 in the NixOS firewall

    publish = {
      enable = true;
      addresses = true; # Broadcasts the machine's IP address
      workstation = true; # Broadcasts a generic workstation service descriptor
    };
  };

  # --- Access & Security ---
  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = "yes";

  users.users = {
    nionata = {
      isNormalUser = true;
      extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
      password = "password";
    };
    root = {
      initialPassword = "changeme"; # set a password with ‘passwd’.
    };
  };

  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    vim
    htop
    tree
    tmux
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
