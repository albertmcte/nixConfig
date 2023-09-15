{
  inputs,
  config,
  pkgs,
  unstable,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModule
  ];
  config = {
    home-manager.extraSpecialArgs = { inherit unstable; };
  };
}
