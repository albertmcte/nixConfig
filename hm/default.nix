{ ... }:
{
  imports = [
    common/cli.nix
    common/gemini.nix
    common/fish
    common/nvim
  ];
  home.file."./linuxbin" = {
    source = ./linuxbin;
    recursive = true;
  };
}
