{ inputs, pkgs, config, ... }:

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

#  sops.secrets.wash_pw.neededForUsers = true;
  
  home-manager.users.wash = {
    home = {
      username = "wash";
      homeDirectory = "/home/wash";
      stateVersion = "23.11";
    };
    programs.home-manager.enable = true;
    nixpkgs.config.allowUnfree = true;
    age = {
      identityPaths = [ "/home/wash/.ssh/id_ed25519" ];
      secretsDir = "/home/wash/.agenix/agenix";
      secretsMountPoint = "/home/wash/.agenix/agenix.d";
    };
    imports = [
      ../../hm
      ../../hm/desktop-wayland.nix
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

#home-manager secrets still not working

  home-manager.sharedModules = [
    inputs.sops-nix.homeManagerModules.sops
    inputs.agenix.homeManagerModules.default
  ];

  age.secrets.washpw.file = ../../secrets/washpw.age;

}
