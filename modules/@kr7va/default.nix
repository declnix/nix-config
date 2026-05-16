{
  den,
  ...
}:
{
  den.aspects.kr7va = {
    nixos =
      { pkgs, ... }:
      {
        services.greetd = {
          enable = true;
          settings.default_session.command = "${pkgs.tuigreet}/bin/tuigreet --cmd niri-session";
        };

        networking.networkmanager.enable = true;

        services.tailscale.enable = true;
        networking.firewall.trustedInterfaces = [ "tailscale0" ];

        time.timeZone = "Europe/Warsaw";

        services.logind.settings.Login = {
          HandleLidSwitch = "suspend";
          HandleLidSwitchExternalPower = "ignore";
        };
      };

    includes =
      (with den.aspects; [
        libvirt
        podman
        ssh
        sudo
        fonts
      ])
      ++ [ (den.batteries.import-tree ./hardware) ];
  };

  den.hosts.x86_64-linux.kr7va = { };
}
