{
  inputs,
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

  home-manager.users.wash = {
    home = {
      username = "wash";
      homeDirectory = "/home/wash";
      stateVersion = "23.11";
    };
    programs.home-manager.enable = true;
    # nixpkgs.config.allowUnfree = true;
    age = {
      identityPaths = [ "/home/wash/.ssh/id_ed25519" ];
      secretsDir = "/home/wash/.agenix/agenix";
      secretsMountPoint = "/home/wash/.agenix/agenix.d";
    };
    imports = [
      ../../hm
      ../../hm/desktop-hypr.nix
    ];
  };

  users.users = {
    wash = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "networkmanager"
      ];
      openssh.authorizedKeys.keyFiles = [ (fetchKeys "albertmcte") ];
      # hashedPasswordFile needs to be in a volume marked with `neededForBoot = true`
      hashedPasswordFile = config.age.secrets.washpw.path;
      shell = pkgs.fish;
    };
  };

  #home-manager secrets still not working

  home-manager.sharedModules = [
    inputs.agenix.homeManagerModules.default
  ];

  age.secrets.washpw.file = ../../secrets/washpw.age;

}
