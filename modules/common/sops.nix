{ inputs, ... }:
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
  sops.secrets.test_secret = {
    path = "/home/wash/.config/test_secret.txt";
    owner = "wash";
#    mode = "400";
  };
}
