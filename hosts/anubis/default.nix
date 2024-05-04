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
  time.timeZone = "Europe/Amsterdam";

  #For ZFS support
  networking.hostId = "fd91c922";
  boot.zfs.extraPools = [ "mercury" ];
  services.zfs.autoScrub = {
    enable = true;
    interval = "monthly";
  };

  services.plex = {
    enable = true;
    openFirewall = true;
  };

  system.stateVersion = "23.11";
}
