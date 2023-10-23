{ pkgs, vars, ... }: {
  home-manager.users.${vars.username} = {
    programs.alacritty = {
      enable = true;

      settings = {
        window = {
          title = "alacritty";

          padding = {
            x = 5;
            y = 5;
          };

          dimensions = {
            lines = 75;
            columns = 100;
          };

          opacity = 1;
        };

        font = {
          normal = {
            family = "monospace";
            style = "Regular";
          };
          size = 12.0;
        };

        colors = {
          primary = {
            background = "#282828";
            foreground = "#ebdbb2";
          };
          
          cursor = {
            text = "#282828";
            foreground = "#ebdbb2";
          };
          
          vi_mode_cursor = {
            text = "#282828";
            foreground = "#ebdbb2";
          };

          search = {
            matches = {
              foreground = "#ebdbb2";
              background = "#282828";
            };
            focused_match = {
              foreground = "#282828";
              background = "#b8bb26";
            };
            footer_bar = {
              foreground = "#ebdbb2";
              background = "#282828";
            };
          };

          hints = {
            start = {
              foreground = "#a89984";
              background = "#8ec07c";
            };
            end = {
              foreground = "#ebdbb2";
              background = "#282828";
            };
          };
          
          normal = {
            black = "#282828";
            # red = "#cc241d";
            # green = "#98971a";
            # yellow = "#d79921";
            # blue = "#458588";
            # magenta = "#b16286";
            # cyan = "#689d6a";
            # white = "#a89984";
            red = "#fb4934";
            green = "#b8bb26";
            yellow = "#fabd2f";
            blue = "#83a598";
            magenta = "#d3869b";
            cyan = "#8ec07c";
            white = "#ebdbb2";
          };
          
          bright = {
            black = "#928374";
            red = "#fb4934";
            green = "#b8bb26";
            yellow = "#fabd2f";
            blue = "#83a598";
            magenta = "#d3869b";
            cyan = "#8ec07c";
            white = "#ebdbb2";
          };
        };

        draw_bold_text_with_bright_colors = false;
      };
    };
  };
}
