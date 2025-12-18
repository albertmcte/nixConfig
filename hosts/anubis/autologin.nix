{ pkgs, config, ... }:

let
  session = "${pkgs.hyprland}/bin/Hyprland";
  username = "wash";
in
{
  services.greetd = {
    enable = true;
    settings = {
      initial_session = {
        command = "${session}";
        user = "${username}";
      };
      default_session = {
        command = "${pkgs.util-linux}/sbin/agetty agetty --login-program ${config.services.getty.loginProgram} --autologin ${username} --noclear --keep-baud %I 115200,38400,9600 $TERM";
      };
    };
  };
}
