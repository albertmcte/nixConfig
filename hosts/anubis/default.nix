{ pkgs, ... }:
  {
  imports = [
    ../../modules/common
    ./hardware-configuration.nix
    ./impermanence.nix  
#    ./resilio.nix
    ./sanoid.nix
    ./syncoid.nix
    ../../users/wash
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
  };

  environment.systemPackages = [
    pkgs.jellyfin
    pkgs.jellyfin-web
    pkgs.jellyfin-ffmpeg
  ];

  networking.firewall.interfaces."enp5s0" = {
    allowedTCPPorts = [ 111 2049 4000 4001 4002 20048 31225 ];
    allowedUDPPorts = [ 111 2049 4000 4001 4002 20048 31225 ];
  };

  system.stateVersion = "23.11";
}
