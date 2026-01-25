{ lib, osConfig, ... }:
{
  programs.fish.loginShellInit = lib.mkIf (osConfig.hostVars.hyprStart != null) osConfig.hostVars.hyprStart;
}
