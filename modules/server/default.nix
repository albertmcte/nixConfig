{ pkgs, config, ... }:
{
  services = {
    getty.autologinUser = config.hostVars.primaryUser;
    ntopng.enable = true;
  };
  environment.systemPackages = [
    pkgs.geoipupdate
  ];
}
