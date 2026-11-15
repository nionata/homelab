# ZHA takes a single custom_quirks_path and imports every module in it, so all
# custom quirks are joined into one directory.
{
  symlinkJoin,
  home-assistant,
  zhaquirkSnzb04pr2,
  zhaquirkSnzb09p,
}:
let
  # Same zigpy/zha-quirks that Home Assistant runs, so the import check is meaningful.
  python = home-assistant.python3Packages.python.withPackages (ps: [ ps.zha-quirks ]);
in
symlinkJoin {
  name = "zha-custom-quirks";
  paths = [
    # Door/window sensor tamper detection
    zhaquirkSnzb04pr2
    # Siren start/stop, sound, volume, and duration over 0xFC11
    zhaquirkSnzb09p
  ];

  # ZHA logs and skips a quirk that fails to import, leaving the device on its
  # generic handler. Load them here the way ZHA does so a break fails the build,
  # and fail once zha-quirks ships its own quirk for one of these devices.
  postBuild = ''
    ${python.interpreter} -I -B ${./zha-custom-quirks-check.py} $out
  '';
}
