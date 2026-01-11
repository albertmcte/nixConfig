{ osConfig, ... }:
let
  inherit (import ../../hosts/${osConfig.networking.hostName}/variables.nix)
    extraMonitorSettings
    ;
in
{
  wayland.windowManager.hyprland.extraConfig = ''
    monitor=DP-3,3840x2160@95.03,auto,1
    monitor=HDMI-A-1,highres,auto,1.6
    workspace=10,monitor:HDMI-A-1,default:true
    ${extraMonitorSettings}
  '';
}
