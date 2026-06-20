{
  buildUBoot,
  armTrustedFirmwareRK3328,
  rkbin,
  ...
}:
buildUBoot {
  defconfig = "roc-cc-rk3328_defconfig";
  extraMeta.platforms = [ "aarch64-linux" ];

  # Target the unified Binman file output instead of the raw fragments
  filesToInstall = [ "u-boot-rockchip.bin" ];

  extraMakeFlags = [
    # Inject trusted firmware for bluetooth?
    "BL31=${armTrustedFirmwareRK3328}/bl31.elf"
    # Inject Rockchip's proprietary DDR training binary blobs
    "ROCKCHIP_TPL=${rkbin}/bin/rk33/rk3328_ddr_333MHz_v1.16.bin"
  ];

  # Inject updated memory address for kernel and initrd
  # Defined here https://sourcegraph.com/r/github.com/u-boot/u-boot@a7830e87555abfb81cc69275cecb2bc0fbde5b28/-/blob/include/configs/rk3328_common.h?L16-26
  #
  # ramdisk_addr_r = 0x10000000  # 256 MB — well past any realistic kernel size
  # kernel_comp_addr_r = 0x20000000  # 512 MB
  #
  # The alternative way of doing this would be to use these config flags:
  # CONFIG_USE_DEFAULT_ENV_FILE=y
  # CONFIG_DEFAULT_ENV_FILE=/env/file
  #
  # This would fully override the existing default. We'd need to include all u-boot environment variables.
  # These are generated at may layers of the u-boot import / build tree. We could vendor all variables from `printenv` in the u-boot shell.
  # For now, patching these two variables is okay.
  #
  # One thing we could consider tuning in the future would be `boot_targets`:
  #   boot_targets=mmc1 mmc0 nvme scsi usb pxe dhcp spi
  # postPatch = ''
  #   substituteInPlace include/configs/rk3328_common.h \
  #     --replace-fail '"ramdisk_addr_r=0x06000000\0"' '"ramdisk_addr_r=0x10000000\0"' \
  #     --replace-fail '"kernel_comp_addr_r=0x08000000\0"' '"kernel_comp_addr_r=0x20000000\0"'
  # '';
  postPatch = ''
    # Force configuration directly into the defconfig or Kconfig files
    echo "CONFIG_SYS_BOOTM_LEN=0x4000000" >> configs/evb-rk3328_defconfig

    # Check for downstream scripts resetting it (like rockchip-common.h or board files)
    find . -name "*.h" -o -name "*.c" | xargs sed -i 's/kernel_comp_addr_r=0x08000000/kernel_comp_addr_r=0x20000000/g'
  '';
}
