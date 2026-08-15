{ inputs
, ...
}:
{
  den.aspects.kr7va = {
    provides.declnix = {
      hjem =
        { pkgs, ... }:
        let
          system = pkgs.stdenv.hostPlatform.system;
          agsInput = inputs.ags;
          agsPackage = agsInput.packages.${system}.default;
          astalPackages = with agsInput.packages.${system}; [
            io
            astal4
            battery
          ];

          agsPanel = pkgs.stdenv.mkDerivation {
            name = "declnix-ags-panel";
            src = ./ags;

            nativeBuildInputs = with pkgs; [
              agsPackage
              gobject-introspection
              wrapGAppsHook3
            ];

            buildInputs = astalPackages ++ [ pkgs.gjs ];

            installPhase = ''
              runHook preInstall

              mkdir -p $out/bin $out/share/declnix-ags-panel
              cp -r . $out/share/declnix-ags-panel
              ags bundle app.tsx $out/bin/declnix-ags-panel -d "SRC='$out/share/declnix-ags-panel'"

              runHook postInstall
            '';
          };
        in
        {
          files = {
            ".config/labwc/autostart".source = pkgs.writeShellScript "labwc-autostart" ''
              ${agsPanel}/bin/declnix-ags-panel &
            '';
            ".config/labwc/rc.xml".source = ./rc.xml;
          };

          packages = [
            agsPanel
          ];
        };

      nixos = { pkgs, ... }: {
        programs.labwc.enable = true;

        services.greetd = {
          enable = true;
          settings.default_session = {
            command = "${pkgs.labwc}/bin/labwc";
            user = "declnix";
          };
        };

        systemd.services.labwc-reload = {
          description = "Reload labwc after Hjem file activation";
          wantedBy = [ "hjem.target" ];
          after = [ "hjem-reload@declnix.service" ];
          restartTriggers = [
            ./ags
            ./rc.xml
          ];

          serviceConfig = {
            Type = "oneshot";
            User = "declnix";
          };

          script = ''
            ${pkgs.procps}/bin/pkill -HUP -x labwc || true
            ${pkgs.procps}/bin/pkill -x declnix-ags-panel || true
          '';
        };
      };
    };
  };

  flake-file.inputs.ags = {
    url = "github:Aylur/ags";
    inputs.nixpkgs.follows = "nixpkgs";
  };
}
