{
  imports = [
    ../../modules/common
    ./hardware-configuration.nix
    ../../users/wash-test
    #    ../../modules/desktop
    ../../modules/desktop/hyperwm.nix
  ];

  networking = {
    hostName = "nixmacVM";
    hostId = "134d7ce5";
    networkmanager.enable = true;
  };
  time.timeZone = "America/New_York";

  system.stateVersion = "23.11";
}
