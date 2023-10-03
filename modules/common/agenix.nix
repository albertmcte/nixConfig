{ inputs, config, pkgs, ... }: 
{
  imports = [
    inputs.agenix.nixosModules.age
  ];
  environment.systemPackages = [ inputs.agenix.packages.${pkgs.system}.default ];
}
