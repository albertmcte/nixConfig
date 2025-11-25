{ pkgs, ... }:
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
    ../../users/wash-desktop
    ../../modules/desktop
    ../../modules/server
  ];

  networking = {
    hostName = "anubis";
    networkmanager.enable = true;
  };

  time.timeZone = "America/New_York";

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
      dockerCompat = true;
      defaultNetwork.settings.dns_enable = true;
    };

  };

  services = {
    plex = {
      enable = true;
      openFirewall = true;
    };
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
    # samba-wsdd = {
      # enable = true;
      # discovery = true;
    # };
  };

  environment.systemPackages = with pkgs; [
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg
    obsidian
    dive #look into docker image layers
    podman-tui #container status
    docker-compose
    # pkgs.makemkv
  ];

  networking.firewall.interfaces."enp5s0" = {
    allowedTCPPorts = [ 111 2049 4000 4001 4002 20048 31225 ];
    allowedUDPPorts = [ 111 2049 4000 4001 4002 20048 31225 ];
  };
  system.stateVersion = "23.11";
}
