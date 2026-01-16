{ pkgs, lib, ... }:
{
  imports = [
    ../../modules/common
    ../../modules/desktop
    ./hardware-configuration.nix
    ../../users/wash-desktop
  ];

  # Hyprland from nixpkgs (not the flake version)
  # programs = {
  #   dconf.enable = true;
  #   hyprland = {
  #     enable = true;
  #     withUWSM = true;
  #     # Uses nixpkgs hyprland by not specifying package
  #   };
  # };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Home-manager hyprland config with nixpkgs package
  # home-manager.users.wash = {
  #   imports = [ ../../hm/hyprland.nix ];
  #   wayland.windowManager.hyprland = {
  #     package = lib.mkForce pkgs.hyprland;
  #     portalPackage = lib.mkForce pkgs.xdg-desktop-portal-hyprland;
  #     plugins = lib.mkForce []; # Flake plugins incompatible with nixpkgs hyprland
  #   };
  # };

  networking = {
    hostName = "nixmacVM";
    hostId = "134d7ce5";
    networkmanager.enable = true;
  };
  time.timeZone = "America/New_York";

  system.stateVersion = "23.11";
}
