{ pkgs, ... }:
{
  home.packages = with pkgs; [
    wofi
    nemo
    _1password-gui
    swaynotificationcenter
    wayvnc
    maestral
    maestral-gui
    hyprpaper
    waytrogen
    mpvpaper
  ];
}
