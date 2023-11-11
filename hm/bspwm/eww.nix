{ inputs, config, pkgs, ... }: {
    home.packages = with pkgs; [
        eww
        pamixer
        brightnessctl
        (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];
    # configuration
    home.file.".config/eww" = {
        source = ./eww;
        recursive = true;
    };

    # scripts
    home.file.".config/eww/scripts" = {
        source = ./scripts;
        executable = true;
        recursive = true;
    };
}
