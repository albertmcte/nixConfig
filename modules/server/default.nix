{ config, pkgs, ... }:
{
  imports = [
    #    ./resilio.nix
    #    ./monit.nix
    #    ./syncoid.nix
    #    ./wireguard.nix
  ];
  services = {
    getty.autologinUser = "wash";
    ntopng.enable = true;
  };
}
