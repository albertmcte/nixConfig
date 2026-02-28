{ pkgs, inputs, myLib, ... }:
let
  unstable = myLib.mkUnstable pkgs;
in
{
  imports = [
    ../../modules/common/darwin-common.nix
    ../../modules/darwin/workstation.nix
    ../../users/darwin-wash
    inputs.agenix.darwinModules.default
    inputs.home-manager.darwinModules.home-manager
  ];

  nix.enable = false; # for determinate nix install
  nix.settings.lazy-trees = true;
  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.android_sdk.accept_license = true;
  nixpkgs.overlays = [
    inputs.llm-agents.overlays.default
  ];
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  environment.systemPackages = with pkgs; [
    python3
    inputs.agenix.packages.${pkgs.stdenv.hostPlatform.system}.default
    eza
    pyenv
    iina
    nixfmt-rfc-style
    jdk17
  ];

  homebrew.brews = [
    #        "cloudflared"
    "ruby"
    "rustledger"
    "xcodegen"
  ];
  homebrew.casks = [
    # "kodi"
    # "calibre"
    # "android-platform-tools"
    # "hammerspoon"
  ];

  # io-specific yabai overrides
  services.yabai.config = {
    normal_window_opacity = "0.8";
    external_bar = "all:40:0";
  };

  services.yabai.extraConfig = ''
    # io-specific rules
    yabai -m rule --add app=kitty space=1
    yabai -m rule --add app=Edge space=2

    yabai -m rule --add app=Spark space=4 opacity=0.95
    yabai -m rule --add app=Shortwave space=4 opacity=0.95
    yabai -m rule --add app=Mimestream space=4 opacity=0.98

    yabai -m rule --add app="System Settings" manage=off
  '';

  services.skhd.skhdConfig = ''
    lshift + lcmd - 1 : yabai -m window --space 1
    lshift + lcmd - 2 : yabai -m window --space 2
    lshift + lcmd - 3 : yabai -m window --space 3
    lshift + lcmd - 4 : yabai -m window --space 4
    hyper - f : yabai -m window --toggle float
    hyper - b : yabai -m rule --add app=iTerm space=1 && \
                yabai -m rule --add app=kitty space=1 && \
                yabai -m rule --add app=Chrome space=2 && \
                yabai -m rule --add app=Firefox space=2 && \
                yabai -m rule --add app=Edge space=2 && \
                yabai -m rule --add app=Shortwave space=4 && \
                yabai -m rule --add app=Mailspring space=4
  '';

  services.sketchybar = {
    enable = true;
    package = pkgs.sketchybar;
  };

  system.stateVersion = 6;
}
