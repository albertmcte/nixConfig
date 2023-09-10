{
  inputs,
  config,
  pkgs,
  ...
}: {
  imports = [
    inputs.impermanence.nixosModules.impermanence
  ];

### TODO - break these security settings into seperate module

  fileSystems."/".options = [ "noexec" ];
  fileSystems."/etc/nixos".options = [ "noexec" ];
  fileSystems."/var/log".options = [ "noexec" ];

#  nix.settings.allowed-users = [ "@wheel" ];

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