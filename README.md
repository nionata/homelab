## Bringing Up a Host

Every host enables the `homelab` module (`modules/homelab.nix`), which provides networkd + iwd networking, avahi (mDNS), tailscale, ssh, and the `nionata` user. These steps take a machine from a fresh NixOS install to reachable on the LAN and tailnet.

### 1. Install NixOS

- **SD card boards** (homepi, homeroc): flash the SD image. See `configurations/<host>/README.md`.
- **Everything else** (homemac): install from the NixOS installer ISO, then copy the generated `hardware-configuration.nix` into `configurations/<host>/`.

### 2. Deploy the config

From the dev container, push the host's config:

```sh
nixos-rebuild boot --flake .#<host> --target-host <user>@<ip> --ask-sudo-password
```

- Use `boot` rather than `switch` on the first deploy. It can swap the network stack (e.g. NetworkManager to networkd + iwd), and `switch` would then drop the connection mid-activation. Reboot afterwards from the console.
- `<user>` is whatever sudo-capable account the installer set up. Copying store paths as a non-root user needs `nix.settings.require-sigs = false` on the target, which the installer config may lack. After the first deploy, use `root@` (set its password in step 3). Root is trusted by the nix daemon, so unsigned paths are accepted without relaxing `require-sigs`.
- If a local build fails with `unable to load seccomp BPF program`, add `--option filter-syscalls false`.

> **Building on the target:** add `--build-host <user>@<ip>` (usually the same as `--target-host`) to build on the machine itself instead of in the dev container. Evaluation still happens locally, then the derivations are copied over and built natively, so no binfmt emulation or remote builders are involved. This suits beefier x86 hosts like homemac. Avoid it on the Pis, which have little RAM, slow SD storage, and lean on `homelab.swap` to survive.

### 3. Log in

At the console, log in as `nionata` (initial password `password`) and change it with `passwd`.

Root's password depends on how the host was installed:

- **SD image**: root is created from this config, so it starts as `changeme`. Change it with `sudo passwd root`.
- **Installer ISO**: root already existed before this config was applied, so `initialPassword` never took effect. The graphical installer leaves root locked. Set a password with `sudo passwd root` so later deploys can connect as root.

### 4. Wi-Fi

Skip this if the host is on Ethernet. Ethernet gets DHCP automatically.

```sh
sudo iwctl station list                    # find the device, e.g. wlan0
sudo iwctl station wlan0 scan
sudo iwctl station wlan0 get-networks
sudo iwctl station wlan0 connect "<SSID>"  # prompts for the passphrase
```

iwd saves the network to `/var/lib/iwd/<SSID>.psk` and reconnects on boot. networkd handles DHCP on `wl*` interfaces. Check with `networkctl` and `ip -br addr`.

### 5. Tailscale

```sh
sudo tailscale up
```

Open the printed URL to add the machine to the tailnet. Confirm with `tailscale status`. The machine name defaults to the hostname, so rename it in the admin console if an old entry already took it.

### 6. Verify

From the Mac (not the dev container, which doesn't see multicast):

```sh
dns-sd -q <host>.local
ssh nionata@<host>.local
```

Later deploys can target `root@<host>.local` or the tailscale name.

## Zigbee

Zigbee is the preferred wireless protocol for smart devices in my home. The protocol is designed to be run local only unlike wifi devices. The pairing model is sane. Currently the devices are managed by Home Assistant's ZHA integration. I may switch to Zigbee2Mqtt at some point.

| Device | Model | Role |
|--------|-------|------|
| SONOFF Dongle Plus MG24 | Dongle Plus MG24 | Zigbee coordinator (USB) |
| SONOFF SNZB-04PR2 | SNZB-04PR2 | Door/window sensor | Custom quirk — see `pkgs/zha-quirk-snzb04pr2.nix` |
| SONOFF SNZB-09P | SNZB-09P | Siren | Custom quirk from upstream PR [#5136](https://github.com/zigpy/zha-device-handlers/pull/5136) — see `pkgs/zha-quirk-snzb09p.nix` |
| SONOFF SNZB-01M | SNZB-01M | Wireless button | Battery-powered sleepy device; OTA updates and identity calls are unreliable |
| Third Reality Smart Switch (x2) | 3RSP02064Z | Smart switch | Identify requests time out — firmware doesn't implement the identify cluster |
| Third Reality Color Bulb (x2) | 3RCB01057Z | Color bulb | Identify requests time out — same firmware issue as the switches |

## Dev Environment

### Dev Container

TODO(https://github.com/nionata/dotfiles/issues/10): Move to dotfiles repo

https://code.visualstudio.com/docs/devcontainers/containers

Run a Linux-based development environment seamlessly on macOS. A Container Management Platform like Docker Desktop, OrbStack, [Container](https://opensource.apple.com/projects/container/), [colima](https://github.com/abiosoft/colima), etc manage the Linux guest VM. VSCode manages starting and attaching to a container in the VM with deep integration to make it feel invisible. 

The Container Management Platforms leverage Apple’s native [Virtualization.framework](https://developer.apple.com/documentation/virtualization) to spin up a lightweight Linux kernel. Since the host and container share the ARM64 architecture, the guest runs via direct, native CPU virtualization instead of slower emulation. Built-in hardware extensions execute the Linux instructions directly on the Apple chip at near-native speed.

The project source code lives directly on the host's native APFS filesystem and is shared with the Linux container via [VirtioFS](https://virtio-fs.gitlab.io/) (implemented by [macOS](https://developer.apple.com/documentation/virtualization/shared-directories)). Credentials and other host context is easily mounted or bridged into the Dev Container. Volumes are leveraged to cache artifacts: nix store `/nix`, cargo `target`, packages `.cargo`, and `ssh_known_hosts`. I/O on the volume runs at near-native VM speeds. This is far faster than the bind-mounted file operations.

#### Updating the profile

The container's base packages (shell, git, rust toolchain, etc.) come from the flake in `.devcontainer/profile`, which pins nixpkgs through the root flake (`parent.url = "path:./../.."`). The Dockerfile installs it into `/nix/var/nix/profiles/devcontainer`. Because `/nix` is a persistent volume, the image's profile is only copied in when the volume is first created. Rebuilding the image does **not** update an existing volume.

After changing the package list in `.devcontainer/profile/flake.nix` or bumping nixpkgs in the root `flake.lock`, upgrade the live profile from the repo root:

```sh
nix profile upgrade --profile /nix/var/nix/profiles/devcontainer '.devcontainer/profile'
```

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
