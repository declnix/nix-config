{ ... }:
{
  den.aspects.terra = {
    provides.declnix = {
      hjem = { config, pkgs, ... }: {
        files.".config/labwc/rc.xml".source = ./rc.xml;

        systemd.services.labwc-reload = {
          description = "Reload labwc after Hjem file activation";
          wantedBy = [ "default.target" ];
          reloadTriggers = [
            config.files.".config/labwc/rc.xml".source
          ];

          serviceConfig = {
            Type = "oneshot";
            RemainAfterExit = true;
            ExecStart = "${pkgs.coreutils}/bin/true";
            ExecReload = "${pkgs.bash}/bin/bash -lc '${pkgs.procps}/bin/pkill -HUP -u \"$USER\" -x labwc || true'";
          };
        };
      };
    };
  };
}
