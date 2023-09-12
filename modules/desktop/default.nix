{
  config,
  pkgs,
  ...
}: {
  imports = [
#    ./wayland.nix
    ./bspwm.nix
  ];
}

