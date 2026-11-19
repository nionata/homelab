{
  lib,
  stdenvNoCC,
  fetchurl,
}:

let
  version = "0.21.0";
  # Hashes come from checksums/v${version}.sha256 on the main branch of
  # reolink/reolink-cli. Don't use the .sha256 files attached to the release.
  # Anyone with write access can replace those alongside the archive.
  targets = {
    x86_64-linux = {
      suffix = "linux-x86_64-musl";
      sha256 = "5d2031b8c0379e5dd2cf515fc43aeb037858d6bad922ff9a33cf3303ce601cf3";
    };
    aarch64-linux = {
      suffix = "linux-arm64-musl";
      sha256 = "6d06d09163d900e7ff12b13be60db3cdd9347c798575cfcdea0ff973a6ec48d1";
    };
  };
  system = stdenvNoCC.hostPlatform.system;
  target = targets.${system} or (throw "reolink-cli: unsupported system ${system}");
  name = "reolink-cli-${version}-external-${target.suffix}";
in
stdenvNoCC.mkDerivation {
  pname = "reolink-cli";
  inherit version;

  src = fetchurl {
    url = "https://github.com/reolink/reolink-cli/releases/download/v${version}/${name}.tar.gz";
    inherit (target) sha256;
  };

  sourceRoot = name;
  dontBuild = true;
  dontStrip = true;

  # The musl builds are statically linked, so no patching is needed. Only the
  # two binaries are installed. Bundled install scripts and plugins are ignored.
  installPhase = ''
    runHook preInstall
    install -Dm755 bin/reolink-cli $out/bin/reolink-cli
    install -Dm755 bin/reolink-gateway $out/bin/reolink-gateway
    runHook postInstall
  '';

  meta = {
    description = "Reolink camera CLI and gateway (LAN only)";
    homepage = "https://github.com/reolink/reolink-cli";
    # The repo is Apache-2.0 but the released binaries ship under a proprietary EULA.
    license = lib.licenses.unfree;
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
    platforms = builtins.attrNames targets;
    mainProgram = "reolink-cli";
  };
}
