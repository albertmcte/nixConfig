{ inputs, lib, pkgs, ...}:
{
  imports = [
    ./sys-default.nix
#    ./noexec.nix
    ./agenix.nix
    ./tailscale.nix
    ./sops.nix
    inputs.home-manager.nixosModules.home-manager
  ];

  systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;
  systemd.services.systemd-networkd-wait-online.enable = lib.mkForce false;
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.meslo-lg
    nerd-fonts.fira-code
  ];
}
