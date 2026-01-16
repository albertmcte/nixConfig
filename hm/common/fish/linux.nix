{ inputs, pkgs, lib, ... }:
{
  programs.fish.loginShellInit = lib.mkIf (!pkgs.stdenv.isDarwin) ''
    # Auto-start Hyprland via uwsm on TTY1
    if test (tty) = "/dev/tty1"
      if uwsm check may-start
        exec uwsm start ${inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland}/bin/start-hyprland
      end
    end
  '';
}
