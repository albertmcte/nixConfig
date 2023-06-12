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
    ../../common
    ./hardware-configuration.nix
    ../../users/wash
  ];

  networking.hostName = "anubis";
  time.timeZone = "Europe/Amsterdam";

  system.stateVersion = "23.05";
}