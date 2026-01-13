{ inputs, pkgs, lib, ... }:
let
  inherit (lib) mkIf;
  inherit (pkgs) stdenv;
  #  hasPackage = pname: lib.any (p: p ? pname && p.pname == pname) config.home.packages;
  #  hasRipgrep = hasPackage "ripgrep";
  #  hasExa = hasPackage "exa";
  #  hasNeovim = config.programs.neovim.enable;
  #  hasShellColor = config.programs.shellcolor.enable;
  #  hasKitty = config.programs.kitty.enable;
  #  shellcolor = "${pkgs.shellcolord}/bin/shellcolor";
  osIcon = (if stdenv.isDarwin then "\\uf179" else "\\uf313");
  brew = (
    if stdenv.isDarwin then "set -U fish_user_paths /opt/homebrew/bin $fish_user_paths" else " "
  );
in
{
  programs.fish = {
    enable = true;
    plugins = [
      {
        name = "tide";
        src = pkgs.fetchFromGitHub {
          owner = "IlanCosman";
          repo = "tide";
          rev = "c4e3831dc4392979478d3d7b66a68f0274996c85";
          sha256 = "1cnnm0cs5spq2ir7vsb62blgyddjmzspgm2kpmsknskg78a3a8kh";
        };
      }
      {
        name = "grc";
        src = pkgs.fishPlugins.grc;
      }
    ];
    functions = {
      fish_greeting = "";
      sudo = ''
        if test "$argv" = !!
          echo sudo $history[1]
          eval command sudo $history[1]
        else
          command sudo $argv
        end
      '';
    };

    loginShellInit = mkIf (!stdenv.isDarwin) ''
      # Auto-start Hyprland via uwsm on TTY1 (Linux only)
      if test (tty) = "/dev/tty1"
        if uwsm check may-start
          exec uwsm start ${inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland}/bin/start-hyprland
        end
      end
    '';

    interactiveShellInit =
      # kitty integration only currently working on linux
      #    ''
      #      set --global KITTY_INSTALLATION_DIR "${pkgs.kitty}/lib/kitty"
      #      set --global KITTY_SHELL_INTEGRATION enabled
      #      source "$KITTY_INSTALLATION_DIR/shell-integration/fish/vendor_conf.d/kitty-shell-integration.fish"
      #      set --prepend fish_complete_path "$KITTY_INSTALLATION_DIR/shell-integration/fish/vendor_completions.d"
      #    '' +
      ### Add nix binary paths to the PATH
      # Perhaps someday will be fixed in nix or nix-darwin itself
      ''
        if test (uname) = Darwin
          fish_add_path --prepend --global "$HOME/.nix-profile/bin" /nix/var/nix/profiles/default/bin /run/current-system/sw/bin
        end

        # Use terminal colors
      ''
      + ''
              set -U _tide_left_items               os\x1epwd\x1egit\x1echaracter
              set -U _tide_prompt_10737             \x1b\x28B\x1b\x5bm\x1b\x28B\x1b\x5bm\x1b\x28B\x1b\x5bm\x1b\x28B\x1b\x5bm\x1b\x28B\x1b\x5bm\x1b\x28B\x1b\x5bm\uf313\x1b\x5b38\x3b5\x3b246m\x20\x1b\x28B\x1b\x5bm\x1b\x28B\x1b\x5bm\x40PWD\x40\x1b\x5b38\x3b5\x3b246m\x20\x1b\x28B\x1b\x5bm\x1b\x28B\x1b\x5bm\x1b\x5b38\x3b5\x3b76m\uf1d3\x20\x1b\x5b37m\x1b\x5b38\x3b5\x3b76mmaster\x1b\x5b38\x3b5\x3b196m\x1b\x5b38\x3b5\x3b76m\x1b\x5b38\x3b5\x3b76m\x1b\x5b38\x3b5\x3b196m\x1b\x5b38\x3b5\x3b178m\x20\x2b18\x1b\x5b38\x3b5\x3b178m\x20\x211\x1b\x5b38\x3b5\x3b39m\x1b\x5b38\x3b5\x3b76m\x20\u276f\x1b\x28B\x1b\x5bm\x1b\x28B\x1b\x5bm\x1b\x28B\x1b\x5bm\x1e\x1b\x28B\x1b\x5bm\x1b\x28B\x1b\x5bm\x1b\x28B\x1b\x5bm\x20\x1b\x28B\x1b\x5bm\x1b\x28B\x1b\x5bm\x1b\x5b38\x3b5\x3b101m\uf252\x2031s\x1b\x5b38\x3b5\x3b246m\x20\x1b\x28B\x1b\x5bm\x1b\x28B\x1b\x5bm\x1b\x5b38\x3b5\x3b180mwash\x40anubis\x1b\x5b38\x3b5\x3b246m\x20\x1b\x28B\x1b\x5bm\x1b\x28B\x1b\x5bm\x1b\x5b38\x3b5\x3b66m21\x3a14\x3a15\x1b\x28B\x1b\x5bm\x1b\x28B\x1b\x5bm\x1b\x28B\x1b\x5bm
              set -U _tide_prompt_12861             \x1b\x28B\x1b\x5bm\x1b\x28B\x1b\x5bm\x1e\x1b\x28B\x1b\x5bm\x1b\x28B\x1b\x5bm
              set -U _tide_right_items              status\x1ecmd_duration\x1econtext\x1ejobs\x1enix_shell\x1etime
              set -U fish_color_autosuggestion      brblack
              set -U fish_color_cancel              \x2dr
              set -U fish_color_command             brgreen
              set -U fish_color_comment             brmagenta
              set -U fish_color_cwd                 green
              set -U fish_color_cwd_root            red
              set -U fish_color_end                 brmagenta
              set -U fish_color_error               brred
              set -U fish_color_escape              brcyan
              set -U fish_color_history_current     \x2d\x2dbold
              set -U fish_color_host                normal
              set -U fish_color_host_remote         yellow
              set -U fish_color_match               \x2d\x2dbackground\x3dbrblue
              set -U fish_color_normal              normal
              set -U fish_color_operator            cyan
              set -U fish_color_param               brblue
              set -U fish_color_quote               yellow
              set -U fish_color_redirection         bryellow
              set -U fish_color_search_match        bryellow\x1e\x2d\x2dbackground\x3dbrblack
              set -U fish_color_selection           white\x1e\x2d\x2dbold\x1e\x2d\x2dbackground\x3dbrblack
              set -U fish_color_status              red
              set -U fish_color_user                brgreen
              set -U fish_color_valid_path          \x2d\x2dunderline
              set -U fish_key_bindings              fish_default_key_bindings
              set -U fish_pager_color_completion    normal
              set -U fish_pager_color_description   yellow
              set -U fish_pager_color_prefix        white\x1e\x2d\x2dbold\x1e\x2d\x2dunderline
              set -U fish_pager_color_progress      brwhite\x1e\x2d\x2dbackground\x3dcyan
              set -U fish_pager_color_selected_background      \x2dr
              set -U tide_aws_bg_color              normal
              set -U tide_aws_color                 FF9900
              set -U tide_aws_icon                  \uf270
              set -U tide_character_color           5FD700
              set -U tide_character_color_failure   FF0000
              set -U tide_character_icon            \u276f
              set -U tide_character_vi_icon_default            \u276e
              set -U tide_character_vi_icon_replace            \u25b6
              set -U tide_character_vi_icon_visual             V
              set -U tide_chruby_bg_color           normal
              set -U tide_chruby_color              B31209
              set -U tide_chruby_icon               \ue23e
              set -U tide_cmd_duration_bg_color     normal
              set -U tide_cmd_duration_color        87875F
              set -U tide_cmd_duration_decimals     0
              set -U tide_cmd_duration_icon         \uf252
              set -U tide_cmd_duration_threshold    3000
              set -U tide_context_always_display    false
              set -U tide_context_bg_color          normal
              set -U tide_context_color_default     D7AF87
              set -U tide_context_color_root        D7AF00
              set -U tide_context_color_ssh         D7AF87
              set -U tide_context_hostname_parts    1
              set -U tide_crystal_bg_color          normal
              set -U tide_crystal_color             FFFFFF
              set -U tide_crystal_icon              \u2b22
              set -U tide_docker_bg_color           normal
              set -U tide_docker_color              2496ED
              set -U tide_docker_default_contexts                default\x1ecolima
              set -U tide_docker_icon               \uf308
              set -U tide_git_bg_color              normal
              set -U tide_git_bg_color_unstable     normal
              set -U tide_git_bg_color_urgent       normal
              set -U tide_git_color_branch          5FD700
              set -U tide_git_color_conflicted      FF0000
              set -U tide_git_color_dirty           D7AF00
              set -U tide_git_color_operation       FF0000
              set -U tide_git_color_staged          D7AF00
              set -U tide_git_color_stash           5FD700
              set -U tide_git_color_untracked       00AFFF
              set -U tide_git_color_upstream        5FD700
              set -U tide_git_icon                  \uf1d3
              set -U tide_git_truncation_length     24
              set -U tide_go_bg_color               normal
              set -U tide_go_color                  00ACD7
              set -U tide_go_icon                   \ue627
              set -U tide_java_bg_color             normal
              set -U tide_java_color                ED8B00
              set -U tide_java_icon                 \ue256
              set -U tide_jobs_bg_color             normal
              set -U tide_jobs_color                5FAF00
              set -U tide_jobs_icon                 \uf013
              # set -U tide_kubectl_bg_color          normal
              # set -U tide_kubectl_color             326CE5
              # set -U tide_kubectl_icon              \u2388
              set -U tide_left_prompt_frame_enabled                false
              set -U tide_left_prompt_items         os\x1epwd\x1egit\x1echaracter
              set -U tide_left_prompt_prefix                
              set -U tide_left_prompt_separator_diff_color         \x20
              set -U tide_left_prompt_separator_same_color         \x20
              set -U tide_left_prompt_suffix                
              set -U tide_nix_shell_bg_color        normal
              set -U tide_nix_shell_color           7EBAE4
              set -U tide_nix_shell_icon            \uf313
              set -U tide_node_bg_color             normal
              set -U tide_node_color                44883E
              set -U tide_node_icon                 \u2b22
              set -U tide_os_bg_color               normal
              set -U tide_os_color                  normal
              set -U tide_os_icon                   ${osIcon}
              set -U tide_php_bg_color              normal
              set -U tide_php_color                 617CBE
              set -U tide_php_icon                  \ue608
              set -U tide_private_mode_bg_color     normal
              set -U tide_private_mode_color        FFFFFF
              set -U tide_private_mode_icon         \ufaf8
              set -U tide_prompt_add_newline_before             false
              set -U tide_prompt_color_frame_and_connection     6C6C6C
              set -U tide_prompt_color_separator_same_color     949494
              set -U tide_prompt_icon_connection                \x20
              set -U tide_prompt_min_cols           34
              set -U tide_prompt_pad_items          false
              set -U tide_pwd_bg_color              normal
              set -U tide_pwd_color_anchors         00AFFF
              set -U tide_pwd_color_dirs            0087AF
              set -U tide_pwd_color_truncated_dirs              8787AF
              set -U tide_pwd_icon                  \uf07c
              set -U tide_pwd_icon_home             \uf015
              set -U tide_pwd_icon_unwritable       \uf023
              set -U tide_pwd_markers               \x2ebzr\x1e\x2ecitc\x1e\x2egit\x1e\x2ehg\x1e\x2enode\x2dversion\x1e\x2epython\x2dversion\x1e\x2eruby\x2dversion\x1e\x2eshorten_folder_marker\x1e\x2esvn\x1e\x2eterraform\x1eCargo\x2etoml\x1ecomposer\x2ejson\x1eCVS\x1ego\x2emod\x1epackage\x2ejson
              set -U tide_right_prompt_frame_enabled            false
              set -U tide_right_prompt_items        status\x1ecmd_duration\x1econtext\x1ejobs\x1enode\x1evirtual_env\x1erustc\x1ejava\x1ephp\x1echruby\x1ego\x1etoolbox\x1eterraform\x1eaws\x1enix_shell\x1ecrystal\x1etime
              set -U tide_right_prompt_prefix       \x20
              set -U tide_right_prompt_separator_diff_color                \x20
              set -U tide_right_prompt_separator_same_color                \x20
              set -U tide_right_prompt_suffix                
              set -U tide_rustc_bg_color            normal
              set -U tide_rustc_color               F74C00
              set -U tide_rustc_icon                \ue7a8
              set -U tide_shlvl_bg_color            normal
              set -U tide_shlvl_color               d78700
              set -U tide_shlvl_icon                \uf120
              set -U tide_shlvl_threshold           1
              set -U tide_status_bg_color           normal
              set -U tide_status_bg_color_failure   normal
              set -U tide_status_color              5FAF00
              set -U tide_status_color_failure      D70000
              set -U tide_status_icon               \u2714
              set -U tide_status_icon_failure       \u2718
              set -U tide_terraform_bg_color        normal
              set -U tide_terraform_color           844FBA
              set -U tide_terraform_icon            \x1d
              set -U tide_time_bg_color             normal
              set -U tide_time_color                5F8787
              set -U tide_time_format               \x25T
              set -U tide_toolbox_bg_color          normal
              set -U tide_toolbox_color             613583
              set -U tide_toolbox_icon              \u2b22
              set -U tide_vi_mode_bg_color_default              normal
              set -U tide_vi_mode_bg_color_insert               normal
              set -U tide_vi_mode_bg_color_replace              normal
              set -U tide_vi_mode_bg_color_visual               normal
              set -U tide_vi_mode_color_default                 949494
              set -U tide_vi_mode_color_insert                  87AFAF
              set -U tide_vi_mode_color_replace                 87AF87
              set -U tide_vi_mode_color_visual                  FF8700
              set -U tide_vi_mode_icon_default                  D
              set -U tide_vi_mode_icon_insert                   I
              set -U tide_vi_mode_icon_replace                  R
              set -U tide_vi_mode_icon_visual                   V
              set -U tide_virtual_env_bg_color                  normal
              set -U tide_virtual_env_color                     00AFAF
              set -U tide_virtual_env_icon          \ue73c
              atuin init fish | source
        #      ${brew}
      '';
  };
}
