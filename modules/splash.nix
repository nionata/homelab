{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.homelab.splash;
in
{
  options.homelab.splash = lib.mkEnableOption "host a static splash page at localhost:80";

  config = lib.mkIf cfg {
    services.nginx = {
      enable = true;
      virtualHosts."localhost" = {
        root = ../splash;
      };
    };

    networking.firewall.allowedTCPPorts = [ 80 ];
  };
}
