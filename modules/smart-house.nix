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

    services.home-assistant = {
      enable = true;

      # default_config is intentionally excluded — it pulls in bluetooth, apple_tv,
      # and other unwanted integrations. USB/bluetooth log noise comes from the
      # hardware integration which is always loaded and cannot be disabled.
      extraComponents = [
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
      ];

      config = {
        homeassistant = {
          name = "Home";
          unit_system = "us_customary";
          temperature_unit = "F";
        };

        # extraComponents ensures the integration is available to be loaded.
        # Declaring the integrations below ensures they are loaded on boot.
        # WLED is discovered via zeroconf but must be confirmed once in the UI
        http = { };
        frontend = { };
        zeroconf = { };
        mobile_app = { };
        # Add tamper detection sensor patch
        zha.custom_quirks_path = "${pkgs.zhaquirkSnzb04pr2}";

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

        scene = [
          {
            id = "closing_time";
            name = "Closing time";
            entities = {
              "switch.lamp_switch".state = "off";
              "light.hatch".state = "off";
              "light.lamp_light".state = "off";
              "light.office_light".state = "off";
            };
          }
          {
            id = "evening_lights";
            name = "Evening lights";
            entities = {
              "switch.lamp_switch".state = "on";
              "light.hatch" = {
                state = "on";
                brightness_pct = 30;
                rgb_color = [
                  255
                  147
                  0
                ];
              };
              "light.lamp_light" = {
                state = "on";
                brightness_pct = 30;
                color_temp_kelvin = 2700;
              };
              "light.office_light" = {
                state = "on";
                brightness_pct = 30;
                color_temp_kelvin = 2700;
              };
            };
          }
        ];

        # Accept automation imperatively added in the UI
        "automation manual" = "!include /var/lib/hass/automations.yaml";

        automation = [
          {
            id = "evening_lights";
            alias = "Evening Lights";
            trigger = [
              {
                platform = "sun";
                event = "sunset";
                offset = "-00:45:00";
              }
            ];
            action = [
              {
                service = "scene.turn_on";
                target.entity_id = "scene.evening_lights";
              }
            ];
          }
          {
            id = "weekday_coffee";
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
            id = "hatch_alarm";
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
            id = "device_offline_alert";
            alias = "Device Offline Alert";
            trigger = [
              {
                platform = "event";
                event_type = "state_changed";
              }
            ];
            condition = [
              {
                condition = "template";
                value_template = ''
                  {{ trigger.event.data.new_state is not none
                     and trigger.event.data.new_state.state == 'unavailable'
                     and (trigger.event.data.old_state is none
                          or trigger.event.data.old_state.state != 'unavailable')
                     and trigger.event.data.new_state.entity_id.split('.')[0] in [
                       'light', 'switch', 'sensor', 'binary_sensor',
                       'device_tracker', 'media_player', 'climate'
                     ] }}'';
              }
            ];
            action = [
              {
                action = "notify.send_message";
                target.entity_id = [
                  "notify.nick_iphone"
                  "notify.ciaras_iphone"
                ];
                data = {
                  title = "Device Offline";
                  message = "{{ trigger.event.data.new_state.name | default('Unknown device') }} is unavailable";
                };
              }
              {
                service = "persistent_notification.create";
                data = {
                  title = "Device Offline";
                  message = "{{ trigger.event.data.new_state.name | default('Unknown device') }} is unavailable";
                  notification_id = "offline_{{ trigger.event.data.new_state.entity_id | default('unknown') }}";
                };
              }
            ];
          }
          {
            id = "weekend_coffee";
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
