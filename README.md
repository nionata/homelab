## Dev Environment

### Dev Container

* Pro
  * Great integration with vscode
  * Feels pretty native
  * Abstracts me from having to write Dockerfiles/dockercompose myself
  * Store is a nice shared volume
  * networking works
  * can run full nix builds
  * very minimal infra... kinda just works
  * don't need to install nix on host
* Con
  * I miss full nixos module options  
  * requires some careful interplay between dev container and dev shell
  * requires docker install

  "postCreateCommand": "nix profile install nixpkgs#direnv nixpkgs#nix-direnv && cp /tmp/.zshrc /root/.zshrc && echo 'eval \"$(direnv hook zsh)\"' >> ~/.zshrc && cd /workspaces/homelab",

  "postStartCommand": "nix develop -c zsh"

https://github.com/apple/containerization