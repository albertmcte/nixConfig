{ inputs, config, ... }:
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops = {
    defaultSopsFile = ../../secrets/sopss.yaml;
    age = {
      sshKeyPaths = [ 
        "/etc/ssh/ssh_host_ed25519_key"
        "/home/wash/.ssh/id_ed25519"
      ];
    };
  };
}
