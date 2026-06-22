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
  * requires careful separation of concerns between image, container, and dev shell
    * takes a lot of experimentation to get right, but that's just a one-time cost hopefully
  * requires docker install

#### TODO

- [ ] Extract config files out of docker RUNs into files in .devcontainer
- [ ] see if there is a way to get a bash script / transform module options and materialize them in the dockerfile automatically
- [ ] user? should it be root? why or why not?
  - [ ] at least figure out a way to have ssh users be more sensible than root
