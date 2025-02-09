{ inputs, outputs, pkgs, config, ... }:

let
  fetchKeys = username:
    (builtins.fetchurl {
      url = "https://github.com/${username}.keys";
      sha256 = "14wi3yv3pn7nd0rnf0y6yxyi2yihb3p3fspihybzpxzgwclfpha8";
      }
  );
in
{
  users.mutableUsers = false;
  home-manager.users.wyatt = {
    home.username = "wyatt";
    home.homeDirectory = "/home/wyatt";
    programs.home-manager.enable = true;
    home.stateVersion = "23.11";
    nixpkgs.config.allowUnfree = true;
    imports = [
      ../../hm
      ../../hm/gnome.nix
    ];
  };
  users.users = {
    wyatt = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" ];
      openssh.authorizedKeys.keyFiles = [ (fetchKeys "albertmcte") ];
      hashedPasswordFile = config.age.secrets.wyattpw.path;
      shell = pkgs.fish;
      packages = with pkgs; [
        firefox
        tree
        kodi
        _1password-gui
        skypeforlinux
      ];
    };
  };
  age.secrets.wyattpw.file = ../../secrets/wyattpw.age;
}
