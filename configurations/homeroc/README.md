roc-rk3328-cc-v1.2-a

## Build 

### SD Card

```bash
nix build .#ubootRock64

ls result
idbloader.img  nix-support  u-boot-rockchip.bin  u-boot.itb
```

`u-boot-rockchip.bin` contains both `idbloader.img` and `u-boot.itb` at the correct offsets.

```bash
sudo dd if=u-boot-rockchip.bin of=/dev/XYZ seek=64
```

## TODO

* Get bootloader into SPI flash

## References

* https://libre.computer/products/roc-rk3328-cc/
* https://wiki.nixos.org/wiki/NixOS_on_ARM/Libre_Computer_ROC-RK3328-CC
* https://docs.u-boot.org/en/latest/board/rockchip/rockchip.html#sd-card
* https://github.com/Mic92/nixos-aarch64-images
