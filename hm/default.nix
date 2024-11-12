{ inputs, config, pkgs, ... }:
{
  imports = [
    common/cli.nix
    common/fish
    common/nvim
  ];
  home.file."./linuxbin" = {
    source = ./linuxbin;
    recursive = true;
  };
}

