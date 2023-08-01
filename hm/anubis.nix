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
    polybar
    firefox
    picom
    _1password-gui
  ];
}

