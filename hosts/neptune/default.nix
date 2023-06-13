# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  ...
}:
  {
  imports = [
    ../../common
    ./hardware-configuration.nix
    ./sanoid.nix
    ./syncoid.nix
    ../../users/wash
    ../../server
  ];

  networking.hostName = "neptune";
  time.timeZone = "UTC";

  boot.zfs.extraPools = [ "mercury" ];

  ### Tune max arc size 
  # boot.kernelParams = [ "zfs.zfs_arc_max=12884901888" ];
  ### it waswas 16GB (16821673984)

  ### For ZFS support
  # generate with "head -c4 /dev/urandom | od -A none -t x4"
  #  networking.hostId = "fd91c922";

  ### monthly scrubs
  # services.zfs.autoScrub = {
  #   enable = true;
  #   interval = "OnCalendar=*-*-01 05:00:00";
  # };

  
  services.nfs.server = {
    enable = true;
    exports = ''
      /mnt/nas/ *(rw,fsid=root,no_subtree_check)
      ${concatMapStringsSep "\n" (n: "/mnt/nas/${n} *(rw,nohide,all_squash,insecure,no_subtree_check,anonuid=1000,anongid=1000,asyn)") shares}
    '';
  };

  services.plex = {
    enable = true;
    openFirewall = true;
  };

  system.stateVersion = "23.05";
}
