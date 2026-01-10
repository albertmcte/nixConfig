{
  inputs,
  ...
}:
{
  imports = [
    inputs.impermanence.nixosModules.impermanence
  ];

  # always persist these
  environment.persistence."/persist" = {
    directories = [
      "/etc/nixos"
      "/etc/NetworkManager"
      # "/etc/ssh"
      "/var/log"
      "/var/lib"
    ];
    files = [
      "/etc/machine-id"
      #      "/etc/ssh/ssh_host_ed25519_key"
      #      "/etc/ssh/ssh_host_ed25519_key.pub"
      #      "/etc/ssh/ssh_host_rsa_key"
      #      "/etc/ssh/ssh_host_rsa_key.pub"
    ];
  };
}
