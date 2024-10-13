{ config, ... }:
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

  networking.hostName = "anubis";
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
    nfs.server.enable = true;
  };
  networking.firewall.interfaces."enp5s0" = {
    allowedTCPPorts = [ 2049 31225 ];
    allowedUDPPorts = [ 31225 ];
  };

  system.stateVersion = "23.11";
}
