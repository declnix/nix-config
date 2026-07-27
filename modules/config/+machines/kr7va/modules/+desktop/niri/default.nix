{ inputs, ... }:
{
  den.aspects.kr7va = {
    provides.declnix = {
      hjem =
        { pkgs, ... }:
        let
          system = pkgs.stdenv.hostPlatform.system;
          ags = inputs.ags.packages.${system}.agsFull;
          wallpaper = ../../../assets/wallpaper.png;
          agsConfig = pkgs.stdenvNoCC.mkDerivation {
            pname = "kr7va-ags-shell";
            version = "0.1.0";
            src = ./ags;
            installPhase = ''
              mkdir -p $out
              cp -R . $out/
            '';
          };
          kr7vaShell = pkgs.writeShellApplication {
            name = "kr7va-shell";
            runtimeInputs = with pkgs; [
              ags
              bash
              bluez
              brightnessctl
              coreutils
              fuzzel
              libnotify
              playerctl
              niri
              procps
              awww
              util-linux
              wireplumber
            ];
            text = ''
              cmd="''${1:-run}"
              shift || true

              case "$cmd" in
                run)
                  exec ags run ${agsConfig}/app.tsx
                  ;;
                toggle)
                  exec ags request -i kr7va-shell toggle "''${1:?window name required}"
                  ;;
                request)
                  exec ags request -i kr7va-shell "$@"
                  ;;
                wallpaper)
                  if ! pgrep -x awww-daemon >/dev/null; then
                    awww-daemon >/tmp/kr7va-awww.log 2>&1 &
                    sleep 0.25
                  fi

                  exec awww img ${wallpaper} \
                    --transition-type fade \
                    --transition-duration 1.2 \
                    --transition-fps 60 \
                    --resize crop
                  ;;
                overview-toggle)
                  niri msg action toggle-overview
                  exec ags request -i kr7va-shell panel-toggle
                  ;;
                *)
                  exec ags request -i kr7va-shell "$cmd" "$@"
                  ;;
              esac
            '';
          };
          kr7vaLock = pkgs.writeShellApplication {
            name = "kr7va-lock";
            runtimeInputs = [ pkgs.swaylock-effects ];
            text = ''
              exec swaylock \
                --image ${wallpaper} \
                --scaling fill \
                --effect-blur 8x4 \
                --effect-vignette 0.35:0.45 \
                --indicator \
                --clock \
                --timestr "%H:%M" \
                --datestr "%A, %d %B" \
                --font "FiraCode Nerd Font" \
                --font-size 30 \
                --indicator-radius 118 \
                --indicator-thickness 8 \
                --inside-color 1e1e2edd \
                --inside-clear-color f9e2afdd \
                --inside-caps-lock-color fab387dd \
                --inside-ver-color 89b4fadd \
                --inside-wrong-color f38ba8dd \
                --ring-color 89b4faff \
                --ring-clear-color f9e2afff \
                --ring-caps-lock-color fab387ff \
                --ring-ver-color 94e2d5ff \
                --ring-wrong-color f38ba8ff \
                --key-hl-color f5c2e7ff \
                --bs-hl-color f38ba8ff \
                --text-color cdd6f4ff \
                --text-clear-color 11111bff \
                --text-caps-lock-color 11111bff \
                --text-ver-color 11111bff \
                --text-wrong-color 11111bff \
                --line-color 00000000 \
                --separator-color 00000000 \
                --layout-bg-color 1e1e2edd \
                --layout-border-color 45475aff \
                --layout-text-color cdd6f4ff
            '';
          };
        in
        {
          packages = with pkgs; [
            ags
            brightnessctl
            cliphist
            fuzzel
            kr7vaLock
            kr7vaShell
            libnotify
            playerctl
            awww
            swaylock-effects
            wireplumber
            wl-clipboard
          ];

          rum.programs.fuzzel.enable = true;

          files = {
            ".config/fuzzel/fuzzel.ini".text = ''
              [main]
              font=FiraCode Nerd Font:size=12
              terminal=alacritty
              layer=overlay
              prompt=Launch 
              icons-enabled=yes
              width=52
              lines=14
              horizontal-pad=18
              vertical-pad=14
              inner-pad=8

              [border]
              width=2
              radius=14

              [colors]
              background=1e1e2ef2
              text=cdd6f4ff
              prompt=f9e2afff
              placeholder=a6adc8ff
              input=cdd6f4ff
              match=f5c2e7ff
              selection=313244ff
              selection-text=cdd6f4ff
              selection-match=f5c2e7ff
              border=89b4faff
            '';
            ".config/niri/config.kdl".text = builtins.readFile ./full-config.kdl;
          };
        };

      nixos =
        { pkgs, ... }:
        let
          wallpaper = ../../../assets/wallpaper.png;
        in
        {
          imports = [
            inputs.niri-flake.nixosModules.niri
          ];

          nix.settings = {
            extra-substituters = [ "https://niri.cachix.org" ];
            extra-trusted-public-keys = [
              "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
            ];
          };

          environment.systemPackages = with pkgs; [
            swaylock-effects
          ];

          programs.niri.enable = true;

          programs.regreet = {
            enable = true;
            cageArgs = [
              "-s"
              "-d"
              "-m"
              "last"
            ];
            font = {
              name = "FiraCode Nerd Font";
              size = 12;
            };
            extraCss = ''
              headerbar,
              .titlebar {
                min-height: 0;
                border: 0;
                margin: 0;
                padding: 0;
                background: transparent;
                opacity: 0;
              }

              headerbar *,
              .titlebar * {
                min-height: 0;
                margin: 0;
                padding: 0;
                opacity: 0;
              }

              window {
                color: #cdd6f4;
                font-family: "FiraCode Nerd Font";
              }

              box {
                border-radius: 18px;
              }

              entry,
              button,
              combobox,
              popover {
                border-radius: 14px;
              }

              entry {
                padding: 10px 12px;
                color: #cdd6f4;
                background: rgba(24, 24, 37, 0.94);
                border: 1px solid #89b4fa;
              }

              button {
                padding: 9px 12px;
              }
            '';
            settings = {
              background = {
                path = "${wallpaper}";
                fit = "Cover";
              };
              GTK.application_prefer_dark_theme = true;
              commands = {
                reboot = [
                  "systemctl"
                  "reboot"
                ];
                poweroff = [
                  "systemctl"
                  "poweroff"
                ];
              };
            };
          };

          security.pam.services.swaylock = { };
        };
    };
  };

  flake-file.nixConfig = {
    extra-substituters = [ "https://niri.cachix.org" ];
    extra-trusted-public-keys = [
      "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
    ];
  };

  flake-file.inputs.ags = {
    url = "github:aylur/ags";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flake-file.inputs.niri-flake.url = "github:sodiboo/niri-flake";
}
