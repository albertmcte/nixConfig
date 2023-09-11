{ inputs, outputs, pkgs, config, ... }:

let
  fetchKeys = username:
    (builtins.fetchurl {
      url = "https://github.com/${username}.keys";
      sha256 = "sha256:04yk4aarf64q3iv61rnnz1kyj2ggsnsydknp4xrr1ia8956rzlgh";
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
      ../../hm/desktop.nix
    ];
  };
  users.users = {
    wyatt = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" ];
      openssh.authorizedKeys.keyFiles = [ (fetchKeys "albertmcte") ];
      passwordFile = config.age.secrets.wyattpw.path;
      shell = pkgs.fish;
    };
  };
  age.secrets.wyattpw.file = ../../secrets/wyattpw.age;
}
