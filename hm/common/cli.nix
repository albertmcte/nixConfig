{ inputs, config, lib, pkgs, ... }:
{
  home.file.".config/kitty".source = ./kitty;
#  home.file.".config/fish/fish_variables".source = ./fish/fish_variables;
  home.packages = with pkgs; [
    kitty
    bat
    htop
    exa
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
    l = "exa -la --git";
    la = "exa -la --git";
    ls = "exa";
    ll = "exa -l --git";
    cat = "bat";
    sshubu="TERM=xterm-256color ssh -p 31225 washatka@neptune";
    sshneptune="TERM=xterm-256color ssh -p 31225 washatka@neptune";
    moshubu="mosh -ssh='ssh -p 31225' washatka@neptune";
    sshnuc="ssh wyatt@nuc";
    sshceres="ssh wash@ceres";
    moshceres="mosh wash@ceres";
    sshmini="ssh -p 36767 10.0.0.1";
    sshminiclear="ssh -p 36767 207.254.46.173";
    sshandromeda="TERM=xterm-256color ssh -p 31225 wash@10.0.0.6";
    androsync="TERM=xterm-256color ssh -p 31225 -L 9999:localhost:8384 wash@10.0.0.6";
    ".." = "cd ../";
    "..." = "cd ../..";
    "...." = "cd ../../..";
  };

  programs = {
    bat = {
      enable = true;
#      config.theme = "gruvbox-dark";
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
      # Default configs
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
}
