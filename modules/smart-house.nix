# PAT — Personal Applied Technology (Smart House, 1999)
{
  config,
  lib,
  ...
}:
let
  cfg = config.homelab.smartHouse;
in
{
  options.homelab.smartHouse = lib.mkEnableOption "PAT home automation hub with Kasa smart switch support";

  config = lib.mkIf cfg {
    services.home-assistant = {
      enable = true;
      openFirewall = true;

      # default_config pulls in apple_tv (needs pyatv) and Bluetooth — avoid it.
      # zeroconf: mDNS discovery that tplink uses to find Kasa devices on the LAN
      extraComponents = [
        "frontend"
        "met"
        "tplink"
        "wled"
        "zeroconf"
        "mobile_app"
        "simplisafe"
      ];

      config = {
        homeassistant = {
          name = "Home";
          unit_system = "us_customary";
          temperature_unit = "F";
        };

        http = { };
        frontend = { };
        zeroconf = { };
        mobile_app = { };

        # Most integrations do not support YAML config and must be added via the UI:
        # - TP-Link Smart Home
        # - WLED (auto-discovered via zeroconf)
        # - System Monitor
        # - Simplisafe

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

        automation = [
          {
            alias = "Weekday Coffee";
            trigger = [
              {
                platform = "time";
                at = "06:35:00";
              }
            ];
            condition = [
              {
                condition = "time";
                weekday = [
                  "mon"
                  "tue"
                  "wed"
                  "thu"
                  "fri"
                ];
              }
            ];
            action = [
              {
                service = "switch.turn_on";
                target.entity_id = "switch.coffee_maker";
              }
              { delay.minutes = 10; }
              {
                service = "switch.turn_off";
                target.entity_id = "switch.coffee_maker";
              }
            ];
          }
          {
            alias = "Hatch Alarm";
            trigger = [
              {
                platform = "time";
                at = "06:15:00";
              }
            ];
            condition = [
              {
                condition = "time";
                weekday = [
                  "mon"
                  "tue"
                  "wed"
                  "thu"
                  "fri"
                ];
              }
            ];
            action = [
              {
                service = "light.turn_on";
                data = {
                  brightness_pct = 10;
                  rgb_color = [
                    255
                    147
                    0
                  ];
                  transition = 60;
                };
                target.entity_id = "light.hatch";
              }
              { delay.minutes = 3; }
              {
                service = "light.turn_on";
                data = {
                  brightness_pct = 30;
                  transition = 60;
                };
                target.entity_id = "light.hatch";
              }
              { delay.minutes = 3; }
              {
                service = "light.turn_on";
                data = {
                  brightness_pct = 55;
                  transition = 60;
                };
                target.entity_id = "light.hatch";
              }
              { delay.minutes = 3; }
              {
                service = "light.turn_on";
                data = {
                  brightness_pct = 80;
                  transition = 60;
                };
                target.entity_id = "light.hatch";
              }
              { delay.minutes = 3; }
              {
                service = "light.turn_on";
                data = {
                  brightness_pct = 100;
                  transition = 60;
                };
                target.entity_id = "light.hatch";
              }
            ];
          }
          {
            alias = "Weekend Coffee";
            trigger = [
              {
                platform = "time";
                at = "07:00:00";
              }
            ];
            condition = [
              {
                condition = "time";
                weekday = [
                  "sat"
                  "sun"
                ];
              }
            ];
            action = [
              {
                service = "switch.turn_on";
                target.entity_id = "switch.coffee_maker";
              }
              { delay.minutes = 10; }
              {
                service = "switch.turn_off";
                target.entity_id = "switch.coffee_maker";
              }
            ];
          }
        ];
      };
    };
  };
}
