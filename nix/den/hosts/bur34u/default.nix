{ den, lib, ... }:
{
  den.aspects.bur34u = {
    includes = with den.aspects; [
      wsl
      fonts
      podman
    ];
  };

  den.hosts.x86_64-linux.bur34u = { };
}
