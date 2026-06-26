# test-nspawn-hello.nix
{
  name = "homed";

  containers = {
    homepi = { pkgs, ... }: {
      environment.systemPackages = [ pkgs.homed ];
    };
  };

  requiredFeatures.kvm = false;

  testScript = ''
    start_all()

    response = homepi.succeed("homed")
    print(response + ": live from systemd-nspawn")
  '';
}