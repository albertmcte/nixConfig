{ inputs, config, pkgs, ... }:
{
  imports = [
    common/cli.nix
    common/fish
    common/nvim
  ];
}

