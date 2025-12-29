{ pkgs, ... }:
{
  systemd.timers.rcloneOnedrive = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "*-*~01 22:00";
      Unit = "rcloneOnedrive.service";
    };
  };
  systemd.services.rcloneOnedrive = {
    enable = true;
    after = [ "network.target" ];
    description = "Monthly photo backup to Onedrive";
    path = [ "/run/current-system/sw" ];
    serviceConfig = {
      Type = "oneshot";
      # ExecStart = [
      #   "/home/wash/linuxbin/rcloneOnedrive.sh"
      #   "/home/wash/linuxbin/rcloneMusic.sh"
      # ];
      User = "wash";
      Group = "users";
    };
    script = "${./rcloneOnedrive.sh}";
  };
  systemd.user.services.wayvnc-service = {
    enable = true;
    after = [ "network.target" ];
    wantedBy = [ "default.target" ];
    description = "Automatically start Wayvnc";
    serviceConfig = {
      Type = "simple";
      ExecStart = ''${pkgs.wayvnc}/bin/wayvnc 0.0.0.0 -o HDMI-A-1'';
    };
  };
  age.secrets.pushover_user.file = ../../secrets/pushover_user.age;
  age.secrets.pushover_token.file = ../../secrets/pushover_token.age;
}
