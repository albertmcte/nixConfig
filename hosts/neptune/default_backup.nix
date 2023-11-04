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
    ../../modules/common
    ./hardware-configuration.nix
    ../../users/wash
    ../../modules/server
    # cloudflare
  ];

  networking.hostId = "ca0bad48";
  networking.hostName = "neptune";
  time.timeZone = "UTC";

  boot.supportedFilesystems = [ "zfs" ];
  boot.kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
  boot.kernelParams = [ "nohibernate" ];

  system.stateVersion = "23.05";
}
