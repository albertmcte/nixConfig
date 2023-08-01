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
    ../../modules/desktop
  ];

  networking.hostName = "anubis";
  time.timeZone = "Europe/Amsterdam";

  #For ZFS support
  networking.hostId = "fd91c922";

  system.stateVersion = "23.05";
}
