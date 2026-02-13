{ lib, config, pkgs, myLib, ... }:
let
  cfg = config.modules.android;
  primaryUser = config.hostVars.primaryUser;
  unstable = myLib.mkUnstable pkgs;
in
{
  options.modules.android = {
    enable = lib.mkEnableOption "Android development environment";
  };

  config = lib.mkIf cfg.enable {
    # ADB + udev rules + adbusers group
    programs.adb.enable = true;

    # User groups for USB debugging and KVM emulator acceleration
    users.users.${primaryUser}.extraGroups = [ "adbusers" "kvm" ];

    environment.systemPackages = with pkgs; [
      (unstable.android-studio.override { forceWayland = true; })
      jdk17
    ];

    # Point ANDROID_HOME to Studio's default SDK download location
    environment.variables = {
      ANDROID_HOME = "/home/${primaryUser}/Android/Sdk";
      ANDROID_SDK_ROOT = "/home/${primaryUser}/Android/Sdk";
      JAVA_HOME = "${pkgs.jdk17}/lib/openjdk";
      _JAVA_AWT_WM_NONREPARENTING = "1";
    };

    hardware.graphics.enable = lib.mkDefault true;
  };
}
