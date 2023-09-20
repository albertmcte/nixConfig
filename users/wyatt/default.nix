{ inputs, outputs, pkgs, config, ... }:

let
  fetchKeys = username:
    (builtins.fetchurl {
      url = "https://github.com/${username}.keys";
      sha256 = "1qczxlypy0y4s52v25z6k1j28ssiwmx3666c9n652a3m8z9z1lh8";
      }
  );
in
{
  users.mutableUsers = false;
  home-manager.users.wyatt = {
    home.username = "wyatt";
    home.homeDirectory = "/home/wyatt";
    programs.home-manager.enable = true;
    home.stateVersion = "23.05";
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
      passwordFile = config.age.secrets.wyattpw.path;
      shell = pkgs.fish;
      packages = with pkgs; [
        firefox
        tree
        kodi
        _1password-gui
        skypeforlinux
        mailspring
      ];
    };
  };
  age.secrets.wyattpw.file = ../../secrets/wyattpw.age;
}
