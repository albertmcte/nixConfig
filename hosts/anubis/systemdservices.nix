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
    wantedBy = [ "default.target" ];
    description = "Monthly photo backup to Onedrive";
    path = ["/run/current-system/sw"];
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
  age.secrets.pushover_user.file = ../../secrets/pushover_user.age;
  age.secrets.pushover_token.file = ../../secrets/pushover_token.age;
}
