{ pkgs, ... }: 
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
    mas
#    pyenv            #only in unstable, hm problems, moved to system
#    jq               #don't think i need this
#    youtube-dl
#    media-downloader #gui haven't tried it
  ];
  home.file."./bin" = {
    source = ./macbin;
    recursive = true;
  };
 home.file.".config/sketchybar" = {
   source = ./sketchybar;
   recursive = true;
 };
  sops = {
    defaultSopsFile = ../../secrets/sopss.yaml;
    age.sshKeyPaths = [ 
      "/Users/wash/.ssh/id_ed25519"
    ];
  };
}
