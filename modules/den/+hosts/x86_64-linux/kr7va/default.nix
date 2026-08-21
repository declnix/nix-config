{ den
, ...
}:
{
  den.aspects.kr7va = {
    nixos =
      { ... }:
      {
        networking.networkmanager.enable = true;
        services.upower.enable = true;
        services.power-profiles-daemon.enable = true;

        time.timeZone = "Europe/Warsaw";

        services.logind.settings.Login = {
          HandleLidSwitch = "suspend";
          HandleLidSwitchExternalPower = "ignore";
        };
      };

    includes =
      (with den.aspects; [ tailscale ssh podman fonts ])
      ++ [ (den.batteries.import-tree ./_imports) ];
  };

  den.hosts.x86_64-linux.kr7va = {
    users.declnix = { };
  };
}
