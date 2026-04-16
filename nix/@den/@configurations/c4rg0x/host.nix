{ den, ... }:
{
  den.aspects.c4rg0x =
    { host, ... }:
    {
      includes = with den.aspects; [
        wsl
        zscaler
      ];
    };

  den.hosts.x86_64-linux.c4rg0x = { };
}
