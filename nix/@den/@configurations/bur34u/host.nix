{ den, ... }:
{
  den.aspects.bur34u =
    { host, ... }:
    {
      includes = with den.aspects; [ wsl ];
    };

  den.hosts.x86_64-linux.bur34u = { };
}
