let
  fetchKeys = username:
    (builtins.fetchurl {
      url = "https://github.com/${username}.keys";
      sha256 = "sha256:3b15b1cafc452937ef4ac9c79103038d8e37e650f81c11fe030cca563be7691e";
      }
    );
in
{
  users.mutableUsers = false;
  users.users = {
    wash = {
      isNormalUser = true;
      home = "/home/wash";
      extraGroups = ["wheel" "networkmanager" ];
      openssh.authorizedKeys.keyFiles = [ (fetchKeys "albertmcte") ];
      # passwordFile needs to be in a volume marked with `neededForBoot = true`
      passwordFile = "/persist/passwords/wash";
    };
  };
}
