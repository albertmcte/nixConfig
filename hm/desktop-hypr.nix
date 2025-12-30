{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    wofi
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
        height = 25;
        modules-left = [
          "hyprland/workspaces"
          "hyprland/submap"
        ];
        modules-center = [
          "hyprland/window"
        ];
        modules-right = [
          "wlr/taskbar"
          "custom/wireguard"
          "network"
          "pulseaudio"
          "cpu"
          "clock"
        ];
        "hyprland/workspaces" = {
          disable-scroll = true;
          format = "{icon}";
          all-outputs = true;
          format-icons = {
            "1" = "";  # code icon
            "2" = "";  # web icon
            "3" = "";  # terminal icon
            "4" = "";  # email icon
            # "5" = "󱧶";  # file icon
            # "6" = "󰌳";  # music icon
            # "7" = "";  # video icon
            # "8" = "\uf1fc";  # paint icon
            # "9" = "\uf013";  # settings icon
            # "10" = "\uf013"; # settings icon
          };
        };
        "hyprland/window" = {
          format = "{title}";
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
