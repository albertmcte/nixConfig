{ pkgs, ... }:
{
  systemd.user.services = {
    maestral = {
      Unit = {
        Description = "Maestral Dropbox client";
        After = [ "network-online.target" ];
      };
      Service = {
        ExecStart = "${pkgs.maestral}/bin/maestral start --foreground";
        Restart = "on-failure";
        RestartSec = "5s";
      };
      Install = {
        WantedBy = [ "default.target" ];
      };
    };
    hyprpaper = {
      Unit = {
        Description = "Hyprpaper User Service";
        After = [ "graphical-session.target" ];
      };
      Service = {
        ExecStart = "${pkgs.hyprpaper}/bin/hyprpaper";
        Restart = "on-failure";
        RestartSec = "5s";
      };
      Install = {
        WantedBy = [ "default.target" ];
      };
    };
  };
}
