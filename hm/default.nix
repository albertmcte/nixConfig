{ pkgs, lib, ... }:
{
  imports = [
    common/cli.nix
    common/gemini.nix
    common/qt.nix
    common/fish
    common/nvim
    ./music
  ];
  home.file."./linuxbin" = lib.mkIf pkgs.stdenv.isLinux {
    source = ./linuxbin;
    recursive = true;
  };
}
