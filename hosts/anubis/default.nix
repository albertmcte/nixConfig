{ inputs, pkgs, myLib, ... }:
let
  unstable = myLib.mkUnstable pkgs;
in
{
  imports = [
    ../../modules/common
    ./hardware-configuration.nix
    ./impermanence.nix
    #    ./resilio.nix
    ./sanoid.nix
    ./syncoid.nix
    ./systemdservices.nix
    ./autologin.nix
    ./tailscale.nix
    ./upmpdcli.nix
    ./camilladsp.nix
    ./camillagui.nix
    ./camillaeq.nix
    ../../users/wash-desktop
    ../../modules/desktop/hyprwm.nix
    ../../modules/desktop/android.nix
    ../../modules/server
  ];

  networking = {
    hostName = "anubis";
    networkmanager.enable = true;
  };

  time.timeZone = "America/New_York";

  modules.android.enable = true;

  # Host-specific variables for Hyprland/desktop
  hostVars = {
    browser = "microsoft-edge";
    terminal = "kitty";
    keyboardLayout = "us";
    consoleKeyMap = "us";
  };

  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;

  #For ZFS support
  networking.hostId = "fd91c922";
  boot.zfs.extraPools = [ "mercury" ];
  services.zfs.autoScrub = {
    enable = true;
    interval = "monthly";
  };

  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;
      dockerSocket.enable = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  services = {
    lact.enable = true;
    immich = {
      enable = true;
      port = 2283;
      host = "0.0.0.0";
      # mediaLocation = "/mercury/immich/upload";
      openFirewall = true;
    };
    # plex = {
    #   enable = true;
    #   openFirewall = true;
    # };
    jellyfin = {
      enable = true;
      openFirewall = true;
    };
    nfs.server = {
      enable = true;
      # fixed rpc.statd port; for firewall
      lockdPort = 4001;
      mountdPort = 4002;
      statdPort = 4000;
      extraNfsdConfig = '''';
    };
    samba = {
      enable = true;
      #package = pkgs.samba4Full;
      openFirewall = true;
      settings = {
        global = {
          "workgroup" = "WORKGROUP";
          "server string" = "smbnix";
          "netbios name" = "smbnix";
          "security" = "user";
          #"use sendfile" = "yes";
          #"max protocol" = "smb2";
          # note: localhost is the ipv6 localhost ::1
          "hosts allow" = "10.1.1. 127.0.0.1 localhost";
          "hosts deny" = "0.0.0.0/0";
          "guest account" = "nobody";
          "map to guest" = "bad user";
          "ntlm auth" = "yes";
        };
        "sambashare" = {
          "path" = "/mercury/music";
          "valid users" = "wash";
          "public" = "no";
          "browseable" = "yes";
          "read only" = "yes";
          "guest ok" = "no";
          "allow guests" = "yes";
          "force user" = "wash";
        };
      };
    };
    mpd = {
      enable = true;
      musicDirectory = "/mercury/music";
      extraConfig = ''
        audio_output {
          type           "alsa"
          name           "Bitperfect (Direct)"
          device         "hw:0,0"
          auto_resample  "no"
          auto_channels  "no"
          auto_format    "no"
          dop            "no"
          buffer_time    "200000"
          period_time    "50000"
          enabled        "yes"
        }
        audio_output {
          type           "alsa"
          name           "CamillaDSP EQ"
          device         "camilladsp"
          auto_resample  "no"
          auto_channels  "no"
          auto_format    "no"
          buffer_time    "200000"
          period_time    "50000"
          enabled        "no"
        }
        audio_output {
          type           "fifo"
          name           "my_fifo"
          path           "/tmp/mpd.fifo"
          format         "44100:16:2"
        }
        resampler {
          plugin         "soxr"
          quality        "very high"
        }
        '';
    };
  };

  environment.systemPackages = with pkgs; [
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg
    jellyfin-media-player
    obsidian
    dive # look into docker image layers
    podman-tui # container status
    docker-client
    lact
    makemkv
    chromium
    firefox
    pamixer
    pwvucontrol
    ncmpcpp
    whipper
    picard
  ];
  systemd.packages = with pkgs; [ lact ];
  systemd.services.lactd.wantedBy = ["multi-user.target"];

  networking.firewall.interfaces."enp5s0" = {
    allowedTCPPorts = [
      111
      2049
      4000
      4001
      4002
      20048
      31225
    ];
    allowedUDPPorts = [
      111
      2049
      4000
      4001
      4002
      20048
      31225
    ];
  };
  system.stateVersion = "23.11";
}
