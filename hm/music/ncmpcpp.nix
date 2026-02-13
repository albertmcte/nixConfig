{ pkgs, ... }:
{
  programs.ncmpcpp = {
    enable = true;
    package = pkgs.ncmpcpp.override {
      visualizerSupport = true;
      clockSupport = true;
    };

    settings = {
      # Behavior
      autocenter_mode = "yes";
      follow_now_playing_lyrics = "yes";
      ignore_leading_the = "yes";
      ignore_diacritics = "yes";
      default_place_to_search_in = "database";

      # Display Modes
      playlist_editor_display_mode = "columns";
      search_engine_display_mode = "columns";
      browser_display_mode = "columns";
      playlist_display_mode = "columns";

      # General Colors (using 256-color palette to bypass terminal's 16-color theme)
      colors_enabled = "yes";
      main_window_color = "255";         # white
      header_window_color = "73";        # cyan
      volume_color = "114";              # green
      statusbar_color = "255";           # white
      progressbar_color = "73";          # cyan
      progressbar_elapsed_color = "255"; # white

      # Song List (using 256-color palette indices for format strings)
      song_columns_list_format = "(10)[75]{l} (30)[114]{t} (30)[176]{a} (30)[180]{b}";
      song_list_format = "{$73%a - $9}{$75%t$9}|{$75%f$9}$R{$176%b $9}{$114%l$9}";

      # Current Item
      current_item_prefix = "$(75)$r";
      current_item_suffix = "$/r$(end)";
      current_item_inactive_column_prefix = "$(73)$r";

      # Alternative Interface
      user_interface = "alternative";
      alternative_header_first_line_format = "$0$aqqu$/a {$(176)%a$(end) - }{$(114)%t$(end)}|{$(114)%f$(end)} $0$atqq$/a$(end)";
      alternative_header_second_line_format = "{{$(180)%b$(end)}{ [$(255)%y$(end)]}}|{$(180)%D$(end)}";

      # Classic Interface
      song_status_format = " $(176)%a $(73)⟫⟫ $(114)%t $(73)⟫⟫ $(180)%b ";

      # Visualizer
      visualizer_data_source = "/tmp/mpd.fifo";
      visualizer_output_name = "my_fifo";
      visualizer_type = "spectrum";
      visualizer_in_stereo = "yes";
      visualizer_look = "◆▋";
      visualizer_color = "114, 150, 73, 75, 176, 180";
      visualizer_spectrum_smooth_look = "yes";

      # Navigation
      cyclic_scrolling = "yes";
      header_text_scrolling = "yes";
      jump_to_now_playing_song_at_start = "yes";
      lines_scrolled = "2";

      # Other
      system_encoding = "utf-8";
      regular_expressions = "extended";

      # Selected tracks
      selected_item_prefix = "* ";
      discard_colors_if_item_is_selected = "yes";

      # Seeking
      incremental_seeking = "yes";
      seek_time = "1";

      # Visibility
      header_visibility = "yes";
      statusbar_visibility = "yes";
      titles_visibility = "yes";

      # Progress Bar
      progressbar_look = "=>-";

      # Now Playing
      now_playing_prefix = "> ";
      centered_cursor = "yes";

      # Misc
      display_bitrate = "yes";
      enable_window_title = "yes";
      empty_tag_marker = "";
    };

    bindings = [
      # Navigation (vim-style)
      { key = "j"; command = "scroll_down"; }
      { key = "k"; command = "scroll_up"; }
      { key = "h"; command = "previous_column"; }
      { key = "l"; command = "next_column"; }

      # Page navigation
      { key = "ctrl-u"; command = "page_up"; }
      { key = "ctrl-d"; command = "page_down"; }

      # Jump to beginning/end
      { key = "g"; command = "move_home"; }
      { key = "G"; command = "move_end"; }

      # Search navigation
      { key = "n"; command = "next_found_item"; }
      { key = "N"; command = "previous_found_item"; }
    ];
  };
}
