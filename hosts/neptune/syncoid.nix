# /usr/sbin/syncoid -r --skip-parent --no-privilege-elevation -sshport=31225 wash@10.0.0.6:io mercury
{
services.syncoid = {
    enable = true;
    user = "wash";
    commonArgs = [ "--no-privilege-elevation" "--skip-parent" "--recursive" ];
    sshKey = "/home/wash/.ssh/id_ed25519";
    interval = "*-*-* *:15:00";
    commands."io_backup" = {
      extraArgs = "--sshport 31225";
      source = "wash@andromeda:io";
      target = "mercury";
    };
    };
}
