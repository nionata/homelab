{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.homelab.usbipServer;
  usbip = pkgs.linuxPackages.usbip;

  usbipBin = "${usbip}/bin/usbip";

  rebindScript = pkgs.writeShellScript "usbip-rebind" (
    lib.concatMapStringsSep "\n" (
      binding:
      let
        b = binding.busId;
        desc = lib.optionalString (binding.description != "") " (${binding.description})";
      in
      ''
        if [ -d /sys/bus/usb/devices/${b} ] && [ ! -e /sys/bus/usb/drivers/usbip-host/${b} ]; then
          echo "usbip-rebind: binding ${b}${desc}"
          ${usbipBin} bind -b ${b} 2>&1 || true
        fi
      ''
    ) cfg.bindings
  );
in
{
  options.homelab.usbipServer = {
    enable = lib.mkEnableOption "USB/IP server for sharing USB devices over the network";

    bindings = lib.mkOption {
      description = "USB devices to auto-bind, identified by bus ID (e.g. '1-4')";
      type = lib.types.listOf (
        lib.types.submodule {
          options = {
            busId = lib.mkOption {
              type = lib.types.str;
              description = "USB bus ID as shown by `usbip list -l` (e.g. '1-4')";
              example = "1-4";
            };
            description = lib.mkOption {
              type = lib.types.str;
              default = "";
              description = "Human-readable label for log messages";
            };
          };
        }
      );
      default = [ ];
      example = [
        {
          busId = "1-4";
          description = "FTDI USB-Serial";
        }
      ];
    };

    openFirewall = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Open TCP port 3240 in the firewall";
    };
  };

  config = lib.mkIf cfg.enable {
    boot.kernelModules = [ "usbip_host" ];

    environment.systemPackages = [ usbip ];

    networking.firewall.allowedTCPPorts = lib.mkIf cfg.openFirewall [ 3240 ];

    # Detect sleeping/dead clients within ~90 seconds:
    #   60s idle → start probing, 3×10s probes → declare dead
    boot.kernel.sysctl = {
      "net.ipv4.tcp_keepalive_time" = 60;
      "net.ipv4.tcp_keepalive_intvl" = 10;
      "net.ipv4.tcp_keepalive_probes" = 3;
    };

    # Allow wheel users to run usbip without a password (needed for ssh-based
    # forced rebind from the client script)
    security.sudo.extraRules = [
      {
        groups = [ "wheel" ];
        commands = [
          {
            command = usbipBin;
            options = [ "NOPASSWD" ];
          }
        ];
      }
    ];

    systemd.services.usbipd = {
      description = "USB/IP daemon";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        ExecStart = "${usbip}/bin/usbipd";
        Restart = "on-failure";
        RestartSec = "5s";
      };
    };

    # Single service used by both the udev hotplug trigger and the periodic
    # timer. The script checks sysfs so it's safe to run at any time.
    systemd.services.usbip-rebind = {
      description = "Bind/rebind USB/IP devices";
      after = [ "usbipd.service" ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = rebindScript;
      };
    };

    # Trigger rebind when a configured device is hotplugged.
    # ENV{DEVTYPE}=="usb_device" fires once per device, not per interface.
    services.udev.extraRules = lib.concatMapStringsSep "\n" (
      binding:
      ''SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", KERNEL=="${binding.busId}", ACTION=="add", TAG+="systemd", ENV{SYSTEMD_WANTS}="usbip-rebind.service"''
    ) cfg.bindings;

    # Periodic rebind to recover devices after a client disconnects (cleanly or
    # not). With the TCP keepalive settings above, the kernel marks a dead
    # client's port free within ~90s; this timer then re-exports the device.

    systemd.timers.usbip-rebind = {
      description = "Periodic USB/IP rebind check";
      wantedBy = [ "timers.target" ];
      timerConfig = {
        OnBootSec = "30s";
        OnUnitActiveSec = "30s";
      };
    };
  };
}
