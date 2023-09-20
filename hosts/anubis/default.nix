{ config, ... }:
  {
  imports = [
    ../../modules/common
    ./hardware-configuration.nix
    ./impermanence.nix  
    ../../users/wash
    ../../modules/desktop
  ];

  networking.hostName = "anubis";
  time.timeZone = "Europe/Amsterdam";

  #For ZFS support
  networking.hostId = "fd91c922";

  system.stateVersion = "23.05";
}
