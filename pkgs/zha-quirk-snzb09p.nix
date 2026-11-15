# ZHA quirk for the Sonoff SNZB-09P siren (SenseGuard Indoor Siren).
# Without it ZHA exposes the generic IAS WD siren, which mis-handles stop (turn_off
# re-triggers a 5 s alarm) and has no sound/volume/duration controls. The quirk
# drives the siren through SONOFF's 0xFC11 cluster instead.
#
# Source is SONOFF's upstream PR, https://github.com/zigpy/zha-device-handlers/pull/5136
# (tracking issue #5310). It supersedes the zip SONOFF links from the SmartHomeScene
# review: it adds the chime presets for firmware >= 1.1.9 and gates them on version.
# Drop this package once the PR ships in the zha-quirks release nixpkgs pins.
{ fetchurl }:
let
  rev = "bb124d077803a20dda28cec53dce0cddd5541088";
in
fetchurl {
  name = "zha-quirk-snzb09p";
  url = "https://raw.githubusercontent.com/Oniums/zha-device-handlers/${rev}/zhaquirks/sonoff/snzb09p.py";
  downloadToTemp = true;
  recursiveHash = true;
  # keep the file distinct from the upstream module name to avoid confusion once zhaquirks.sonoff.snzb09p exists.
  postFetch = ''
    mkdir $out
    mv $downloadedFile $out/sonoff_snzb09p.py
  '';
  hash = "sha256-97Ny9mneP4nsPKxNcIwJ4+Dh8SnGnmN5U6m7Khyl4XE=";
}
