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
  * requires some careful separation of concerns between image, container, and dev shell
  * requires docker install

#### TODO

- [ ] rust analyzer working
- [ ] tailscale?
  - [ ] prob install on the host and call it a day
- [ ] see if there is a way to get a bash script / transform module options and materialize them in the dockerfile automatically
- [ ] user? should it be root? why or why not?
  - [ ] at least figure out a way to have ssh users be more sensible than root

#### Extra Config

To drop into nix develop on container start add this to `devcontainer.json`:

```json
  "postStartCommand": "nix develop"
```

To drop into nix develop on all new integrated terminal sessions add this to `devcontainer.json`:

```json
  "customizations": {
    "vscode": {
        "settings": {
            "terminal.integrated.defaultProfile.linux": "nix develop",
            "terminal.integrated.profiles.linux": {
                "nix develop": {
                    "path": "nix",
                    "args": ["develop"]
                }
            },
        }
    }
  }
```

To get rust-analyzer plugin to use your local copy add this to `devcontainer.json`:

```json
"customizations": {
  "vscode": {
      "settings": {
          "rust-analyzer.server.path": "rust-analyzer"
      }
  }
}
```

To prompt for rust analyzer:

```json
  "customizations": {
    "vscode": {
      "extensions": [
        "rust-lang.rust-analyzer"
      ]
    }
  }
```