{
  config,
  pkgs,
  inputs,
  agenix,
  ...
}: 
{
  imports = [
    agenix.nixosModules.default
  ];
}
