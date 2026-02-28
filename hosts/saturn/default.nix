{ pkgs, inputs, myLib, ... }:
let
  unstable = myLib.mkUnstable pkgs;
in
{
  imports = [
    ../../modules/common/darwin-common.nix
    ../../modules/darwin/workstation.nix
    ../../users/darwin-wash
    inputs.agenix.darwinModules.default
    inputs.home-manager.darwinModules.home-manager
  ];

  nixpkgs.hostPlatform = "x86_64-darwin";
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
    inputs.llm-agents.overlays.default
  ];
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  environment.systemPackages = with pkgs; [
    python3
    inputs.agenix.packages.${pkgs.stdenv.hostPlatform.system}.default
    unstable.eza
    unstable.pyenv
  ];

  homebrew.brews = [
    "cloudflare/cloudflare/cloudflared"
  ];

  # saturn-specific yabai rules
  services.yabai.extraConfig = ''
    yabai -m rule --add app=Spark space=4 opacity=0.98
  '';

  services.skhd.skhdConfig = ''
    lshift + cmd - 1 : yabai -m window --space 1
    lshift + cmd - 2 : yabai -m window --space 2
    lshift + lcmd - 3 : yabai -m window --space 3
    lshift + lcmd - 4 : yabai -m window --space 4
    hyper - b : yabai -m rule --add app=iTerm space=1 && \
                yabai -m rule --add app=Chrome space=2 && \
                yabai -m rule --add app=Firefox space=2 && \
                yabai -m rule --add app=Mailspring space=4
  '';

  system.stateVersion = 6;
}
