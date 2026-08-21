{ ... }:
{
  den.aspects.terra = {
    provides.declnix = {
      hjem = {
        files.".config/labwc/rc.xml".source = ./rc.xml;
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
            ./rc.xml
          ];

          serviceConfig = {
            Type = "oneshot";
            User = "declnix";
          };

          script = ''
            ${pkgs.procps}/bin/pkill -HUP -x labwc || true
          '';
        };
      };
    };
  };
}
