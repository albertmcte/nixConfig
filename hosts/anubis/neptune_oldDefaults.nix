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
    ../../modules/common
    ./hardware-configuration.nix
    ./sanoid.nix
    ./syncoid.nix
    ../../users/wash
    ../../modules/server
    # cloudflare
  ];

  networking.hostName = "neptune";
  time.timeZone = "UTC";

  boot.zfs.extraPools = [ "mercury" ];

  fileSystems."/mercury/movies" = {
    device = "/nfs/movies";
    options = [ "bind,defaults,nofail,x-systemd.requires=zfs-mount.service" ];
  };
  fileSystems."/mercury/music" = {
    device = "/nfs/music";
    options = [ "bind,defaults,nofail,x-systemd.requires=zfs-mount.service" ];
  };
  fileSystems."/mercury/tv" = {
    device = "/nfs/tv";
    options = [ "bind,defaults,nofail,x-systemd.requires=zfs-mount.service" ];
  };
  fileSystems."/mercury/vids" = {
    device = "/nfs/vids";
    options = [ "bind,defaults,nofail,x-systemd.requires=zfs-mount.service" ];
  };
  fileSystems."/mercury/homevids" = {
    device = "/nfs/homevids";
    options = [ "bind,defaults,nofail,x-systemd.requires=zfs-mount.service" ];
  };
  fileSystems."/mercury/photos" = {
    device = "/nfs/photos";
    options = [ "bind,defaults,nofail,x-systemd.requires=zfs-mount.service" ];
  };
  fileSystems."/mercury/mollyimages" = {
    device = "/nfs/mollyimages";
    options = [ "bind,defaults,nofail,x-systemd.requires=zfs-mount.service" ];
  };

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

  services.nfs.server.enable = true;
  services.nfs.server.exports = ''
    /nfs 10.0.1.0/24(rw,fsid=0,all_squash,insecure,no_subtree_check,async)
    /nfs 10.0.2.0/24(rw,fsid=0,all_squash,insecure,no_subtree_check,async)
    /nfs 10.0.3.0/24(rw,fsid=0,all_squash,insecure,no_subtree_check,async)

    /nfs/movies 10.0.2.0/24(rw,nohide,all_squash,insecure,no_subtree_check,anonuid=1000,anongid=1000,async) 10.0.1.0/24(rw,nohide,all_squash,insecure,no_subtree_check,anonuid=1000,anongid=1000,async) 10.0.3.0/24(rw,nohide,all_squash,insecure,no_subtree_check,anonuid=1000,anongid=1000,async) 

    /nfs/music 10.0.2.0/24(rw,nohide,all_squash,insecure,no_subtree_check,anonuid=1000,anongid=1000,async) 10.0.1.0/24(rw,nohide,all_squash,insecure,no_subtree_check,anonuid=1000,anongid=1000,async) 10.0.3.0/24(rw,nohide,all_squash,insecure,no_subtree_check,anonuid=1000,anongid=1000,async) 

    /nfs/vids 10.0.2.0/24(rw,nohide,all_squash,insecure,no_subtree_check,anonuid=1000,anongid=1000,async) 10.0.1.0/24(rw,nohide,all_squash,insecure,no_subtree_check,anonuid=1000,anongid=1000,async) 10.0.3.0/24(rw,nohide,all_squash,insecure,no_subtree_check,anonuid=1000,anongid=1000,async)

    /nfs/tv 10.0.2.0/24(rw,nohide,all_squash,insecure,no_subtree_check,anonuid=1000,anongid=1000,async) 10.0.1.0/24(rw,nohide,all_squash,insecure,no_subtree_check,anonuid=1000,anongid=1000,async) 10.0.3.0/24(rw,nohide,all_squash,insecure,no_subtree_check,anonuid=1000,anongid=1000,async)

    /nfs/homevids 10.0.2.0/24(rw,nohide,all_squash,insecure,no_subtree_check,anonuid=1000,anongid=1000,async) 10.0.1.0/24(rw,nohide,all_squash,insecure,no_subtree_check,anonuid=1000,anongid=1000,async) 10.0.3.0/24(rw,nohide,all_squash,insecure,no_subtree_check,anonuid=1000,anongid=1000,async)

    /nfs/photos 10.0.2.0/24(rw,nohide,all_squash,insecure,no_subtree_check,anonuid=1000,anongid=1000,async) 10.0.1.0/24(rw,nohide,all_squash,insecure,no_subtree_check,anonuid=1000,anongid=1000,async) 10.0.3.0/24(rw,nohide,all_squash,insecure,no_subtree_check,anonuid=1000,anongid=1000,async)

    /nfs/mollyimages 10.0.2.0/24(rw,nohide,all_squash,insecure,no_subtree_check,anonuid=1000,anongid=1000,async) 10.0.1.0/24(rw,nohide,all_squash,insecure,no_subtree_check,anonuid=1000,anongid=1000,async)
  '';
  networking.firewall.allowedTCPPorts = [ 2049 ];

  services.plex = {
    enable = true;
    openFirewall = true;
  };

  system.stateVersion = "23.11";
}
