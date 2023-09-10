{ 
  config,
  pkgs, 
  inputs,
  ... 
}: {
  home.packages = with pkgs; [
    rofi
    kodi
    cinnamon.nemo
    pywal
    dunst
    firefox
    _1password-gui
  ];
  home.file."${config.xdg.configHome}" = {
    source = ./ricerscripts;
    recursive = true;
  };
  home.file."${config.xdg.configHome}" = {
    source = ./wallpapers;
    recursive = true;
  };
  imports = [
    ./bspwm
  ];
}

