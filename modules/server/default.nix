{ pkgs, ... }:
{
  services = {
    getty.autologinUser = "wash";
    ntopng.enable = true;
  };
  environment.systemPackages = [
    pkgs.geoipupdate
  ];
}
