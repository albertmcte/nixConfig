{ pkgs, ... }:

let
  libnpupnp = pkgs.callPackage ../../pkgs/libnpupnp.nix {};
  libupnpp = pkgs.callPackage ../../pkgs/libupnpp.nix { inherit libnpupnp; };
  upplay = pkgs.callPackage ../../pkgs/upplay.nix { inherit libupnpp; };
in
{
  environment.systemPackages = [ upplay ];
}
