{ inputs, pkgs, ... }:
let
  fetchKeys = username:
    (builtins.fetchurl {
      url = "https://github.com/${username}.keys";
      sha256 = "07m39l23wv0ifxwcr0gsf1iv6sfz1msl6k96brxr253hfp71h18c";
      }
    );
in
{
  environment.shells = [ pkgs.fish ];
  users.users = {
    wash = {
      name = "wash";
      home = "/Users/wash";
      openssh.authorizedKeys.keyFiles = [ (fetchKeys "albertmcte") ];
#      hashedPasswordFile = config.age.secrets.washpw.path;
      shell = pkgs.fish;
    };
  };

  home-manager.users.wash = {
    programs.home-manager.enable = true;
    home.stateVersion = "24.11";
    nixpkgs.config.allowUnfree = true;
    age = {
      identityPaths = [ "/Users/wash/.ssh/id_ed25519" ];
      secretsMountPoint = "/Users/wash/.agenix/agenix.d";
      secretsDir = "/Users/wash/.agenix/agenix";
    };
    imports = [
      ../../hm
      ../../hm/darwin.nix
    ];
  };

  home-manager.sharedModules = [
    inputs.sops-nix.homeManagerModules.sops
    inputs.agenix.homeManagerModules.default
  ];

#  age.secrets.washpw.file = ../../secrets/washpw.age;

}
