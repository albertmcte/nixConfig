{
  config,
  pkgs,
  ...
}: {
  imports = [
#    ./kodi.nix
#    ./wayland.nix
    ./x.nix
  ];
}

