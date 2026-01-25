{ inputs, pkgs, ... }:
{
  # Enable dconf for GTK applications (needed for apps like waytrogen)

  hostVars.hyprStart = ''
    # Auto-start Hyprland via uwsm on TTY1
    if test (tty) = "/dev/tty1"
      if uwsm check may-start
        exec uwsm start ${inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland}/bin/start-hyprland
      end
    end
  '';

  programs = {
    dconf.enable = true;
    hyprland = {
      enable = true;
      withUWSM = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };
}
