{
  inputs,
  outputs,
  pkgs,
  config,
  ...
}:

let
  fetchKeys =
    username:
    (builtins.fetchurl {
      url = "https://github.com/${username}.keys";
      sha256 = "07m39l23wv0ifxwcr0gsf1iv6sfz1msl6k96brxr253hfp71h18c";
    });
in
{
  users.mutableUsers = false;
  home-manager.users.wyatt = {
    home.username = "wyatt";
    home.homeDirectory = "/home/wyatt";
    programs.home-manager.enable = true;
    home.stateVersion = "23.11";
    # nixpkgs.config.allowUnfree = true;
    age = {
      identityPaths = [ "/home/wyatt/.ssh/id_ed25519" ];
      secretsDir = "/home/wyatt/.agenix/agenix";
      secretsMountPoint = "/home/wyatt/.agenix/agenix.d";
    };
    imports = [
      ../../hm
      ../../hm/gnome.nix
    ];
  };

  home-manager.sharedModules = [
    inputs.agenix.homeManagerModules.default
  ];

  users.users = {
    wyatt = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "networkmanager"
      ];
      openssh.authorizedKeys.keyFiles = [ (fetchKeys "albertmcte") ];
      hashedPasswordFile = config.age.secrets.wyattpw.path;
      shell = pkgs.fish;
      packages = with pkgs; [
        firefox
        tree
        kodi
        _1password-gui
      ];
    };
  };
  age.secrets.wyattpw.file = ../../secrets/wyattpw.age;
}
