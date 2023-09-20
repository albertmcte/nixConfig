{ inputs, config, pkgs, ... }:
#let
#  unstable = import inputs.nixpkgs-unstable {
#    system = pkgs.system;
    # Uncomment this if you need an unfree package from unstable.
    #config.allowUnfree = true;
#  };
#in
{
  imports = [
    inputs.home-manager.nixosModule
  ];
#  config = {
#    home-manager.SpecialArgs = { inherit unstable; };
#  };
}
