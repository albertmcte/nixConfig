{
  config,
  pkgs,
  ...
}:
{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  # Possibly just use 'nixos-install --no-root-passwd'
  users.users.root.hashedPassword = "!";
  
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "zfs" ];
  boot.zfs.forceImportRoot = false;

  networking.networkmanager.enable = true;
  
  environment.systemPackages = with pkgs; [
    git
    neovim
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
    allowedTCPPorts = [22];
    allowedUDPPorts = [];
  };
}
