{
  inputs,
  config,
  pkgs,
  ...
}: {
  imports = [
    inputs.agenix.nixosModules.age
  ];
  environment.systemPackages = [ inputs.agenix.packages.x86_64-linux.default ];
}
