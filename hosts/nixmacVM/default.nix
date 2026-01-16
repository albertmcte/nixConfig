{ pkgs, lib, ... }:
{
  imports = [
    ../../modules/common
    ../../modules/desktop/bspwm.nix
    ./hardware-configuration.nix
    ../../users/wash-vm
  ];

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  networking = {
    hostName = "nixmacVM";
    hostId = "134d7ce5";
    networkmanager.enable = true;
  };
  time.timeZone = "America/New_York";

  # Host-specific variables for Hyprland/desktop
  hostVars = {
    browser = "google-chrome-stable";
    terminal = "kitty";
    keyboardLayout = "us";
    consoleKeyMap = "us";
  };

  system.stateVersion = "23.11";
}
