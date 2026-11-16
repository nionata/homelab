# Full-screen browser on the attached display. Cage is a single-app Wayland
# compositor, so touch input goes straight to the page through libinput.

{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.homelab.kiosk;
in
{
  options.homelab.kiosk = {
    enable = lib.mkEnableOption "a full-screen browser kiosk on tty1";

    url = lib.mkOption {
      type = lib.types.str;
      description = "Page the kiosk opens on boot.";
      example = "http://homemac.local:8123/dashboard-home/0";
    };
  };

  config = lib.mkIf cfg.enable {
    # Owns the browser profile, so logins and cookies survive reboots.
    users.users.kiosk = {
      isNormalUser = true;
      home = "/var/lib/kiosk";
      createHome = true;
    };

    services.cage = {
      enable = true;
      user = "kiosk";
      # Allow switching virtual terminals, which cage blocks by default. With a
      # USB keyboard, Ctrl+Alt+F2 opens a login console on tty2 and Ctrl+Alt+F1
      # returns to the kiosk.
      extraArguments = [ "-s" ];
      program = lib.escapeShellArgs [
        "${pkgs.chromium}/bin/chromium"
        "--ozone-platform=wayland"
        "--kiosk"
        "--noerrdialogs"
        "--no-first-run"
        "--disable-session-crashed-bubble"
        "--disable-infobars"
        "--touch-events=enabled"
        # Report a dark color scheme to pages. HA's default "Auto" theme follows it.
        "--force-dark-mode"
        # Stop swipes from navigating back and forward.
        "--overscroll-history-navigation=0"
        cfg.url
      ];
    };

    # Cage exits when the browser does. Bring both back.
    systemd.services."cage-tty1".serviceConfig = {
      Restart = "always";
      RestartSec = 5;
    };
  };
}
