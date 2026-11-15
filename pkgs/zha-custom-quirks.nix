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
  # generic handler. Import each one here so a break fails the build instead.
  postBuild = ''
    ${python.interpreter} -I -B -c '
    import importlib.util, pathlib, sys
    for path in sorted(pathlib.Path(sys.argv[1]).glob("*.py")):
        print(f"importing {path.name}")
        spec = importlib.util.spec_from_file_location(path.stem, path)
        spec.loader.exec_module(importlib.util.module_from_spec(spec))
    ' $out
  '';
}
