# test-nspawn-hello.nix
{
  name = "nspawn-hello";

  # systemd-nspawn containers instead of QEMU VMs
  containers = {
    server = { pkgs, ... }: {
      networking.firewall.allowedTCPPorts = [ 8080 ];
      services.nginx = {
        enable = true;
        virtualHosts."_" = {
          listen = [{ addr = "0.0.0.0"; port = 8080; }];
          locations."/" = {
            return = "200 'hello from nspawn'";
            extraConfig = "add_header Content-Type text/plain;";
          };
        };
      };
    };

    client = { pkgs, ... }: {
      environment.systemPackages = [ pkgs.curl ];
    };
  };

  testScript = ''
    start_all()

    server.wait_for_unit("nginx.service")
    server.wait_for_open_port(8080)

    # containers share a VLAN and can reach each other by name
    response = client.succeed("curl -sf http://server:8080/")
    assert "hello from nspawn" in response, f"unexpected response: {response}"

    client.log(f"Got: {response}")
  '';
}