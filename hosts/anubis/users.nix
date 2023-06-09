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
