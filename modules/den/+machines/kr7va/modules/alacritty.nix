{ ... }:
{
  den.aspects.kr7va = {
    provides.declnix.hjem = {
      rum.programs.alacritty = {
        enable = true;
        settings = {
          colors = {
            primary = {
              background = "#161616";
              foreground = "#f2f4f8";
              dim_foreground = "#dde1e6";
              bright_foreground = "#ffffff";
            };

            cursor = {
              text = "#161616";
              cursor = "#3ddbd9";
            };

            selection = {
              text = "#f2f4f8";
              background = "#393939";
            };

            normal = {
              black = "#262626";
              red = "#ee5396";
              green = "#42be65";
              yellow = "#ffe97b";
              blue = "#33b1ff";
              magenta = "#ff7eb6";
              cyan = "#3ddbd9";
              white = "#dde1e6";
            };

            bright = {
              black = "#525252";
              red = "#ee5396";
              green = "#42be65";
              yellow = "#ffe97b";
              blue = "#33b1ff";
              magenta = "#ff7eb6";
              cyan = "#3ddbd9";
              white = "#ffffff";
            };
          };

          window = {
            decorations = "Full";
            padding = {
              x = 14;
              y = 14;
            };
          };
        };
      };
    };
  };
}
