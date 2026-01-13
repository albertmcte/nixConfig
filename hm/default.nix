{ ... }:
{
  imports = [
    common/cli.nix
    common/gemini.nix
    common/qt.nix
    common/fish
    common/nvim
    ./music
  ];
  home.file."./linuxbin" = {
    source = ./linuxbin;
    recursive = true;
  };
}
