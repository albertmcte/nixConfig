{ inputs, outputs, pkgs, config, ... }:

let
  fetchKeys = username:
    (builtins.fetchurl {
      url = "https://github.com/${username}.keys";
      sha256 = "0qi8vf3mkqapzfwpw9qnf6nsxp4s0zrrzg452cnz0d9wm13hfpwx";
      }
  );
in
{
  users.mutableUsers = false;
#  sops.secrets.wash_pw.neededForUsers = true;
  home-manager.users.wash = {
    home = {
      username = "wash";
      homeDirectory = "/home/wash";
      stateVersion = "23.11";
    };
    programs.home-manager.enable = true;
    nixpkgs.config.allowUnfree = true;
    imports = [
      ../../hm
      ../../hm/desktop.nix
    ];
  };
  users.users = {
    wash = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" ];
      openssh.authorizedKeys.keyFiles = [ (fetchKeys "albertmcte") ];
      # hashedPasswordFile needs to be in a volume marked with `neededForBoot = true`
#      hashedPasswordFile = "/persist/passwords/wash";
      hashedPasswordFile = config.age.secrets.washpw.path;
#      hashedPasswordFile = "config.sops.secrets.wash_pw.path";
      shell = pkgs.fish;
    };
  };
  age.secrets.washpw.file = ../../secrets/washpw.age;
}
