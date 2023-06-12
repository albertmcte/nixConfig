{ pkgs, config, inputs, ... }:
{
  home.file.".config/nvim" = {
    source = ./config;
    recursive = true;
    };
#  xdg.configHome = "/Users/wash/.config";
  programs.neovim =
#    let
#      conf = inputs.self.nixosConfigurations.enterprise.config.programs.neovim.configure;
#    in
    {
      enable = true;
      extraConfig = ''
        set runtimepath^=~/.config/nvim
        lua dofile('${./config/init.lua}')
      '';
      vimAlias = true;
      viAlias = true;
      plugins =
#        let
#          nnn-vim = pkgs.vimUtils.buildVimPlugin {
#            pname = "nnn-vim";
#            version = "1.0.0";
#            src = inputs.nnn-vim;
#         };
#        in
        map (x: { plugin = x; }) (with pkgs.vimPlugins; [
          vim-tmux-navigator
          galaxyline-nvim
          nvim-web-devicons
#          nnn-vim
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
        ]);
    };
}
