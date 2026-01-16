# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  inputs,
  outputs,
  config,
  pkgs,
  ...
}:
{
  imports = [
    ../../modules/common
    ./hardware-configuration.nix
    ../../users/wyatt
    ../../modules/gnome/gnome.nix
  ];

  networking.hostName = "zelda";
  networking.networkmanager.enable = true;
  time.timeZone = "America/New_York";
  security.sudo.wheelNeedsPassword = false;

  #For ZFS support
  networking.hostId = "dc0145aa";

  system.stateVersion = "23.11";
}
