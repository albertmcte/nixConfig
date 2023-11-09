# /usr/sbin/syncoid -r --skip-parent --no-privilege-elevation -sshport=31225 wash@andromeda:io mercury
{ config, pkgs, lib, ... }:
{
  services.syncoid = {
    enable = true;
    user = "wash";
    group = "users";
    commonArgs = [ "--skip-parent" "--recursive" ];
    interval = "*-*-* 13:00:00";
    commands."io_backup" = {
      sshKey = "/home/wash/.ssh/id_ed25519";
      extraArgs = [ "-sshport=31225" ];
      source = "wash@andromeda:io";
      target = "mercury";
    };
  };
    systemd.services.syncoid-io_backup.serviceConfig.ProtectHome = lib.mkForce "read-only";
    systemd.services.syncoid-io_backup.serviceConfig.RootDirectory = lib.mkForce "";
    systemd.services.syncoid-io_backup.serviceConfig.RuntimeDirectory = lib.mkForce "";

}
#  systemd.services.io_backup = {
#    description = "Syncoid backup from io to mercury";
#    after = [ "network-online.target" ];
#    wantedBy = [ "sanoid.service" ];
#    serviceConfig = {
#      ExecStart = "${pkgs.sanoid}/bin/syncoid --no-privilege-elevation --skip-parent --recursive -sshport=31225 wash@andromeda:io mercury";
#      User = "wash";
#    };
#    path = [ pkgs.openssh pkgs.sanoid pkgs.zfs ];
#  };
#  systemd.timers.io_backup = {
#      wantedBy = [ "timers.target" ];
#      partOf = [ "io_backup.service" ];
#      timerConfig.OnCalendar = [ "*-*-* 13:00:00" ];
#    };
#}
