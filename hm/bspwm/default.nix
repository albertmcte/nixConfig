{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./bspwm.nix
    ./picom.nix
    ./sxhkd.nix
#    ./eww.nix
    ./polybar
  ];
}
