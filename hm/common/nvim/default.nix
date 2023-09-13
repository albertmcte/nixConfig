{ lib, pkgs, config, inputs, ... }:
{
  home.file.".config/nvim" = {
    source = ./config;
    recursive = true;
    };

#  xdg = lib.mkIf pkgs.stdenv.isDarwin {
#    configHome = "/Users/wash/.config";
#  };

  programs.neovim =
    {
      enable = true;
      extraConfig = ''
        set runtimepath^=~/.config/nvim
        lua dofile('${./config/init.lua}')
      '';
      vimAlias = true;
      viAlias = true;
      plugins =
        map (x: { plugin = x; }) (with pkgs.vimPlugins; [
          vim-tmux-navigator
          galaxyline-nvim
          nvim-web-devicons
          rainbow
          vista-vim
          polyglot
          vim-commentary
          vim-nix
      	  gruvbox
          incsearch-vim
          vim-highlightedyank
          vim-fugitive
          fzf-vim
          lualine-nvim
          fzfWrapper
          vim-devicons
          toggleterm-nvim
          copilot-lua
        ]);
    };
}
