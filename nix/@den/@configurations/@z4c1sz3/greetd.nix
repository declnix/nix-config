{ den, ... }:
{
  den.aspects.z4c1sz3 =
    { host, ... }:
    {
      nixos =
        { pkgs, ... }:
        {
          services.greetd = {
            enable = true;
            settings.default_session.command = "${pkgs.greetd.tuigreet}/bin/tuigreet --cmd niri";
          };
        };
    };
}
