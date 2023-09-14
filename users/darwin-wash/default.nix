{ inputs, outputs, pkgs, config, ... }:
{
  environment.shells = [ pkgs.fish ];
  users.users = {
    wash = {
      name = "wash";
      home = "/Users/wash/";
#      openssh.authorizedKeys.keyFiles = [ (fetchKeys "albertmcte") ];
#      passwordFile = config.age.secrets.washpw.path;
      shell = pkgs.fish;
    };
  };
  home-manager.users.wash = {
    programs.home-manager.enable = true;
    home.stateVersion = "23.05";
    nixpkgs.config.allowUnfree = true;
    imports = [
      ../../hm
      ../../hm/darwin.nix
    ];
  };
#  age.secrets.washpw.file = ../../secrets/washpw.age;

}
