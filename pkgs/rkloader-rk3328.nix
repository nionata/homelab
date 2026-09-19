# The nixpkgs rkbin package only installs DDR/ATF blobs for U-Boot compilation.
# This derivation pulls the RK3328 maskrom loader from the same source tree so
# rkdeveloptool db has something to send in maskrom mode.
{ rkbin, runCommand }:
runCommand "rkloader-rk3328" { } ''
  mkdir -p $out/bin
  cp ${rkbin.src}/bin/rk33/rk3328_loader_*.bin $out/bin/
''
