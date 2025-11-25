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

  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 23;
        modules-left = [ "sway/workspaces" "sway/mode" "wlr/taskbar" ];
        modules-center = [ "sway/window" ];
        modules-right = [ "custom/wireguard" "network" "pulseaudio" "cpu" "clock" ];
        "sway/workspaces" = {
          disable-scroll = true;
          format = "{icon}";
          all-outputs = true;
          format-icons = {
            "1:code" = "<U+F121>";
            "2:web" = "<U+E745>";
            "3:term" = "<U+F120>";
            "4:email" = "<U+F0E0>";
          }; 
        };
      };
    };
  };
  
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

