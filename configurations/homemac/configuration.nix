# Configuration for a MacBook Pro 11,4 (Mid 2015, 15") run as a headless server

{ ... }:

let
  # homepi over Tailscale
  kioskIp = "100.80.209.122/32";
in
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Blank the built-in display after 5 minutes idle at the console.
  boot.kernelParams = [ "consoleblank=300" ];

  # Machine must always be on. Closing the lid must not suspend the server.
  services.logind.settings.Login.HandleLidSwitch = "ignore";

  homelab = {
    enable = true;
    hostName = "homemac";
    smartHouse.enable = true;
  };

  # The homepi kiosk logs in without a password. It's matched by its Tailscale
  # IP and can only be the non-admin kiosk user.
  services.home-assistant.config.homeassistant.auth_providers = [
    {
      type = "trusted_networks";
      trusted_networks = [ kioskIp ];
      trusted_users.${kioskIp} = [ "f16568c513d54e3eaf1b919369c19a55" ];
      allow_bypass_login = true;
    }
  ];

  # Run an iperf3 server for network benchmarking.
  # openFirewall only opens TCP. Add UDP manually for iperf3 UDP tests.
  services.iperf3 = {
    enable = true;
    openFirewall = true;
  };
  networking.firewall.allowedUDPPorts = [ 5201 ];

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
