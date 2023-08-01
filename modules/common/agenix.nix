{
  config,
  pkgs,
  agenix,
  ...
}: {
  imports = [
    agenix.nixosModules.age
  ];
  environment.systemPackages = [ agenix.packages.x86_64-linux.default ];
}
