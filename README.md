## Zigbee

Zigbee is the preferred wireless protocol for smart devices in my home. The protocol is designed to be run local only unlike wifi devices. The pairing model is sane. Currently the devices are managed by Home Assistant's ZHA integration. I may switch to Zigbee2Mqtt at some point.

| Device | Model | Role |
|--------|-------|------|
| SONOFF Dongle Plus MG24 | Dongle Plus MG24 | Zigbee coordinator (USB) |
| SONOFF SNZB-04PR2 | SNZB-04PR2 | Door/window sensor | Custom quirk — see `pkgs/zha-quirk-snzb04pr2.nix` |
| SONOFF SNZB-09P | SNZB-09P | Siren | No upstream quirk |
| SONOFF SNZB-01M | SNZB-01M | Wireless button | Battery-powered sleepy device; OTA updates and identity calls are unreliable |
| Third Reality Smart Switch (x2) | 3RSP02064Z | Smart switch | Upstream quirk exists but `on_to_off_delay` attribute unsupported by device firmware |
| Third Reality Color Bulb (x2) | 3RCB01057Z | Color bulb | |

## Dev Environment

### Dev Container

TODO(https://github.com/nionata/dotfiles/issues/10): Move to dotfiles repo

https://code.visualstudio.com/docs/devcontainers/containers

Run a Linux-based development environment seamlessly on macOS. A Container Management Platform like Docker Desktop, OrbStack, [Container](https://opensource.apple.com/projects/container/), [colima](https://github.com/abiosoft/colima), etc manage the Linux guest VM. VSCode manages starting and attaching to a container in the VM with deep integration to make it feel invisible. 

The Container Management Platforms leverage Apple’s native [Virtualization.framework](https://developer.apple.com/documentation/virtualization) to spin up a lightweight Linux kernel. Since the host and container share the ARM64 architecture, the guest runs via direct, native CPU virtualization instead of slower emulation. Built-in hardware extensions execute the Linux instructions directly on the Apple chip at near-native speed.

The project source code lives directly on the host's native APFS filesystem and is shared with the Linux container via [VirtioFS](https://virtio-fs.gitlab.io/) (implemented by [macOS](https://developer.apple.com/documentation/virtualization/shared-directories)). Credentials and other host context is easily mounted or bridged into the Dev Container. Volumes are leveraged to cache artifacts: nix store `/nix`, cargo `target`, packages `.cargo`, and `ssh_known_hosts`. I/O on the volume runs at near-native VM speeds. This is far faster than the bind-mounted file operations.

#### Notes

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
