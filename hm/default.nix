{ pkgs, lib, ... }:
{
  imports = [
    common/cli.nix
    common/mcp.nix
    common/fish
    common/nvim
  ];
  home.file."./bin" = lib.mkIf pkgs.stdenv.isLinux {
    source = ./linuxbin;
    recursive = true;
  };
}
