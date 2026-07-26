{
  config,
  lib,
  ...
}:
let
  cfg = config.homelab.bartTender;
in
{
  options.homelab.bartTender = lib.mkEnableOption "serve the bart-tender WASM app at /bart-tender";

  config = lib.mkIf cfg {
    systemd.tmpfiles.rules = [
      "d /var/www/bart-tender 0755 nginx nginx -"
    ];

    services.nginx = {
      enable = true;
      virtualHosts."localhost" = {
        locations."/bart-tender" = {
          return = "301 /bart-tender/";
        };
        locations."/bart-tender/" = {
          alias = "/var/www/bart-tender/";
          tryFiles = "$uri $uri/ /bart-tender/index.html";
        };
      };
    };

    networking.firewall.allowedTCPPorts = [ 80 ];
  };
}
