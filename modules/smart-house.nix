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
        "zeroconf"
      ];

      lovelaceConfigFile = ../dashboards/pat.yaml;

      config = {
        homeassistant = {
          name = "Home";
          unit_system = "us_customary";
          temperature_unit = "F";
        };

        http = { };
        frontend = { };

        # tplink (Kasa) does not support YAML config — add devices via the UI
      };
    };
  };
}
