{ inputs, lib, config, pkgs, ...}:
{
  imports = [
    ./sys-default.nix
#    ./noexec.nix
    ./agenix.nix
    ./tailscale.nix
    ./sops.nix
    inputs.home-manager.nixosModule
  ];

  systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;
  systemd.services.systemd-networkd-wait-online.enable = lib.mkForce false;
  fonts.packages = with pkgs; [
    recursive
    (nerdfonts.override { fonts = [ "JetBrainsMono" "Meslo" "FiraCode" ]; })
  ];
}
