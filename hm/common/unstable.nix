{ inputs, config, pkgs, lib, ... }:
let 
  unstable = import inputs.nixpkgs-unstable { config = { allowUnfree = true; }; };
in
{
  config = {
    home.packages = [
      unstable.eza
    ];
  };
}
