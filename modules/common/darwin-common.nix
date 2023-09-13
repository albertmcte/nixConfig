{ config, pkgs, ... }: {
  programs.gnupg.agent.enable = true;
  programs.fish.enable = true;
#  programs.zsh.enable = true;
#  environment.pathsToLink = [ "/share/zsh" ];
  services.nix-daemon.enable = true;
  nix.package = pkgs.nixVersions.stable;
  nix.settings.cores = 0; # use all cores
  nix.settings.max-jobs = 10; # use all cores

  system.defaults = {
    NSGlobalDomain.AppleShowAllExtensions = true;
    NSGlobalDomain.InitialKeyRepeat = 25;
    NSGlobalDomain.KeyRepeat = 4;
    NSGlobalDomain.NSNavPanelExpandedStateForSaveMode = true;
    NSGlobalDomain.PMPrintingExpandedStateForPrint = true;
    NSGlobalDomain."com.apple.mouse.tapBehavior" = 1;
    NSGlobalDomain."com.apple.trackpad.trackpadCornerClickBehavior" = 1;
    dock.autohide = true;
    dock.mru-spaces = false;
    dock.show-recents = false;
    dock.static-only = true;
    finder.AppleShowAllExtensions = true;
    finder.FXEnableExtensionChangeWarning = false;
    loginwindow.GuestEnabled = false;
  };
}
