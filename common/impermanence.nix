{
  config,
  pkgs,
  impermanence,
  ...
}: {
  imports = [
    impermanence.nixosModule
  ];

  # filesystems
#  fileSystems."/".options = ["compress=zstd" "noatime"];
#  fileSystems."/home".options = ["compress=zstd" "noatime"];
#  fileSystems."/nix".options = ["compress=zstd" "noatime"];
#  fileSystems."/persist".options = ["compress=zstd" "noatime"];
#  fileSystems."/persist".neededForBoot = true;
#  fileSystems."/var/log".options = ["compress=zstd" "noatime"];
#  fileSystems."/var/log".neededForBoot = true;

  # always persist these
  environment.persistence."/persist" = {
    directories = [
      "/etc/nixos"
      "/etc/NetworkManager"
      "/var/log"
      "/var/lib"
    ];
    files = [
      "/etc/machine-id"
      "/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_ed25519_key.pub"
      "/etc/ssh/ssh_host_rsa_key"
      "/etc/ssh/ssh_host_rsa_key.pub"
    ];
  };
}
