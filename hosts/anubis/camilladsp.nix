{ pkgs, lib, ... }:

let
  alsa-cdsp = pkgs.callPackage ../../pkgs/alsa-cdsp.nix { };

  # CamillaDSP YAML template with placeholders that alsa_cdsp will substitute
  camillaConfigTemplate = pkgs.writeText "camilladsp-template.yaml" ''
    ---
    devices:
      samplerate: $samplerate$
      chunksize: 4096
      queuelimit: 4
      capture:
        type: Stdin
        channels: $channels$
        format: $format$
      playback:
        type: Alsa
        channels: 2
        device: "hw:0,0"
        format: S32LE

    filters:
      low_shelf:
        type: Biquad
        parameters:
          type: Lowshelf
          freq: 60
          slope: 6
          gain: 0.0

      peak_100:
        type: Biquad
        parameters:
          type: Peaking
          freq: 100
          q: 1.0
          gain: 0.0

      peak_160:
        type: Biquad
        parameters:
          type: Peaking
          freq: 160
          q: 1.0
          gain: 0.0

      peak_250:
        type: Biquad
        parameters:
          type: Peaking
          freq: 250
          q: 1.0
          gain: 0.0

      peak_400:
        type: Biquad
        parameters:
          type: Peaking
          freq: 400
          q: 1.0
          gain: 0.0

      peak_630:
        type: Biquad
        parameters:
          type: Peaking
          freq: 630
          q: 1.0
          gain: 0.0

      peak_1k:
        type: Biquad
        parameters:
          type: Peaking
          freq: 1000
          q: 1.0
          gain: 0.0

      peak_1k6:
        type: Biquad
        parameters:
          type: Peaking
          freq: 1600
          q: 1.0
          gain: 0.0

      peak_2k5:
        type: Biquad
        parameters:
          type: Peaking
          freq: 2500
          q: 1.0
          gain: 0.0

      peak_4k:
        type: Biquad
        parameters:
          type: Peaking
          freq: 4000
          q: 1.0
          gain: 0.0

      peak_8k:
        type: Biquad
        parameters:
          type: Peaking
          freq: 8000
          q: 1.0
          gain: 0.0

      high_shelf:
        type: Biquad
        parameters:
          type: Highshelf
          freq: 16000
          slope: 6
          gain: 0.0

    mixers: {}

    pipeline:
      - type: Filter
        channels: [0, 1]
        names:
          - low_shelf
          - peak_100
          - peak_160
          - peak_250
          - peak_400
          - peak_630
          - peak_1k
          - peak_1k6
          - peak_2k5
          - peak_4k
          - peak_8k
          - high_shelf
  '';

  # ALSA configuration for the cdsp PCM device
  asoundConf = pkgs.writeText "asound-cdsp.conf" ''
    # CamillaDSP ALSA plugin configuration
    pcm.camilladsp {
      type cdsp
      cpath "${pkgs.camilladsp}/bin/camilladsp"
      config_in "${camillaConfigTemplate}"
      config_out "/var/lib/camilladsp/active_config.yaml"
      cargs [
        "-p" "1234"
        "-a" "127.0.0.1"
        "-o" "/var/lib/camilladsp/camilladsp.log"
        "-l" "warn"
      ]
      channels 2
      rates = [
        44100 48000 88200 96000 176400 192000 352800 384000
      ]
      extra_samples 0
    }
  '';
in
{
  # Ensure CamillaDSP package is available
  environment.systemPackages = [
    pkgs.camilladsp
    alsa-cdsp
  ];

  # Create necessary directories
  systemd.tmpfiles.rules = [
    "d /var/lib/camilladsp 0755 mpd audio -"
    "d /var/lib/camilladsp/configs 0775 mpd audio -"
    "d /var/lib/camilladsp/coeffs 0775 mpd audio -"
    "d /etc/camilladsp 0755 root root -"
  ];

  # Deploy ALSA configuration
  environment.etc."asound.conf".source = asoundConf;

  # Copy template to /etc for easy editing
  environment.etc."camilladsp/config_template.yaml".source = camillaConfigTemplate;

  # Ensure the alsa-cdsp plugin is found by ALSA
  environment.variables.ALSA_PLUGIN_DIR = "${alsa-cdsp}/lib/alsa-lib";

  # Ensure MPD's systemd service can find the alsa-cdsp plugin
  systemd.services.mpd.environment.ALSA_PLUGIN_DIR = "${alsa-cdsp}/lib/alsa-lib";

  # Add mpd user to audio group for hardware access
  users.users.mpd.extraGroups = [ "audio" ];

  # Open websocket port for CamillaGUI (optional future use)
  networking.firewall.allowedTCPPorts = [ 1234 ];
}
