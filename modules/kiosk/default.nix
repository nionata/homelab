# Full-screen web page on the attached display. Cage is a single-app Wayland
# compositor, so touch input goes straight to the page through libinput. The
# page runs in a bare WebKitGTK view (kiosk.js) instead of a full browser, to
# fit in the Pi 3's 1GB of RAM.

{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.homelab.kiosk;

  # wrapGAppsHook4 sets the GObject typelib, GIO module, and schema paths that
  # gjs needs to load GTK and WebKit.
  kiosk = pkgs.stdenvNoCC.mkDerivation {
    name = "kiosk";
    dontUnpack = true;
    nativeBuildInputs = with pkgs; [
      wrapGAppsHook4
      gobject-introspection
    ];
    buildInputs = with pkgs; [
      gjs
      gtk4
      webkitgtk_6_0
      glib-networking
    ];
    installPhase = ''
      install -Dm644 ${./kiosk.js} $out/share/kiosk/kiosk.js
      mkdir -p $out/bin
      printf '#!%s\nexec %s -m %s "$@"\n' ${pkgs.runtimeShell} ${pkgs.gjs}/bin/gjs \
        $out/share/kiosk/kiosk.js > $out/bin/kiosk
      chmod +x $out/bin/kiosk
    '';
  };
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
    # Owns the WebKit data dir, so logins and cookies survive reboots.
    users.users.kiosk = {
      isNormalUser = true;
      home = "/var/lib/kiosk";
      createHome = true;
    };

    services.cage = {
      enable = true;
      user = "kiosk";
      # Restart the kiosk on switch so config changes apply right away. The screen blanks for a few seconds while it does.
      restartIfChanged = true;
      # Allow switching virtual terminals, which cage blocks by default. With a
      # USB keyboard, Ctrl+Alt+F2 opens a login console on tty2 and Ctrl+Alt+F1
      # returns to the kiosk.
      extraArguments = [ "-s" ];
      environment = {
        # The Pi 3's GPU only does OpenGL ES 2.0 and GTK4 needs 3.0. Skip the
        # failed GL probe and render in software from the start.
        GSK_RENDERER = "cairo";
        # bwrap refuses to start WebKit's page sandbox here, and WebKit aborts
        # without it. The kiosk only loads our own Home Assistant.
        WEBKIT_DISABLE_SANDBOX_THIS_IS_DANGEROUS = "1";
      };
      program = lib.escapeShellArgs [
        "${kiosk}/bin/kiosk"
        cfg.url
      ];
    };

    # getty.target asks for a login on tty1. A switch starts it, and it
    # conflicts with cage, so the kiosk gets stopped. Display managers skip it
    # the same way. tty1 is the only entry.
    systemd.targets.getty.wants = lib.mkForce [ ];

    # Cage exits when the kiosk app does. Bring both back.
    systemd.services."cage-tty1".serviceConfig = {
      Restart = "always";
      RestartSec = 5;
    };
  };
}
