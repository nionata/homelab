# Configuration for a Raspberry Pi 3 Model B Vi.2

{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:

let
  # Jukebox output presets. Pick one in homelab.jukebox below.
  jukeboxOutputs = {
    # HDMI (vc4hdmi) only takes IEC958 frames, so it needs the hdmi: PCM and
    # can't go through dmix. It has no mixer, so AirPlay volume is software.
    # Audio rides in the video signal, which is why consoleblank=0 is set.
    hdmi = {
      device = "hdmi:CARD=vc4hdmi,DEV=0";
    };
    # Onboard 3.5mm jack (snd_bcm2835)
    jack = {
      # TODO: dmix:CARD=Headphones,DEV=0 plays silence. Use the plain device until fixed
      device = "plughw:CARD=Headphones,DEV=0";
      # AirPlay volume drives the jack's audio mixer directly
      mixer = "PCM";
      mixerDevice = "hw:CARD=Headphones";
      # The jack boots muted. shairport-sync unmutes on play and re-mutes when
      # idle, so aplay/speaker-test are silent unless AirPlay is playing (or
      # `amixer -c Headphones sset PCM unmute` first).
      hardwareMute = true;
    };
  };
in
{
  imports = [
    # Inherits the default aarch64 partition layouts and generic-extlinux setup
    # https://sourcegraph.com/r/github.com/NixOS/nixpkgs@1da598155d27977d91c47e51a9c84ce91f2717fd/-/blob/nixos/modules/installer/sd-card/sd-image-aarch64.nix
    (modulesPath + "/installer/sd-card/sd-image-aarch64.nix")
  ];

  # --- Raspberry Pi 3 Specific Hardware & Firmware ---
  # Essential firmware for the Pi 3's Broadcom Wi-Fi, Bluetooth, and VideoCore GPU
  hardware.enableRedistributableFirmware = true;
  # For the hardware serial console (UART) if you use a console cable
  # On Pi 3, ttyS1 or ttyAMA0 is used depending on Bluetooth allocation
  boot.kernelParams = lib.mkForce [
    "console=ttyS1,115200n8"
    "console=tty0"
    # Never blank the console. HDMI audio rides in the video signal, so a
    # blanked screen lets the panel sleep and silences HDMI audio.
    "consoleblank=0"
  ];

  # Compressed swap in RAM. Swapping to the SD card is too slow to be usable.
  zramSwap = {
    enable = true;
    memoryPercent = 100;
  };

  homelab = {
    enable = true;
    hostName = "homepi";
    splash = true;
    kiosk = {
      enable = true;
      # homemac by its Tailscale (MagicDNS) name. The stable source IP lets HA trust the pi.
      url = "http://homemac:8123/dashboard-home/0";
    };
    bartTender = true;
    jukebox = {
      enable = true;
    }
    // jukeboxOutputs.hdmi;
  };

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.05"; # Did you read the comment?
}
