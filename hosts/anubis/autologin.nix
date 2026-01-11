{ ... }:

let
  username = "wash";
in
{
  # Autologin on TTY1
  services.getty.autologinUser = "${username}";
}
