{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nodejs
    (writeShellApplication {
      name = "gemini";
      text = ''
        exec ${nodejs}/bin/npx @google/gemini-cli "$@"
      '';
    })
  ];
}
