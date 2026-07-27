{
  config,
  lib,
  ...
}:
let
  cfg = config.homelab.bartTender;
in
{
  options.homelab.bartTender = lib.mkEnableOption "serve the bart WASM app at /bart";

  config = lib.mkIf cfg {
    systemd.tmpfiles.rules = [
      "d /var/www/bart 0755 nginx nginx -"
    ];

    services.nginx = {
      enable = true;
      virtualHosts."localhost" = {
        locations."/bart" = {
          return = "301 /bart/";
        };
        locations."/bart/" = {
          alias = "/var/www/bart/";
          tryFiles = "$uri $uri/ /bart/index.html";
        };
      };
    };

    networking.firewall.allowedTCPPorts = [ 80 ];
  };
}
