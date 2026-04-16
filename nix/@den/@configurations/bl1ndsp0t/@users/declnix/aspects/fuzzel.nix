{ den, ... }:
{
  den.aspects.bl1ndsp0t.provides.declnix = {
    hjem =
      { pkgs, ... }:
      {
        packages = [ pkgs.fuzzel ];
      };
  };
}
