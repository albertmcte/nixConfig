{ config, pkgs, ... }: {
  xsession.windowManager.bspwm = {
    enable = true;
    extraConfigEarly = ''
      # Basic config
      bspc rule -a '*' desktop=^10 follow=off focus=off; easyeffects
      bspc monitor -d I II III IV V VI

      bspc config border_width          0
      bspc config window_gap            11

      bspc config split_ratio           0.50
      bspc config borderless_monocle    true
      bspc config gapless_monocle       true

      bspc config focus_follows_pointer true

      bspc rule -a Gimp desktop='^8' state=floating follow=on
      bspc rule -a Chromium desktop='^2'
      bspc rule -a Firefox desktop='^2'
      bspc rule -a Mailspring desktop='^4'
      bspc rule -a mplayer2 state=floating
      bspc rule -a Kupfer.py focus=on
      bspc rule -a Screenkey manage=off
      bspc rule -a Enpass state=floating
    '';
    extraConfig = ''
      killall polybar eww easyeffects &

      # Startup
      $HOME/.scripts/restore-theme &
      pamixer --set-limit 100 &
      xsetroot -cursor_name left_ptr &
      polybar lemon-left &
      polybar lemon-right &

      # Disabled until I actually set it up
      # eww daemon &
      # eww open lemon &
    '';
  };
}
