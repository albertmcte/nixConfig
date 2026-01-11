{ config, ... }:
{
  home.file."${config.xdg.configHome}/ricescripts" = {
    source = ../../ricescripts;
    recursive = true;
  };
  home.file."${config.xdg.configHome}/wallpapers" = {
    source = ../../wallpapers;
    recursive = true;
  };
  home.file."${config.xdg.configHome}/waybar" = {
    source = ../../waybar;
    recursive = true;
  };
}
