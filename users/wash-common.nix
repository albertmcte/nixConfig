{
  inputs,
  pkgs,
  config,
  myLib,
  ...
}:
{
  users.mutableUsers = false;

  home-manager.users.wash = {
    home = {
      username = "wash";
      homeDirectory = "/home/wash";
      stateVersion = "23.11";
    };
    programs.home-manager.enable = true;
    age = {
      identityPaths = [ "/home/wash/.ssh/id_ed25519" ];
      secretsDir = "/home/wash/.agenix/agenix";
      secretsMountPoint = "/home/wash/.agenix/agenix.d";
    };
    imports = [
      ../hm
    ];
  };

  users.users.wash = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    openssh.authorizedKeys.keyFiles = [ myLib.albertmcteKeys ];
    hashedPasswordFile = config.age.secrets.washpw.path;
    shell = pkgs.fish;
  };

  home-manager.sharedModules = [
    inputs.agenix.homeManagerModules.default
  ];

  age.secrets.washpw.file = ../secrets/washpw.age;
}
