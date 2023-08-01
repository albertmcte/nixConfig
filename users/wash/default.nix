{ pkgs, config, ... }:

let
  fetchKeys = username:
    (builtins.fetchurl {
      url = "https://github.com/${username}.keys";
      sha256 = "sha256:0cgzygs5y09mk75s4prrdyf5l5cvbcdxisb9pxgszycvnfdpzg11";
      }
  );
in
{
  users.mutableUsers = false;
#  sops.secrets.wash_pw.neededForUsers = true;
  home-manager.users.wash = {
    home.username = "wash";
    home.homeDirectory = "/home/wash";
    programs.home-manager.enable = true;
    home.stateVersion = "23.05";
    nixpkgs.config.allowUnfree = true;
    imports = [
      ../../hm
      ../../hm/anubis.nix
    ];
  };
  users.users = {
    wash = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" ];
      openssh.authorizedKeys.keyFiles = [ (fetchKeys "albertmcte") ];
      # passwordFile needs to be in a volume marked with `neededForBoot = true`
      passwordFile = "/persist/passwords/wash";
#      passwordFile = config.age.secrets.washpw.path;
#      passwordFile = "config.sops.secrets.wash_pw.path";
      shell = pkgs.fish;
    };
  };
  age.secrets.washpw.file = ../../secrets/washpw.age;
}
