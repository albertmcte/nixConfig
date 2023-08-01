{ inputs, pkgs, config, ...}:
{
  services.xserver.enable = true;
  services.xserver.windowManager.bspwm.enable = true;
  services.xserver.displayManager = { 
    defaultSession = "none+bspwm";
    lightdm = { 
      enable = true; 
      greeter.enable = true; 
    }; 
  };
  sound.enable = true;
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
