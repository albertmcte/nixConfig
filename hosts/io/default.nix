{ pkgs, inputs, outputs, config, ... }:
{
  imports = [
    ../../modules/common/darwin-common.nix
    ../../users/darwin-wash
  ];
  environment.shells = [ pkgs.fish ];
# these should probably be under home manager
  homebrew = {
    enable = true;
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
    brews = [
      "mas"
      "rsync"
      "rclone"
      "openssh"
    ];
    casks = [
      "font-hack-nerd-font"
      "font-fira-code-nerd-font"
      "sf-symbols"
      "karabiner-elements"
      "hiddenbar"
    ];
  };
  services.yabai = {
    enable = true;
    package = pkgs.yabai;
    enableScriptingAddition = true;
    config = {
      focus_follows_mouse          = "autoraise";
      mouse_follows_focus          = "off";
      window_placement             = "second_child";
      window_opacity               = "on";
      window_opacity_duration      = "0.0";
      active_window_opacity        = "1.0";
      normal_window_opacity        = "0.7";
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
    };

    extraConfig = ''
        # rules
        yabai -m rule --add app=iTerm space=1
        yabai -m rule --add app=Chrome space=2
        yabai -m rule --add app=Firefox space=2

        yabai -m rule --add app=Mailspring space=4 opacity=0.9
        yabai -m rule --add app=Edison space=4 opacity=0.90
        yabai -m rule --add app=Spark space=4 opacity=0.96

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
      lcmd - 1 : yabai -m space --focus 1
      lcmd - 2 : yabai -m space --focus 2
      lcmd - 3 : yabai -m space --focus 3
      lcmd - 4 : yabai -m space --focus 4
      shift + cmd - 1 : yabai -m window --space 1
      shift + cmd - 2 : yabai -m window --space 2
      lshift + lcmd - 3 : yabai -m window --space 3
      lshift + lcmd - 4 : yabai -m window --space 4
      hyper - r : yabai -m space --rotate 270
      hyper - y : yabai -m space --mirror y-axis
      hyper - x : yabai -m space --mirror x-axis
      lcmd - b : yabai -m space --balance
      hyper - f : yabai -m window --toggle native-fullscreen
      hyper - b : yabai -m rule --add app=iTerm space=1 && \
                  yabai -m rule --add app=Chrome space=2 && \
                  yabai -m rule --add app=Firefox space=2 && \
                  yabai -m rule --add app=Mailspring space=4 && \ 
      '';
    };
}
