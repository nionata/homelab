{
  config,
  pkgs,
  modulesPath,
  ...
}:

{
  imports = [
    "${modulesPath}/profiles/qemu-guest.nix"
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  environment.systemPackages = with pkgs; [
    stdenv
    rust-analyzer
    git
    vim
  ];

  programs.nix-ld.enable = true;

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    trusted-users = [
      "root"
      "nionata"
    ];
  };

  # Lima injects SSH keys via cloud-init (CIDATA ISO attached to the VM)
  services.cloud-init.enable = true;

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  users.users.nionata = {
    uid = 501;
    isSystemUser = true;
    group = "users";
    createHome = true;
    home = "/home/nionata";
    homeMode = "700";
    useDefaultShell = true;
    extraGroups = [
      "wheel"
      "dialout"
      "uucp"
    ];
  };

  security.sudo.wheelNeedsPassword = false;
  users.mutableUsers = true;

  time.timeZone = "America/Los_Angeles";

  # DHCP on whichever virtio-net interface Lima provides
  networking.useNetworkd = true;
  systemd.network = {
    enable = true;
    networks."10-lima" = {
      matchConfig.Type = "ether";
      networkConfig.DHCP = "yes";
    };
  };

  system.stateVersion = "26.05";
}
