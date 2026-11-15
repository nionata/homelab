# PAT — Personal Applied Technology (Smart House, 1999)
{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.homelab.smartHouse;
in
{
  options.homelab.smartHouse = lib.mkEnableOption "PAT home automation hub with Kasa smart switch support";

  config = lib.mkIf cfg {
    networking.firewall.allowedTCPPorts = [ 8123 ];

    systemd.tmpfiles.rules = [
      # HA's local media dir (media_source) must exist and be writable for uploads.
      "d /var/lib/hass/media 0750 hass hass -"

      # The UI editors write to fixed paths in the config dir. HA fails to load
      # config if an !include target is missing, so seed them. `f` never
      # overwrites an existing file.
      "f /var/lib/hass/automations.yaml 0644 hass hass -"
      "f /var/lib/hass/scenes.yaml 0644 hass hass -"
      "f /var/lib/hass/scripts.yaml 0644 hass hass -"

      # Seed dashboards on a fresh install. `C` only copies if the target is
      # missing, so UI edits survive. Copy the live files back here to check
      # them in. HA creates .storage itself, but the seeds need it first.
      "d /var/lib/hass/.storage 0700 hass hass -"
      "C /var/lib/hass/.storage/lovelace_dashboards 0644 hass hass - ${./dashboards/registry.json}"
      "C /var/lib/hass/.storage/lovelace.dashboard_home 0644 hass hass - ${./dashboards/home.json}"
    ];

    services.home-assistant = {
      enable = true;

      # Declare the desired integrations so they will be available at runtime.
      # default_config is intentionally excluded — it pulls in bluetooth and
      # other unwanted integrations. USB/bluetooth log noise comes from the
      # hardware integration which is always loaded and cannot be disabled.
      extraComponents = [
        # Enables airplay to devices.
        # Zeroconf discovery of Apple devices on the LAN starts apple_tv config.
        "apple_tv"
        # UI
        "frontend"
        # weather
        "met"
        # mDNS: DNS-SD and host resolution
        "zeroconf"
        # App
        "mobile_app"
        # wled
        "wled"
        # Zigbee hub
        "zha"
        # Local media and the Media panel. Also needed to play TTS.
        "media_source"
        # CPU, memory, disk, and network sensors
        "systemmonitor"
        # Sun position and dawn/dusk sensors
        "sun"
      ];

      config = {
        homeassistant = {
          name = "Home";
          unit_system = "us_customary";
          temperature_unit = "F";
        };

        # Declaring the integrations below ensures they are loaded on boot.
        # Integrations without YAML setup (apple_tv, met, systemmonitor, wled,
        # and the zha radio itself) must be added once in the UI. Discovery
        # prompts for most of them. Their config entries persist in
        # /var/lib/hass/.storage.
        frontend = { };
        zeroconf = { };
        mobile_app = { };
        media_source = { };
        zha.custom_quirks_path = "${pkgs.zhaCustomQuirks}";
        sun = { };

        alarm_control_panel = [
          {
            platform = "manual";
            name = "Home Alarm";
            code = "1234";
            code_arm_required = false;
            arming_time = 10;
            delay_time = 10;
            trigger_time = 120;
          }
        ];

        # Declarative automations, scenes, and scripts live as YAML next to this file.
        # Same format the UI writes, so entries can be checked in verbatim.
        "automation nix" = "!include ${./automations.yaml}";
        "scene nix" = "!include ${./scenes.yaml}";
        "script nix" = "!include ${./scripts.yaml}";

        # Accept automation, scenes, and scripts imperatively added in the UI.
        # These should be checked in after initial experimentation.
        "automation ui" = "!include /var/lib/hass/automations.yaml";
        "scene ui" = "!include /var/lib/hass/scenes.yaml";
        "script ui" = "!include /var/lib/hass/scripts.yaml";
      };
    };
  };
}
