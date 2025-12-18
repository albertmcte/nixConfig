{
  inputs,
  pkgs,
  config,
  ...
}:
{
  services.xserver.enable = true;
  services.xserver.windowManager.bspwm.enable = true;
  services.displayManager = {
    defaultSession = "none+bspwm";
    autoLogin = {
      enable = true;
      user = "wash";
    };
    #    lightdm = {
    #      enable = true;
    #      greeter.enable = true;
    #    };
  };
  hardware.pulseaudio.enable = false;
  nixpkgs.config.pulseaudio = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
}
