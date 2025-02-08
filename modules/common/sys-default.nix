{ inputs, pkgs, ... }:
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
  
  # NOTE
  # ZFS LATEST COMPATIBLE no longer supported, standard nixos kernel **should** be fine
  # PINNED 6.12 until 6.12 LTS is in Nixos (should be on 25.05)
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_6_12;

  # boot.kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
  environment.systemPackages = with pkgs; [
    git
    unstable.eza
    rclone
  ];
  
  programs = {
    fish.enable = true;
    neovim = {
      enable = true;
      defaultEditor = true;
    };
  };

  environment.shells = with pkgs; [
    fish
    zsh
  ];

  services.openssh = {
    enable = true;
    ports = [ 31225 ];
    settings.PasswordAuthentication = false;
    settings.PermitRootLogin = "no";
    settings.KbdInteractiveAuthentication = false;
    openFirewall = false;
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
