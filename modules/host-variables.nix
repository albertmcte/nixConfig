{ lib, ... }:
{
  options.hostVars = {
    hyprStart = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "Start hyprland";
    };
    extraMonitorSettings = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "Extra Hyprland monitor configuration";
    };
    clock24h = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Use 24-hour clock format in waybar";
    };
    browser = lib.mkOption {
      type = lib.types.str;
      default = "firefox";
      description = "Default browser command";
    };
    terminal = lib.mkOption {
      type = lib.types.str;
      default = "kitty";
      description = "Default terminal emulator command";
    };
    keyboardLayout = lib.mkOption {
      type = lib.types.str;
      default = "us";
      description = "Keyboard layout for Hyprland";
    };
    consoleKeyMap = lib.mkOption {
      type = lib.types.str;
      default = "us";
      description = "Console keymap";
    };
  };
}
