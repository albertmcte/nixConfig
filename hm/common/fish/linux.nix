{ lib, osConfig, pkgs, ... }:
{
  programs.fish.loginShellInit = lib.mkIf (pkgs.stdenv.isLinux && osConfig.hostVars.hyprStart != null) osConfig.hostVars.hyprStart;
}
