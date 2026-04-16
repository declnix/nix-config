{ den, ... }:
{
  den.aspects.fuzzel = {
    hjem =
      { pkgs, ... }:
      {
        packages = [ pkgs.fuzzel ];
      };
  };
}
