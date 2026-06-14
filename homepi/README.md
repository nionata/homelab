# homepi

## Build Targets

### SD Image

A SD card `.img` can be built from the closure. This allows booting directly into the configured system automatically.

```bash
nix build .#nixosConfigurations.homepi.config.system.build.sdImage
```

### toplevel

The `nixos-rebuild` command provides a convient way to build, copy, and activate the toplevel config in a single command:

```bash
nixos-rebuild switch --flake .#homepi --target-host root@homepi.local --ask-sudo-password
```

The latest toplevel system closure can be built and copied over to a pi already running NixOS.

```bash
# Build closure
nix build .#nixosConfigurations.homepi.config.system.build.toplevel
# Copy it to the pi
nix copy --to ssh://homepi.local result
# Set it as the current system
# Switch into it
```

## Networking

The pi uses the zeroconf networking stack (ie. link-local addressing, mDNS, DNS-SD). This allows local discovery and connectivity with or without DHCP.

### Hostname

```bash
dns-sd -q homepi.local 
```

Will return something like:

```bash
DATE: ---Sun 14 Jun 2026---
10:05:03.779  ...STARTING...
Timestamp     A/R  Flags         IF  Name                          Type   Class  Rdata
10:05:03.779  Add  40000003      25  homepi.local.                 Addr   IN     169.254.114.176
10:05:03.779  Add  40000002      12  homepi.local.                 Addr   IN     192.168.1.80
```

## References

* https://wiki.nixos.org/wiki/NixOS_on_ARM/Raspberry_Pi_3
