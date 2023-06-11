{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./common/cli.nix
    ./common/fish
  ];
}

