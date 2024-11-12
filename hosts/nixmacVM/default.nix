{ config, pkgs, ... }:
  {
  imports = [
    ../../modules/common
    ./hardware-configuration.nix
    ../../users/wash
    ../../modules/desktop
  ];

  networking = {
    hostName = "nixmacVM";
    hostId = "134d7ce5";
    networkmanager.enable = true;
  };
  time.timeZone = "America/New_York";

  system.stateVersion = "23.11";
}
