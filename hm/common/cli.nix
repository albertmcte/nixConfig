{ config, pkgs, lib, ... }:
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
      sshubu="TERM=xterm-256color ssh -p 31225 washatka@neptune";
      sshneptune="TERM=xterm-256color ssh -p 31225 washatka@neptune";
      moshubu="mosh -ssh='ssh -p 31225' washatka@neptune";
      sshnuc="ssh wyatt@nuc";
      sshceres="ssh wash@ceres";
      moshceres="mosh wash@ceres";
      sshmini="ssh -p 36767 10.0.0.1";
#      sshminiclear="ssh -p 36767 ${config.age.secrets.miniIp.path}";
      sshandromeda="TERM=xterm-256color ssh -p 31225 wash@10.0.0.6";
      androsync="TERM=xterm-256color ssh -p 31225 -L 9999:localhost:8384 wash@10.0.0.6";
      ".." = "cd ../";
      "..." = "cd ../..";
      "...." = "cd ../../..";
    };
#    age.secrets.miniIp.file = ../../secrets/miniIp.age;
  
    programs = {
      bat = {
        enable = true;
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
        # Set default "git pull" behaviour so it doesn't try to default to
        # either "git fetch; git merge" (default) or "git fetch; git rebase".
        pull.ff = "only";
      };
    };
    # Htop configurations
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
    };
  };
}
