{ inputs, config, pkgs, lib, ... }:
let
  unstable = import inputs.nixpkgs-unstable {
    system = pkgs.system;
    # Uncomment this if you need an unfree package from unstable.
    config.allowUnfree = true;
  };
in
#let 
#  unstable = inputs.nixpkgs-unstable { config = { allowUnfree = true; }; };
#in
#let unstable = import inputs.nixpkgs-unstable;
#in
{
  config = {
    home.packages = [
      unstable.eza
    ];
  };
}
