{ config, pkgs, ... }:
{
  services.sxhkd = {
    enable = true;
    keybindings = {
      # Custom
      "super + Return" = "kitty";
      "super + p" = "rofi -show drun -theme $HOME/.cache/wal/colors-rofi-dark-trans.rasi -show-icons";
      "super + @space" = "sh $HOME/.config/rofi/powermenu.sh";
      #      "ctrl + super + alt + u" = "kitty sudo nixos-rebuild switch";
      "Print" = "flameshot gui";
      "XF86AudioRaiseVolume" = "pamixer -i 1";
      "XF86AudioLowerVolume" = "pamixer -d 1";
      "XF86AudioMute" = "pamixer -t";
      "XF86AudioPlay" = "playerctl play-pause";
      "XF86AudioNext" = "playerctl next";
      "XF86AudioPrev" = "playerctl previous";
      # Bspwm
      "super + alt + r" = "bspc wm -r";
      "super + Escape" = "pkill -USR1 -x sxhkd";
      "super + {_,shift + }Escape" = "bspc node -{c,k}";
      # Apps
      "super + g" = "nemo --no-desktop";
      "super + m" = "mailspring";
      "super + 0" = "~/.config/ricescripts/theme-switcher";
      "super + o" = "${config.home.homeDirectory}/.local/share/tresorit/tresorit";
      # State/flags
      "super + {t,shift + t,f,m}" = "bspc node -t {tiled,pseudo_tiled,floating,fullscreen}";
      "super + {_,shift + }{1-9,0}" = "bspc {desktop -f,node -d} '^{1-9,10}'";
      # Move/resize
      "super + alt + {h,j,u,k}" = "bspc node -z {left -20 0,bottom 0 20,top 0 -20,right 20 0}";
      "super + alt + shift + {h,j,u,k}" = "bspc node -z {right -20 0,top 0 20,bottom 0 -20,left 20 0}";
      "super + {Left,Down,Up,Right}" = "bspc node -v {-20 0,0 20,0 -20,20 0}";
    };
  };
}
