let
  fetchKeys = username:
    (builtins.fetchurl {
      url = "https://github.com/${username}.keys";
      sha256 = "sha256:07k9wwxmdjhc0gz1277qa3k3g3ld0c1r3iy99bpkfaa5zk5b259v";
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
