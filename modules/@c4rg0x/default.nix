{ den, ... }:
{
  den.aspects.c4rg0x = {
    includes = with den.aspects; [
      zscaler
    ];
  };

  den.hosts.x86_64-linux.c4rg0x = {
    wsl.enable = true;
  };
}
