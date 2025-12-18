{ inputs, pkgs, ... }:
{
  imports = [
    inputs.agenix.nixosModules.age
  ];
  environment.systemPackages = [ inputs.agenix.packages.${pkgs.stdenv.hostPlatform.system}.default ];
}
