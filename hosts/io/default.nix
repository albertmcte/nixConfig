{ pkgs, inputs, ...}:
let
  unstable = import inputs.nixpkgs-unstable {
    system = pkgs.stdenv.hostPlatform.system;
    config.allowUnfree = true;
  };
in
{
  imports = [
    ../../modules/common/darwin-common.nix
    ../../users/darwin-wash
    inputs.agenix.darwinModules.default
    inputs.home-manager.darwinModules.home-manager
  ];
  config = {
    ids.gids.nixbld = 30000;
    nixpkgs.hostPlatform = "aarch64-darwin";
    environment.shells = [ pkgs.fish ];
    environment.systemPackages = with pkgs; [
      python3
      inputs.agenix.packages.${stdenv.hostPlatform.system}.default
      unstable.eza
      unstable.pyenv
      iina
    ];
    homebrew = {
      enable = true;
      onActivation.autoUpdate = true;
      onActivation.upgrade = true;
      brews = [
#        "cloudflared"
      ];
      casks = [
        "font-hack-nerd-font"
        "font-fira-code-nerd-font"
        "sf-symbols"
        "karabiner-elements"
        "hiddenbar"
        "bluebubbles"
        "kodi"
        "calibre"
        "android-platform-tools"
        "hammerspoon"
#        "font-sketchybar-app-font"
      ];
    };
    services.yabai = {
      enable = true;
      package = unstable.pkgs.yabai;
      enableScriptingAddition = true;
      config = {
        focus_follows_mouse          = "autofocus";
        mouse_follows_focus          = "off";
        window_placement             = "second_child";
        window_opacity               = "on";
        window_opacity_duration      = "0.0";
        active_window_opacity        = "1.0";
        normal_window_opacity        = "0.8"; #trouble transitioning
        window_border                = "off";
        window_topmost               = "on";
        window_shadow                = "on";
        split_ratio                  = "0.50";
        auto_balance                 = "on";
        mouse_modifier               = "fn";
        mouse_action1                = "move";
        mouse_action2                = "resize";
        mouse_drop_action            = "swap";
        layout                       = "bsp";
        top_padding                  = 0;
        bottom_padding               = 5;
        left_padding                 = 5;
        right_padding                = 5;
        window_gap                   = 5;
        external_bar                 = "all:40:0";
      };

      extraConfig = ''
          # rules
          yabai -m rule --add app=iTerm space=1
          yabai -m rule --add app=kitty space=1

          yabai -m rule --add app=Chrome space=2
          yabai -m rule --add app=Firefox space=2
          yabai -m rule --add app=Edge space=2

          yabai -m rule --add app=Mailspring space=4 opacity=0.95
          yabai -m rule --add app=Email space=4 opacity=0.95
          yabai -m rule --add app=Spark space=4 opacity=0.95
          yabai -m rule --add app=Shortwave space=4 opacity=0.95
          yabai -m rule --add app=Mimestream space=4 opacity=0.98

          yabai -m rule --add app=Finder opacity=0.85
          yabai -m rule --add app=Fantastical manage=off
          yabai -m rule --add app="System Preferences" manage=off
          # Any other arbitrary config here
        '';
    };
    services.skhd = {
      enable = true;
      package = pkgs.skhd;
      skhdConfig = ''
        lcmd - return : open -na /Users/wash/Applications/Home\ Manager\ Apps/kitty.app
        lcmd - g : open /Users/wash
        rcmd - z : yabai --restart-service
        rcmd - x : skhd --restart-service
        #lcmd - 1 : yabai -m space --focus 1
        #lcmd - 2 : yabai -m space --focus 2
        #lcmd - 3 : yabai -m space --focus 3
        #lcmd - 4 : yabai -m space --focus 4
        lshift + lcmd - 1 : yabai -m window --space 1
        lshift + lcmd - 2 : yabai -m window --space 2
        lshift + lcmd - 3 : yabai -m window --space 3
        lshift + lcmd - 4 : yabai -m window --space 4
        hyper - r : yabai -m space --rotate 270
        hyper - y : yabai -m space --mirror y-axis
        hyper - x : yabai -m space --mirror x-axis
        lcmd - b : yabai -m space --balance
        hyper - f : yabai -m window --toggle native-fullscreen
        hyper - b : yabai -m rule --add app=iTerm space=1 && \
                    yabai -m rule --add app=kitty space=1 && \
                    yabai -m rule --add app=Chrome space=2 && \
                    yabai -m rule --add app=Firefox space=2 && \
                    yabai -m rule --add app=Edge space=2 && \
                    yabai -m rule --add app=Shortwave space=4 && \
                    yabai -m rule --add app=Mailspring space=4 && \ 
        '';
      };
      services.sketchybar = {
        enable = true;
        package = pkgs.sketchybar;
      };
      system.stateVersion = 6;
    };
}
