# roc-rk3328-cc-v1.2-a

## Build 

### SD Card

A SD card `.img` can be built from the closure. This allows booting directly into the configured system automatically.

```bash
nix build .#nixosConfigurations.homeroc.config.system.build.sdImage
```

## TODO

* Fix HDMI
* Get bootloader into SPI flash


## Booting

### custom uboot target

```bash
nix build .#ubootRock64

ls result
idbloader.img  nix-support  u-boot-rockchip.bin  u-boot.itb
```

`u-boot-rockchip.bin` contains both `idbloader.img` and `u-boot.itb` at the correct offsets.

```bash
sudo dd if=u-boot-rockchip.bin of=/dev/XYZ seek=64
```

### Build Img

```text
[ Sources: U-Boot Source Code, Nixpkgs rkbin, Arm Trusted Firmware ]
                                  │
                                  ▼
┌──────────────────────────────────────────────────────────────────────────┐
│ binman tool                                                              │
│                                                                          │
│  Outputs ──►  u-boot-rockchip.bin                                        │
│               │                                                          │
│               ├── [ Rockchip Header ] ─── Magic 4-byte string            │
│               │                                                          │
│               ├── [ Rockchip TPL ] ────── Closed-source DDR Blob         │
│               │                           (From ${pkgs.rkbin})           │
│               │                                                          │
│               ├── [ U-Boot SPL ] ──────── Open-source initial loader     │
│               │                           (From U-Boot source)           │
│               │                                                          │
│               └── [ FIT Image Payload ] ─ Encapsulated multi-file block  │
│                     ├── [ BL31 / TF-A ] ─ ARM Trusted Firmware           │
│                     │                     (From ${pkgs.armTrusted...})   │
│                     └── [ U-Boot Proper]─ The main interactive bootloader│
└──────────────────────────────────────────────────────────────────────────┘
```

### Boot FLow

```text
[ Power Applied ]
       │
       ▼
1. RK3328 Boot ROM ───► Reads Sector 64 of SD/eMMC. Verifies the [ Rockchip Header ].
       │
       ▼
2. Rockchip TPL ──────► Loads into CPU internal SRAM. Initialises DDR RAM.
       │
       ▼
3. U-Boot SPL ────────► Wakes up early clocks and UART (Serial Logs start here!).
       │                Reads the FIT Image Payload from storage into RAM.
       ▼
4. ARM TF-A (BL31) ───► Takes control of CPU Exception Level 3 (Secure Mode).
       │                Initializes low-level platform power domains.
       ▼
5. U-Boot Proper ─────► Runs at regular privilege level. Initializes USB/HDMI.
       │                Provides the countdown menu.
       ▼
6. Linux Kernel ──────► NixOS is booted.
```

## References

* http://wiki.t-firefly.com/ROC-RK3328-CC/index.html
* https://libre.computer/products/roc-rk3328-cc/
* https://wiki.nixos.org/wiki/NixOS_on_ARM/Libre_Computer_ROC-RK3328-CC
* https://docs.u-boot.org/en/latest/board/rockchip/rockchip.html#sd-card
* https://github.com/Mic92/nixos-aarch64-images
* serial debug, https://wiki.t-firefly.com/ROC-RK3328-CC/debug.html
* TTL-2323R-RPI debug, https://www.mouser.com/datasheet/3/35/1/DS_TTL_232R_RPi.pdf

### Things to try with serial cable learning

* try to boot with the stock rock64 pkg at offset 64 (or by using uboot go)
* 

### Failed Uboot

This boot failed because the static linux image and initrd memory offsets were too close. 
The memory layout is configured [here](https://sourcegraph.com/r/github.com/u-boot/u-boot@a7830e87555abfb81cc69275cecb2bc0fbde5b28/-/blob/include/configs/rk3328_common.h?L16-26). That is imported from the [evb_rk3328](https://sourcegraph.com/r/github.com/u-boot/u-boot@79f3e2f8be956575afb339a26325fcd4b15ff1e6/-/blob/include/configs/evb_rk3328.h?L14) this board builds with. That board is selected in [this top-level rk3328 Kconfig](https://sourcegraph.com/r/github.com/u-boot/u-boot@a7830e87555abfb81cc69275cecb2bc0fbde5b28/-/blob/arch/arm/mach-rockchip/rk3328/Kconfig?L1-36) because the board's [defconfig sets CONFIG_ROCKCHIP_RK3328=y](https://sourcegraph.com/r/github.com/u-boot/u-boot@a7830e87555abfb81cc69275cecb2bc0fbde5b28/-/blob/configs/roc-cc-rk3328_defconfig?L11).

```bash
failed to probe rk hdmi
failed to probe rk hdmi
In:    serial,usbkbd
Out:   serial,vidconsole
Err:   serial,vidconsole
Model: Firefly ROC-RK3328-CC
Net:   eth0: ethernet@ff540000

Hit any key to stop autoboot: 0
Cannot persist EFI variables without system partition
failed to probe rk hdmi
** Booting bootflow '<NULL>' with efi_mgr
Loading Boot0000 'mmc 1' failed
EFI boot manager: Cannot load any image
Boot failed (err=-14)
** Booting bootflow 'mmc@ff500000.bootdev.part_2' with extlinux
------------------------------------------------------------
1:      NixOS - Default
Enter choice: 1:        NixOS - Default
Retrieving file: /boot/extlinux/../nixos/0wjmqn44pfizf57j85aik454daap4563-linux-6.18.35-Image
Retrieving file: /boot/extlinux/../nixos/22qyfkhph73df9zcainbws990fkk6ks7-initrd-linux-6.18.35-initrd
append: init=/nix/store/lakhff9rfwd8yxz8v96x8v87mzx45slm-nixos-system-homeroc-sd-card-26.05.20260611.a037402/init console=ttyS2,1500000n8 console=tty1
Retrieving file: /boot/extlinux/../nixos/0wjmqn44pfizf57j85aik454daap4563-linux-6.18.35-dtbs/rockchip/rk3328-roc-cc.dtb
Moving Image from 0x2080000 to 0x2200000, end=0x60a0000
ERROR: RD image overlaps OS image (OS=2200000..60a0000)
Boot failed (err=-14)
USB DWC2
USB EHCI 1.00
USB OHCI 1.0
USB XHCI 1.10
```

Env

```bash
=> printenv
arch=arm
baudrate=1500000
board=evb_rk3328
board_name=evb_rk3328
boot_targets=mmc1 mmc0 nvme scsi usb pxe dhcp spi
bootargs=init=/nix/store/lakhff9rfwd8yxz8v96x8v87mzx45slm-nixos-system-homeroc-sd-card-26.05.20260611.a037402/init console=ttyS2,1500000n8 console=tty1
bootcmd=bootflow scan
bootdelay=2
bootp_arch=b
bootp_vci=PXEClient:Arch:0000b:UNDI:003000
cpu=armv8
cpuid#=55524b50303630303000000000010819
eth1addr=2a:db:13:4c:1e:7a
ethact=ethernet@ff540000
ethaddr=2a:db:13:4c:1e:7b
fdt_addr_r=0x01e00000
fdtcontroladdr=7bf273b0
fdtfile=rockchip/rk3328-roc-cc.dtb
fdtoverlay_addr_r=0x01f00000
kernel_addr_r=0x02080000
kernel_comp_addr_r=0x08000000
kernel_comp_size=0x2000000
loadaddr=0x800800
partitions=uuid_disk=${uuid_gpt_disk};name=loader1,start=32K,size=4000K,uuid=${uuid_gpt_loader1};name=loader2,start=8MB,size=4MB,uuid=${uuid_gpt_loader2};name=trust,size=4M,uuid=${uuid_gpt_atf};name=boot,size=112M,bootable,uuid=${uuid_gpt_boot};name=rootfs,size=-,uuid=B921B045-1DF0-41C3-AF44-4C6F280D3FAE;
pxefile_addr_r=0x00600000
ramdisk_addr_r=0x06000000
script_offset_f=0xffe000
script_size_f=0x2000
scriptaddr=0x00500000
serial#=7acd67953aa4d8bb
soc=rk3328
stderr=serial,vidconsole
stdin=serial,usbkbd
stdout=serial,vidconsole
vendor=rockchip

Environment size: 1245/32764 bytes
```

#### New Memory Layout

The fix is to adjust the default memory layout from [rk3328_common.h](https://sourcegraph.com/r/github.com/u-boot/u-boot@a7830e87555abfb81cc69275cecb2bc0fbde5b28/-/blob/include/configs/rk3328_common.h?L16-26).

These changes can be tested in the u-boot shell temporarily before burning a new boot.

```bash
=> setenv ramdisk_addr_r 0x10000000
=> setenv kernel_comp_addr_r 0x20000000
=> boot

...

Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd034]
[    0.000000] Linux version 6.18.35 (nixbld@localhost) (gcc (GCC) 15.2.0, GNU ld (GNU Binutils) 2.46) #1-NixOS SMP Tue Jun  9 10:28:53 UTC 2026

...

<<< Welcome to NixOS sd-card-26.05.20260611.a037402 (aarch64) - ttyS2 >>>

Run 'nixos-help' for the NixOS manual.

homeroc login: 
```

Trying to override these consts in code gives us issues. 

> However, during early boot initialization, the Rockchip platform code executes a C function (usually found in arch/arm/mach-rockchip/board.c or generic distro boot headers). This function dynamically calculates safe memory boundaries based on how much physical DRAM was detected by the SPL. It calculates memory allocation layouts and aggressively overwrites standard locations like ramdisk_addr_r and kernel_addr_r, setting them back to the stock Rockchip layout (forcing ramdisk_addr_r to 0x06000000).



Here is an overview of the memory layout

```bash
Physical Memory (RAM) Map: 0x00000000 to 0x40000000 (1GB Total)
====================================================================================
Address Space          | Size     | Allocation / Label & Safety Status
====================================================================================
0x00000000             |          |
   │                   |  5 MB    | [Reserved] System / Boot ROM / Secure Monitor
0x00500000 ───┐        |          |
              ├────────┼──────────┼─► [scriptaddr] U-Boot scripts (Tiny text files)
0x00600000 ───┘        |  24 MB   | [pxefile_addr_r] Network boot configurations
   │                   |          |
0x01E00000 ───┐        |  1 MB    | [fdt_addr_r] Device Tree Blob (.dtb file)
0x01F00000 ───┼────────┼──────────┼─► [fdtoverlay_addr_r] Device Tree Overlays (.dtbo)
0x02080000 ───┘        |  1.5 MB  | Safe boundary gap
   │                   |          |
   ▼                   |          | 
0x02080000 ────────────               [kernel_addr_r]
   │                   |          |   ┌──────────────────────────────────────────────┐
   │                   |          |   │ Compressed Kernel (e.g., Image.gz)           │
   │                   |          |   └──────────────────────────────────────────────┘
   │                   | 223.5 MB |   ▼ Uncompresses and expands UPWARDS into:
   │                   |          |   ┌──────────────────────────────────────────────┐
   │                   |          |   │ Uncompressed Runtime Kernel Executable       │
   │                   |          |   │ (Needs ~30MB - 45MB; safely stops way before │
   │                   |          |   │ reaching the Ramdisk start line)             │
   │                   |          |   └──────────────────────────────────────────────┘
   ▼                   |          |
0x10000000 ────────────               [ramdisk_addr_r]
   │                   |          |   ┌──────────────────────────────────────────────┐
   │                   |          |   │ NixOS Stage-1 Initrd / Ramdisk Archive       │
   │                   | 256 MB   |   │ (Holds storage modules, filesystem tools,    │
   │                   |          |   │  and cryptographic libraries)                │
   │                   |          |   └──────────────────────────────────────────────┘
   ▼                   |          |
0x20000000 ────────────               [kernel_comp_addr_r]
   │                   |          |   ┌──────────────────────────────────────────────┐
   │                   |  32 MB   |   │ Decompression Workspace Buffer               │
   │                   |          |   │ [kernel_comp_size = 0x2000000]               │
   │                   |          |   └──────────────────────────────────────────────┘
0x22000000 ────────────|          |
   │                   | 480 MB   | [Free Memory] Available for Linux OS Runtime
0x40000000 (1GB End)   |          |
====================================================================================
```

### Cases

* [Raspberry pi snap case like](https://www.printables.com/model/344341-renegade-snap-fit-case)
   * [Motification with a different lid](https://www.printables.com/model/563106-case-for-libre-computer-board-roc-rk3328-cc-renega)
*  [Mini PC Case with OLED Display](https://www.printables.com/model/868013-roc-rk3328-cc-renegade-mini-pc-case-with-oled-stat)