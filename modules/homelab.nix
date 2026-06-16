{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.homelab;
in
{

  options.homelab = {
    enable = lib.mkEnableOption "Whether to enable homelab things";

    hostName = lib.mkOption {
      description = "The hostname of the lab device";
      type = lib.types.str;
      example = "homepi";
    };
  };

  config = lib.mkIf cfg.enable {
    # --- Networking ---
    # TODO: figure out what's going on during boot. Are we blocking or not?
    networking = {
      hostName = cfg.hostName;
      # Use networkd
      useNetworkd = true;
      # Don't use legacy DHCP
      useDHCP = false;

      wireless.iwd = {
        enable = true;
        settings = {
          Settings = {
            AutoConnect = true;
          };
          Network = {
            EnableIPv6 = true;
          };
        };
      };
    };

    systemd.network = {
      enable = true;
      networks = {
        # Handle any plugged-in Ethernet cable
        "20-ethernet-dhcp" = {
          matchConfig.Name = "en*";
          networkConfig = {
            DHCP = "yes";
            # Fallback to link-local ipv4 or ipv6 when DHCP connection fails
            LinkLocalAddressing = "yes";
          };
        };
        # Handle the Wi-Fi connection once wpa_supplicant authenticates it
        "30-wifi-dhcp" = {
          matchConfig.Name = "wl*";
          networkConfig.DHCP = "yes";
          networkConfig.IgnoreCarrierLoss = "3s";
        };
      };
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
  };
}
