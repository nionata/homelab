{ lib, rustPlatform }:

rustPlatform.buildRustPackage rec {
  pname = "hello-world-bin";
  version = "0.1.0";

  # Points to the local directory containing Cargo.toml and src/
  src = ../homed;

  # Nix will read your Cargo.lock directly. No hash required!
  cargoLock.lockFile = ../homed/Cargo.lock;

  meta = with lib; {
    description = "A simple Hello World binary in Rust";
    homepage = "https://github.com/nionata/homelab";
    license = licenses.mit;
    maintainers = [ "nionata" ];
    mainProgram = "homed";
  };
}
