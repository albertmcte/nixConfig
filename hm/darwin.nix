{ lib, config, pkgs, inputs, ... }: 
{
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    PATH = "$PATH";
  };
  home.packages = with pkgs; [
    mosh
    nodejs_20  #for github copilot
    nmap
    rclone
    rsync
    stow
    openssh
    pyenv
    mas
#    jq               #don't think i need this
#    youtube-dl
#    media-downloader #gui haven't tried it
  ];
}
