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
  home.file."${config.xdg.configHome}/ricescripts" = {
    source = ./ricescripts;
    recursive = true;
  };
  home.file."${config.xdg.configHome}/wallpapers" = {
    source = ./wallpapers;
    recursive = true;
  };
  imports = [
    ./bspwm
  ];
}

