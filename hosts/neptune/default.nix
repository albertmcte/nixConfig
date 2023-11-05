# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  ...
}:
  {
  imports = [
    ./hardware-configuration.nix
    ./router.nix
    ./unbound.nix
    ../../modules/common
    ../../users/wash
    ../../modules/server
    # cloudflare
  ];

  networking.hostId = "ca0bad48";
  networking.hostName = "neptune";
#  networking.networkmanager.enable = true;
  time.timeZone = "UTC";

  boot.kernelParams = [ "nohibernate" ];

  system.stateVersion = "23.05";
}
