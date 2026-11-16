# Play audio on the device: an AirPlay receiver (shairport-sync) on plain ALSA.

{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.homelab.jukebox;
in
{
  options.homelab.jukebox = {
    enable = lib.mkEnableOption "AirPlay receiver and local audio output";

    device = lib.mkOption {
      type = lib.types.str;
      description = ''
        ALSA PCM to play through. List cards with `aplay -l`. dmix lets several
        programs share an analog card, but check that it plays: on some cards
        it outputs silence, so use `plughw:` there. HDMI (vc4hdmi) only
        accepts IEC958 frames, so use the `hdmi:` PCM there, which cannot be
        shared through dmix. Card names are hardware-specific.

        HDMI audio needs an active video signal. When the console blanks, the
        kernel switches the HDMI output off, which stops audio too, so set
        `consoleblank=0`. A graphical session powers the display off through
        its own idle settings instead, so disable those there.
      '';
      example = "plughw:CARD=Headphones,DEV=0";
    };

    name = lib.mkOption {
      type = lib.types.str;
      description = "Name the AirPlay receiver advertises";
      default = config.networking.hostName;
    };

    mixer = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      description = ''
        ALSA mixer control that AirPlay volume drives (see `amixer -c <card>`).
        When null, volume is applied in software on top of whatever level the
        card's mixer happens to be at. Mixer names are hardware-specific.
      '';
      default = null;
      example = "PCM";
    };

    mixerDevice = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      description = ''
        ALSA control device that holds the mixer. shairport-sync defaults to the
        output device, which fails when that is a PCM like `plughw:...,DEV=0`.
        Mixers attach to a card (`hw:CARD=<name>`) rather than a PCM.
      '';
      default = null;
      example = "hw:CARD=Headphones";
    };

    hardwareMute = lib.mkOption {
      type = lib.types.bool;
      description = ''
        Let shairport-sync own the mixer's mute switch: unmute when playback
        starts, mute again when it stops. This makes the mute state
        reproducible without persisting mixer state across boots.

        Warning: the card stays muted whenever AirPlay is idle, so anything
        else playing to it (aplay, speaker-test, a future mpd) is silent unless
        it unmutes first. Turn this off before adding another player.
      '';
      default = false;
    };
  };

  config = lib.mkIf cfg.enable {
    assertions = [
      {
        assertion = cfg.hardwareMute -> cfg.mixer != null;
        message = "homelab.jukebox.hardwareMute needs homelab.jukebox.mixer to be set";
      }
      {
        assertion = cfg.mixerDevice != null -> cfg.mixer != null;
        message = "homelab.jukebox.mixerDevice needs homelab.jukebox.mixer to be set";
      }
    ];

    hardware.alsa = {
      enable = true;
      # No enablePersistence: mixer state saved across boots isn't reproducible.
      # Mixers can come up muted (the Pi's headphone jack does), so use
      # hardwareMute to have shairport-sync unmute on play instead.
      # Set the default in /etc/asound.conf. Avoid defaultDevice.playback: it
      # puts the device into systemd.globalEnvironment, so changing it rewrites
      # every unit (initrd included) and restarts every service on switch.
      # This comes after the module's own `pcm.!default fromenv` and overrides it.
      config = ''
        pcm.!default "${cfg.device}"
      '';
    };

    # /dev/snd/* is root:audio and ssh sessions don't get seat ACLs
    users.users.nionata.extraGroups = [ "audio" ];

    environment.systemPackages = [ pkgs.alsa-utils ];

    # --- AirPlay ---
    # The upstream unit doesn't reference the config file, so a settings-only
    # change leaves the unit identical and switch never restarts it.
    systemd.services.shairport-sync.restartTriggers = [
      config.environment.etc."shairport-sync.conf".source
    ];

    services.shairport-sync = {
      enable = true;
      # Classic AirPlay (AirPlay 1). The AirPlay 2 build needs NQPTP for PTP
      # timing, and macOS never sent it a usable clock ("No NQPTP master clock").
      # Classic carries timing in the stream itself. Multi-room from iOS needs
      # AirPlay 2. Switch to pkgs.shairport-sync-airplay2 plus nqptp for that.
      package = pkgs.shairport-sync;
      # TCP 5000 (RTSP) and UDP 6001-6011 (audio, control, timing)
      openFirewall = true;
      settings = {
        general = {
          name = cfg.name;
          output_backend = "alsa";
          # AirPlay volume runs 0 (max) to -30 (min). The stock -24 starts
          # sessions nearly silent
          default_airplay_volume = -15.0;
          # Map the slider onto the audible top of the range. A hardware mixer's
          # native range can be ~100 dB (the Pi jack is -102..+4), which makes
          # most of the slider inaudible. With software volume (no mixer, as on
          # HDMI) 40 dB is still a sensible span.
          volume_range_db = 40;
          # Don't go above unity gain (the Pi jack's mixer allows up to +4 dB).
          # Software volume tops out at 0 dB anyway, since more would clip.
          volume_max_db = 0.0;
        };
        alsa = {
          output_device = cfg.device;
        }
        // lib.optionalAttrs (cfg.mixer != null) {
          mixer_control_name = cfg.mixer;
        }
        // lib.optionalAttrs (cfg.mixerDevice != null) {
          mixer_device = cfg.mixerDevice;
        }
        // lib.optionalAttrs cfg.hardwareMute {
          use_hardware_mute_if_available = "yes";
        };
      };
    };
  };
}
