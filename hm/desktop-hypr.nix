{ config, pkgs, ... }:
{
home.packages = with pkgs; [
    wofi
    microsoft-edge
    # kodi
    nemo
    # pywal
    # dunst
    # firefox
    _1password-gui
    swaynotificationcenter
    wayvnc
  ];

  programs.waybar.enable = true;
  
  home.file."${config.xdg.configHome}/ricescripts" = {
    source = ./ricescripts;
    recursive = true;
  };
  home.file."${config.xdg.configHome}/wallpapers" = {
    source = ./wallpapers;
    recursive = true;
  };
  home.file."${config.xdg.configHome}/waybar" = {
    source = ./waybar;
    recursive = true;
  };
  imports = [
    ./hypr
  ];
}

