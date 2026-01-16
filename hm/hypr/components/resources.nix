{ config, ... }:
{
  imports = [
    ../../common/resources.nix
  ];

  home.file."${config.xdg.configHome}/waybar" = {
    source = ../../waybar;
    recursive = true;
  };
}
