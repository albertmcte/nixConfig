{ lib, config, ... }:
{
  programs.fish.loginShellInit = lib.mkIf (config.hostVars.hyprStart != null) config.hostVars.hyprStart;
}
