{ pkgs, config, ... }:

let
  fetchKeys = username:
    (builtins.fetchurl {
      url = "https://github.com/${username}.keys";
      sha256 = "sha256:3b15b1cafc452937ef4ac9c79103038d8e37e650f81c11fe030cca563be7691e";
      }
    );
in
{
  users.mutableUsers = false;
  home-manager.users.wash = {
    home.username = "wash";
    home.homeDirectory = "/home/wash";
    programs.home-manager.enable = true;
    home.stateVersion = "23.05";
    imports = [
        ../../hm
    ];
  };
  users.users = {
    wash = {
      isNormalUser = true;
      extraGroups = ["wheel" "networkmanager" ];
      openssh.authorizedKeys.keyFiles = [ (fetchKeys "albertmcte") ];
      # passwordFile needs to be in a volume marked with `neededForBoot = true`
      passwordFile = "/persist/passwords/wash";
      shell = pkgs.fish;
    };
  };
}
