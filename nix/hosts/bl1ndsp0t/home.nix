{ lib, ... }:
{
  programs = {
    niri = {
      config = ''
        binds {
          Mod+T hotkey-overlay-title="Open a Terminal: alacritty" { spawn "alacritty"; }
          Mod+D hotkey-overlay-title="Run an Application: fuzzel" { spawn "fuzzel"; }

          Mod+H     { focus-column-left; }
          Mod+J     { focus-window-down; }
          Mod+K     { focus-window-up; }
          Mod+L     { focus-column-right; }

          Mod+Shift+E { quit; }
          
          // Open/close the Overview: a zoomed-out view of workspaces and windows.
          // You can also move the mouse into the top-left hot corner,
          // or do a four-finger swipe up on a touchpad.
          Mod+O repeat=false { toggle-overview; }

          Mod+V       { toggle-window-floating; }
        }

        window-rule {
            match is-active=true

              focus-ring {
                active-color "#f38ba8"
                inactive-color "#7d0d2d"
            }

            border {
                inactive-color "#7d0d2d"
            }

            shadow {
                color "#7d0d2d70"
                spread 2
            }

            tab-indicator {
                active-color "#f38ba8"
                inactive-color "#7d0d2d"
            }
        }

        layout {
          struts {
            // leave place for ags panel
            top 20
          }

          focus-ring {
            width 2
            active-color "#00ff00BF" 
          }
           
          shadow {
            on
            softness 15
            spread 5
            offset x=0 y=1
            color "#0007"
          }
        }


        prefer-no-csd
        spawn-at-startup "ags" "run"
      '';
    };

    alacritty = {
      settings = {
        general.live_config_reload = true;
        window.padding = {
          x = 2;
          y = 2;
        };
        font.size = 10;
      };
    };

    ags = {
      configDir = ./home/ags;
    };

  };

  home.stateVersion = "24.05";
}
