# ZHA quirk for the Sonoff SNZB-04PR2 door/window sensor (SenseGuard DW Gen2).
# Required for tamper detection support in ZHA, https://help.sonoff.tech/docs/SNZB-04PR2.
{ fetchzip }:
fetchzip {
  name = "zha-quirk-snzb04pr2";
  url = "https://resource-wangsu.helplook.net/docker_production/a4j0b0/article/lpS1dTyV/attachments/SenseGuardDWGen2_ZHA_Script.zip";
  hash = "sha256-NuOmbfrjOl0LWQB7XOdUejM/D66yi2xQSdU9ZXXQHMM=";
  stripRoot = true;
}
