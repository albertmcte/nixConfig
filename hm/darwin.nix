{ lib, config, pkgs, inputs, ... }: 
{
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    PATH = "$PATH";
  };
  home.packages = with pkgs; [
    mosh
    nmap
    rclone
    rsync
    stow
    openssh
#    pyenv            #only in unstable, hm problems, moved to system
    mas
#    jq               #don't think i need this
#    youtube-dl
#    media-downloader #gui haven't tried it
  ];
}
