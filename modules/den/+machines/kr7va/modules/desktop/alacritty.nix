{ ... }:
{
  den.aspects.kr7va = {
    provides.declnix.hjem = {
      rum.programs.alacritty = {
        enable = true;
        settings = {
          colors = {
            primary = {
              background = "#111318";
              foreground = "#d8dee9";
              dim_foreground = "#7b8496";
              bright_foreground = "#eceff4";
            };

            cursor = {
              text = "#111318";
              cursor = "#88c0d0";
            };

            selection = {
              text = "#eceff4";
              background = "#3b4252";
            };

            normal = {
              black = "#1f2335";
              red = "#bf616a";
              green = "#a3be8c";
              yellow = "#ebcb8b";
              blue = "#81a1c1";
              magenta = "#b48ead";
              cyan = "#88c0d0";
              white = "#d8dee9";
            };

            bright = {
              black = "#4c566a";
              red = "#d08770";
              green = "#a3be8c";
              yellow = "#ebcb8b";
              blue = "#8fbcbb";
              magenta = "#b48ead";
              cyan = "#88c0d0";
              white = "#eceff4";
            };
          };

          cursor = {
            style = {
              shape = "Block";
              blinking = "On";
            };
            blink_interval = 650;
          };

          font = {
            size = 11;
          };

          mouse = {
            hide_when_typing = false;
          };

          window = {
            decorations = "Full";
            opacity = 1.0;
            padding = {
              x = 16;
              y = 14;
            };
          };
        };
      };
    };
  };
}
