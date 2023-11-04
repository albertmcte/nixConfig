{ inputs, config, pkgs, ... }:
let
  unstable = import inputs.nixpkgs-unstable {
    system = pkgs.system;
    config.allowUnfree = true;
  };
in
{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  # Possibly just use 'nixos-install --no-root-passwd'
  users.users.root.hashedPassword = "!";

  # Security
  security.sudo.extraConfig = "Defaults lecture = never";
  nix.settings.allowed-users = [ "@wheel" ];
  
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "zfs" ];
  boot.zfs.forceImportRoot = false;
  boot.kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;

  networking.networkmanager.enable = true;
  
  environment.systemPackages = with pkgs; [
    git
    neovim
    unstable.eza
  ];
  
  programs.fish.enable = true;

  environment.shells = with pkgs; [
    fish
  ];

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.PermitRootLogin = "no";
    settings.KbdInteractiveAuthentication = false;
    openFirewall = true;
    extraConfig = ''
      AllowTcpForwarding yes
      X11Forwarding no
      AllowAgentForwarding no
      AllowStreamLocalForwarding no
      AuthenticationMethods publickey
    '';
  };

  # Open ports in the firewall.
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [];
    allowedUDPPorts = [];
  };
}
