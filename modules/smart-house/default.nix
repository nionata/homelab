# PAT — Personal Applied Technology (Smart House, 1999)
{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.homelab.smartHouse;

  # pyatv with its AirPlay ports pinned (see the airplay*Port options)
  packageOverrides = _: super: {
    pyatv = super.pyatv.overridePythonAttrs (old: {
      postPatch = (old.postPatch or "") + ''
        substituteInPlace pyatv/settings.py \
          --replace-fail "timing_port: int = 0" "timing_port: int = ${toString cfg.airplayTimingPort}" \
          --replace-fail "control_port: int = 0" "control_port: int = ${toString cfg.airplayControlPort}"
      '';
    });
  };

  # Install checks stay off as in the NixOS module's default package, since
  # they run HA's own test suite.
  homeAssistant = (pkgs.home-assistant.override { inherit packageOverrides; }).overrideAttrs {
    doInstallCheck = false;
  };

  airplayPortNote = ''
    pyatv binds this at random (port 0) unless set, and Home Assistant's
    apple_tv integration never sets it. It's pinned so the firewall can allow
    it. See https://github.com/postlund/pyatv/issues/2559.
  '';
in
{
  options.homelab.smartHouse = {
    enable = lib.mkEnableOption "PAT home automation hub with Kasa smart switch support";

    airplayTimingPort = lib.mkOption {
      type = lib.types.port;
      description = ''
        UDP port pyatv's AirPlay timing server binds on.
        ${airplayPortNote}'';
      default = 6020;
    };

    airplayControlPort = lib.mkOption {
      type = lib.types.port;
      description = ''
        UDP port pyatv's AirPlay control server binds on.
        ${airplayPortNote}'';
      default = 6021;
    };
  };

  config = lib.mkIf cfg.enable {
    networking.firewall.allowedTCPPorts = [ 8123 ];

    # Reolink camera CLI. The released binaries are under a proprietary EULA.
    nixpkgs.config.allowUnfreePredicate = pkg: lib.getName pkg == "reolink-cli";
    environment.systemPackages = [ pkgs.reolink-cli ];

    # AirPlay (apple_tv/pyatv) streaming to shairport-sync receivers. In classic
    # AirPlay the receiver sends clock-sync requests to pyatv's timing port and
    # resend requests to its control port. Nothing outbound opens conntrack
    # state for those, so the firewall must allow them. The pyatv override
    # below pins both. Only one stream can run at a time with fixed ports.
    networking.firewall.allowedUDPPorts = [
      cfg.airplayTimingPort
      cfg.airplayControlPort
    ];

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
      "C /var/lib/hass/.storage/lovelace.map 0644 hass hass - ${./dashboards/map.json}"
    ];

    # Piper text-to-speech, served to HA over the Wyoming protocol. Only HA
    # uses it, so it binds to localhost. Zeroconf advertises the bind address,
    # so HA discovers it at 127.0.0.1 and nothing is exposed on the LAN. The
    # voice model is downloaded into /var/lib/wyoming/piper on first start.
    # Samples: https://rhasspy.github.io/piper-samples/
    services.wyoming.piper.servers.ha = {
      enable = true;
      voice = "en_US-norman-medium";
      uri = "tcp://127.0.0.1:10200";
    };

    services.home-assistant = {
      enable = true;

      package = homeAssistant;

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
        # State history DB and long-term statistics
        "recorder"
        # History panel and entity graphs
        "history"
        # Logbook panel
        "logbook"
        # Talks to the local Piper text-to-speech server
        "wyoming"
        # Reolink cameras and doorbells. ONVIF push events arrive on the HA
        # webhook (port 8123), which is already open.
        "reolink"
      ];

      config = {
        homeassistant = {
          name = "Home";
          unit_system = "us_customary";
          temperature_unit = "F";
          auth_providers = lib.mkBefore [ { type = "homeassistant"; } ];
        };

        # Declaring the integrations below ensures they are loaded on boot.
        # Integrations without YAML setup (apple_tv, met, reolink, systemmonitor,
        # wled, and the zha radio itself) must be added once in the UI. Discovery
        # prompts for most of them. Their config entries persist in
        # /var/lib/hass/.storage.
        frontend = { };
        zeroconf = { };
        mobile_app = { };
        media_source = { };
        zha.custom_quirks_path = "${pkgs.zhaCustomQuirks}";
        sun = { };
        history = { };
        logbook = { };

        # State history DB in /var/lib/hass. Raw states are purged after
        # purge_keep_days. Long-term statistics (hourly aggregates for sensors
        # with a state_class) are kept indefinitely. 3 years of raw states is
        # an estimated ~10 GB at ~8 MB/day.
        recorder = {
          purge_keep_days = 1095;
          commit_interval = 30;
        };

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

    # Build the patched pyatv:
    # nix build .#nixosConfigurations.<host>.config.system.build.pyatv
    system.build.pyatv = homeAssistant.python3Packages.pyatv;
  };
}
