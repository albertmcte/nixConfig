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
          freq: 100
          slope: 6
          gain: 0.0

      peaking_mid:
        type: Biquad
        parameters:
          type: Peaking
          freq: 1000
          q: 1.0
          gain: 0.0

      high_shelf:
        type: Biquad
        parameters:
          type: Highshelf
          freq: 8000
          slope: 6
          gain: 0.0

    mixers: {}

    pipeline:
      - type: Filter
        channel: 0
        names:
          - low_shelf
          - peaking_mid
          - high_shelf
      - type: Filter
        channel: 1
        names:
          - low_shelf
          - peaking_mid
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
        "-o" "/var/log/camilladsp.log"
        "-l" "warn"
      ]
      channels 2
      rates = [
        44100 48000 88200 96000 176400 192000 352800 384000
      ]
      extra_samples 0
      hw_params_from_plugin 0
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
    "d /etc/camilladsp 0755 root root -"
  ];

  # Deploy ALSA configuration
  environment.etc."asound.conf".source = asoundConf;

  # Copy template to /etc for easy editing
  environment.etc."camilladsp/config_template.yaml".source = camillaConfigTemplate;

  # Ensure the alsa-cdsp plugin is found by ALSA
  environment.variables.ALSA_PLUGIN_DIR = "${alsa-cdsp}/lib/alsa-lib";

  # Add mpd user to audio group for hardware access
  users.users.mpd.extraGroups = [ "audio" ];

  # Open websocket port for CamillaGUI (optional future use)
  networking.firewall.allowedTCPPorts = [ 1234 ];
}
