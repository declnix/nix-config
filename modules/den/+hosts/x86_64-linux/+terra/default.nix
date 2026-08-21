{ den
, ...
}:
{
  den.aspects.terra = {
    nixos =
      { ... }:
      {
        networking.networkmanager.enable = true;
        services.upower.enable = true;
        services.power-profiles-daemon.enable = true;

        time.timeZone = "Europe/Warsaw";

        services.greetd.settings.default_session.user = "declnix";

        services.logind.settings.Login = {
          HandleLidSwitch = "suspend";
          HandleLidSwitchExternalPower = "ignore";
        };
      };

    includes =
      (with den.aspects; [ tailscale ssh podman fonts ])
      ++ [ (den.batteries.import-tree ./.imports) ];
  };

  den.hosts.x86_64-linux.terra = {
    users.declnix = { };
  };
}
