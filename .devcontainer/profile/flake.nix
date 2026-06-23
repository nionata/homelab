# This flake default package set contains all the packages that should be installed to the nix profile.
# These packages will be baked into the docker image itself. The first volume mount
# will copy the image's `/nix` directory that includes this profile.

{
  inputs = {
    parent.url = "path:./../..";
  };

  outputs =
    { self, parent }:
    let
      pkgs = import parent.inputs.nixpkgs {
        system = "aarch64-linux";
        config.allowUnfree = true;
      };
    in
    {
      packages.aarch64-linux.default = pkgs.buildEnv {
        name = "devcontainer-profile";
        paths = with pkgs; [
          # Shell
          zsh
          fzf
          starship
          # Dev
          git
          vim
          man
          openssh
          less
          ps
          claude-code
          # Networking
          unixtools.ping
          # Build and deploy
          nixos-rebuild
          # # Direnv to source dev shells
          direnv
          nix-direnv
          # IDE
          rust-analyzer
        ];
      };
      devShells.aarch64-linux.default = pkgs.mkShell {
        buildInputs = with pkgs; [
        ];

        # IDE: rust-analyzer
        RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
      };
    };
}
