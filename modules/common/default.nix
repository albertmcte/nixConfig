{ lib, config, pkgs, ...}:
{
  imports = [
    ./sys-default.nix
#    ./noexec.nix
    ./agenix.nix
    ./tailscale.nix
    inputs.home-manager.nixosModule
    inputs.sops-nix.nixosModules.sops
  ];
  sops = {
    defaultSopsFile = ../../secrets/sopss.yaml;
    defaultSopsFormat = "yaml";
    age.sshKeyPaths = [
      "/etc/ssh/ssh_host_ed25519_key"
      "/home/wash/.ssh/id_ed25519"
    ];
  };
  systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;
  systemd.services.systemd-networkd-wait-online.enable = lib.mkForce false;
  fonts.packages = with pkgs; [
    recursive
    (nerdfonts.override { fonts = [ "JetBrainsMono" "Meslo" "FiraCode" ]; })
  ];
}
