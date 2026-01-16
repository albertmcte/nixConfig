{
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./common/resources.nix
    ./bspwm
  ];

  home.packages = with pkgs; [
    rofi
    kodi
    nemo
    pywal
    dunst
    firefox
    _1password-gui
  ];

  home.file.".xinitrc" = {
    source = ./xinitrc;
    recursive = true;
  };
  home.file.".Xresources" = {
    source = ./Xresources;
    recursive = true;
  };
}
