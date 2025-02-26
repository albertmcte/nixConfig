{ 
  config,
  pkgs, 
  ... 
}: {
  home.packages = with pkgs; [
    # rofi
    # kodi
    # nemo
    # pywal
    # dunst
    # firefox
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
  # home.file.".xinitrc" = {
  #   source = ./xinitrc;
  #   recursive = true;
  # };
  # home.file.".Xresources" = {
  #   source = ./Xresources;
  #   recursive = true;
  # };
  imports = [
    ./hyperwm
  ];
}

