{ ... }:
{
  imports = [ ../wash-common.nix ];

  # Desktop-specific: add hyprland config
  home-manager.users.wash.imports = [
    ../../hm
    ../../hm/desktop-x.nix
  ];
}
