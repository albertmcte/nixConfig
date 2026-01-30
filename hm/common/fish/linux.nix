{ lib, config, pkgs, ... }:
{
  programs.fish.loginShellInit = lib.mkIf (pkgs.stdenv.isLinux && config.hostVars.hyprStart != null) config.hostVars.hyprStart;
}
