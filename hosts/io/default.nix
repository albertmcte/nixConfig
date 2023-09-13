{ pkgs, inputs, outputs, config, ... }:
{
  imports = [
    ../../modules/common/darwin-common.nix
    ../../users/darwin-wash
  ];
  environment.shells = [ pkgs.fish ];

  homebrew = {
    enable = true;
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
    brews = [
      "mas"
      "rsync"
      "rclone"
      "openssh"
    ];
    casks = [
      "font-hack-nerd-font"
      "font-fira-code-nerd-font"
      "sf-symbols"
      "karabiner-elements"
      "hiddenbar"
    ];
  };
