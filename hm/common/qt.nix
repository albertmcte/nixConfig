{ pkgs, lib, ... }:
{
  qt = lib.mkIf pkgs.stdenv.isLinux {
    enable = true;
    platformTheme.name = "gtk";
    style.name = "adwaita-dark";
  };
}
