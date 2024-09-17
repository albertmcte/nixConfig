{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  networking.hostName = "neptune";
  networking.networkmanager.enable = true;
  networking.hostId = "ca0bad48";  

#  boot.loader.grub.enable = true;
#  boot.loader.grub.device = "nodev";
#  boot.loader.grub.efiSupport = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.supportedFilesystems = [ "zfs" ];
  boot.zfs.forceImportRoot = false;
  
  boot.kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
  boot.kernelParams = [ "nohibernate" ];

  # Set your time zone.
  # time.timeZone = "Europe/Amsterdam";

  users.users.wash = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
      neovim
      git
    ];
  };

  system.stateVersion = "23.11"; # Did you read the comment?

}

