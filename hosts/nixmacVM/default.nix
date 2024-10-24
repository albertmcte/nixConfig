{ config, pkgs, ... }:
  {
  imports = [
    ../../modules/common
    ./hardware-configuration.nix
    ../../users/wash
    ../../modules/desktop
  ];

  networking.hostName = "nixmacVM";
  time.timeZone = "America/New_York";

  #For ZFS support
  networking.hostId = "134d7ce5";

  system.stateVersion = "23.11";
}
