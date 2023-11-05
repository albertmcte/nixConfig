{ config, ... }:
  {
  imports = [
    ../../modules/common
    ./hardware-configuration.nix
    ./impermanence.nix  
    ./resilio.nix
    ../../users/wash
    ../../modules/desktop
    ../../modules/server
  ];

  networking.hostName = "anubis";
  time.timeZone = "Europe/Amsterdam";

  #For ZFS support
  boot.zfs.extraPools = [ "mercury" ];

  networking.hostId = "fd91c922";

  system.stateVersion = "23.05";

