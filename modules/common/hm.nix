{
  config,
  pkgs,
  home-manager,
  ...
}: {
  imports = [
    home-manager.nixosModule
  ];
}
