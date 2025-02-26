{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    # Optional
    # Whether to enable hyprland-session.target on hyprland startup
    systemd.enable = true;
    settings = {
      "$mod" = "SUPER";
    bind =
      [
        "$mod, F, exec, firefox"
        "SUPER, ENTER, exec, kitty"
        ", Print, exec, grimblast copy area"
      ]
      ++ (
        # workspaces
        # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
        builtins.concatLists (builtins.genList (i:
            let ws = i + 1;
            in [
              "$mod, code:1${toString i}, workspace, ${toString ws}"
              "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
            ]
          )
          9)
      );
    };
    
  };

  # Optional, hint Electron apps to use Wayland:
  # home.sessionVariables.NIXOS_OZONE_WL = "1";
}
