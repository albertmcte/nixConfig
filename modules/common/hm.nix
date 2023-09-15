{
  inputs,
  config,
  pkgs,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModule
  ];
#  config = {
#    home-manager.extraSpecialArgs = { inherit unstable; };
#  };
}
