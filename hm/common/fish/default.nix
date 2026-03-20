{ pkgs, ... }:
let
  inherit (pkgs) stdenv;
  osIcon = (if stdenv.isDarwin then "\\uf179" else "\\uf313");
in
{
  imports = [
    ./darwin.nix
    ./linux.nix
  ];
  programs.fish = {
    enable = true;
    plugins = [
      {
        name = "grc";
        src = pkgs.fishPlugins.grc;
      }
    ];
    functions = {
      fish_greeting = "";
      sudo = ''
        if test "$argv" = !!
          echo sudo $history[1]
          eval command sudo $history[1]
        else
          command sudo $argv
        end
      '';
    };
  };
}
