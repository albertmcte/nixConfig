{ pkgs, ... }:
{
  imports = [
    ../../modules/common
    ./hardware-configuration.nix
    ../../users/wash
  ];

  # Hyprland from nixpkgs (not the flake version)
  programs = {
    dconf.enable = true;
    hyprland = {
      enable = true;
      withUWSM = true;
      # Uses nixpkgs hyprland by not specifying package
    };
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Home-manager hyprland config with nixpkgs package
  home-manager.users.wash = {
    imports = [ ../../hm/hyprland.nix ];
    wayland.windowManager.hyprland = {
      package = pkgs.hyprland;
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
      plugins = []; # Flake plugins incompatible with nixpkgs hyprland
    };
  };

  networking = {
    hostName = "nixmacVM";
    hostId = "134d7ce5";
    networkmanager.enable = true;
  };
  time.timeZone = "America/New_York";

  system.stateVersion = "23.11";
}
