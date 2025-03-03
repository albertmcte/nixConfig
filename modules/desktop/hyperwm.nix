{...}: 
{
  programs = {
    hyprland = {
      enable = true;
      xwayland = {
        enable = true;
        hidpi = true;
      };
    };
    pipewire.enable = true;
    wireplumber.enable = true;
    waybar.enable = true;
    swaync.enable = true;
  };
}
