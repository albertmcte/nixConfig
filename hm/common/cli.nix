{ config, pkgs, ... }:
{
  config = {
    home.file.".config/kitty".source = ./kitty;
    home.packages =  with pkgs; [
      kitty
      bat
      htop
      curl
      fd
      file
      fzf
      git
      neofetch
      ripgrep
      unzip
      pv
      killall
      aria2
      meslo-lgs-nf
      nodejs_20     #required for copilot
      sops
      nil
      lua-language-server
      python312Packages.python-lsp-server
      bash-language-server
      yaml-language-server
    ];

    home.shellAliases = {
      v = "nvim";
      vim = "nvim";
      gpl = "git pull";
      gp = "git push";
      lg = "lazygit";
      gc = "git commit -v";
      kb = "git commit -m \"\$(curl -s http://whatthecommit.com/index.txt)\"";
      gs = "git status -v";
      gfc = "git fetch && git checkout";
      gl = "git log --graph";
      l = "eza -la --git";
      la = "eza -la --git";
      ls = "eza";
      ll = "eza -l --git";
      cat = "bat";
#      sshminiclear="ssh -p 36767 ${config.age.secrets.miniIp.path}";
      androsync="TERM=xterm-256color ssh -p 31225 -L 9999:localhost:8384 wash@10.0.0.6";
      ".." = "cd ../";
      "..." = "cd ../..";
      "...." = "cd ../../..";
    };
#    age.secrets.miniIp.file = ../../secrets/miniIp.age;
  
    programs = {
      bat = {
        enable = true;
        # config.theme = "Dracula";
      };
      fzf = {
        enable = true;
        enableZshIntegration = true;
        defaultOptions = [
          "--height 40%"
          "--layout=reverse"
          "--border"
          "--inline-info"
        ];
      };
      git = {
        enable = true;
        lfs.enable = true;
        extraConfig = {
          commit.gpgSign = false;
          user.name = "Nordyun";
          user.email = "njorthson@proton.me";
          pull.ff = "only";
        };
      };
      htop = {
        enable = true;
        settings = {
          hide_userland_threads = true;
          highlight_base_name = true;
          shadow_other_users = true;
          show_program_path = false;
          tree_view = false;
        };
      };
      zsh = {
        enable = true;
        enableCompletion = true;
        syntaxHighlighting.enable = true;
      };
      neovim = {
        enable = true;
        defaultEditor = true;
      };
      atuin = {
        enable = true;
        settings = {
          key_path = config.age.secrets.atuinKey.path;
          enter_accept = true;
#        key_path = config.sops.secrets.atuin_key.path;
#        sync_address = "https://majiy00-shell.fly.dev";
        };
      };
    };
    age.secrets.atuinKey.file = ../../secrets/atuinKey.age;
#   sops.secrets.atuin_key.sopsFile = ../../secrets/sopss.yaml;
#   sops.secrets.test_secret.sopsFile = ../../secrets/sopss.yaml;
  };
}
