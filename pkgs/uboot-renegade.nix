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

  # TODO: inject updated memory address for kernel and initrd
  extraMakeFlags = [
    # Inject trusted firmware for bluetooth?
    "BL31=${armTrustedFirmwareRK3328}/bl31.elf"
    # Inject Rockchip's proprietary DDR training binary blobs
    "ROCKCHIP_TPL=${rkbin}/bin/rk33/rk3328_ddr_333MHz_v1.16.bin"
  ];
}
