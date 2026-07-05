{ inputs, ... }:
{
  flake-file.inputs.niri-flake.url = "github:sodiboo/niri-flake";

  flake-file.nixConfig = {
    extra-substituters = [ "https://niri.cachix.org" ];
    extra-trusted-public-keys = [
      "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
    ];
  };

  den.aspects.kr7va.provides.declnix.hjem = { ... }: {
    files.".config/niri/config.kdl".text = ''
      input {
        touchpad {
          tap
          natural-scroll
          scroll-method "two-finger"
        }
      }

      spawn-at-startup "noctalia"

      binds {
        Mod+Shift+Slash { show-hotkey-overlay; }
        Mod+T { spawn "alacritty"; }
        Mod+D { spawn "fuzzel"; }
        Mod+Shift+E { quit; }
        Ctrl+Alt+Delete { quit; }

        Mod+Space { spawn-sh "noctalia msg panel-toggle launcher"; }
        Mod+S { spawn-sh "noctalia msg panel-toggle control-center"; }
        Mod+Comma { spawn-sh "noctalia msg settings-toggle"; }

        XF86AudioRaiseVolume { spawn-sh "noctalia msg volume-up"; }
        XF86AudioLowerVolume { spawn-sh "noctalia msg volume-down"; }
        XF86AudioMute { spawn-sh "noctalia msg volume-mute"; }
        XF86MonBrightnessUp { spawn-sh "noctalia msg brightness-up"; }
        XF86MonBrightnessDown { spawn-sh "noctalia msg brightness-down"; }

        Mod+H { focus-column-left; }
        Mod+J { focus-window-down; }
        Mod+K { focus-window-up; }
        Mod+L { focus-column-right; }

        Mod+Ctrl+H { move-column-left; }
        Mod+Ctrl+J { move-window-down; }
        Mod+Ctrl+K { move-window-up; }
        Mod+Ctrl+L { move-column-right; }





        Mod+1 { focus-workspace 1; }
        Mod+2 { focus-workspace 2; }
        Mod+3 { focus-workspace 3; }
        Mod+4 { focus-workspace 4; }
        Mod+5 { focus-workspace 5; }
        Mod+6 { focus-workspace 6; }
        Mod+7 { focus-workspace 7; }
        Mod+8 { focus-workspace 8; }
        Mod+9 { focus-workspace 9; }

        Mod+Shift+1 { move-column-to-workspace 1; }
        Mod+Shift+2 { move-column-to-workspace 2; }
        Mod+Shift+3 { move-column-to-workspace 3; }
        Mod+Shift+4 { move-column-to-workspace 4; }
        Mod+Shift+5 { move-column-to-workspace 5; }
        Mod+Shift+6 { move-column-to-workspace 6; }
        Mod+Shift+7 { move-column-to-workspace 7; }
        Mod+Shift+8 { move-column-to-workspace 8; }
        Mod+Shift+9 { move-column-to-workspace 9; }



        Print { screenshot; }
        Ctrl+Print { screenshot-screen; }
        Alt+Print { screenshot-window; }
      }

      window-rule {
        geometry-corner-radius 20
        clip-to-geometry true
      }

      window-rule {
        match app-id="dev.noctalia.Noctalia.Settings"
        open-floating true
        default-column-width { fixed 1080; }
        default-window-height { fixed 920; }
      }

      debug {
        honor-xdg-activation-with-invalid-serial
      }
    '';
  };

  den.aspects.kr7va.provides.declnix.nixos = {
    imports = [
      inputs.niri-flake.nixosModules.niri
    ];

    nix.settings = {
      extra-substituters = [ "https://niri.cachix.org" ];
      extra-trusted-public-keys = [
        "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
      ];
    };

    programs.niri.enable = true;
  };
}
