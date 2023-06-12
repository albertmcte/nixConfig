{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./cli.nix
    ./fish
    ./nvim
  ];
}

