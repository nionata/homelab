# homepi

## Build Targets

### SD Image

A SD card `.img` can be built from the closure. This allows booting directly into the configured system automatically.

```bash
nix build .#nixosConfigurations.homepi.config.system.build.sdImage
```

> The following disk utils and semantics are specific to MacOS.

Plug a SD card into the computer and discover it:

```bash
diskutil list

/dev/disk4 (external, physical):
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:     FDisk_partition_scheme                        *16.1 GB    disk4
   1:                 DOS_FAT_32 FIRMWARE                31.5 MB    disk4s1
   2:                      Linux                         16.0 GB    disk4s2
```

Make sure the disk is unmounted:

```bash
diskutil unmountDisk /dev/disk4
Unmount of all volumes on disk4 was successful
```

Copy the image onto the SD card. Use the `r` prefixed disk to skip all system caches and write right to the disk:

```bash
sudo dd if=homepi.img of=/dev/rdisk4 bs=1m status=progress
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

### Status

```bash
[nionata@homepi:~]$ networkctl status
● Interfaces: 1, 2, 3
       State: degraded                           
Online state: partial                            
     Address: 169.254.138.176 on enu1u1
              fe80::ba27:ebff:feed:64ff on enu1u1
```

### Wifi

```bash
[nionata@homepi:~]$ iwctl
NetworkConfigurationEnabled: disabled
StateDirectory: /var/lib/iwd
Version: 3.12
[iwd]# device list
                                    Devices                                   *
--------------------------------------------------------------------------------
  Name                  Address               Powered     Adapter     Mode      
--------------------------------------------------------------------------------
  wlan0                 ab:12:cd:ef:34:gh     on          phy0        station     

[iwd]# station wlan0 scan
[iwd]# station wlan0 get-networks
                               Available networks                             *
--------------------------------------------------------------------------------
      Network name                      Security            Signal
--------------------------------------------------------------------------------
  >   ABCDEF                            psk                 ****    

[iwd]# station wlan0 connect ABCDEF 
```

## References

* https://wiki.nixos.org/wiki/NixOS_on_ARM/Raspberry_Pi_3
