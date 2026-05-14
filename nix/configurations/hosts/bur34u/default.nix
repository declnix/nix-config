{ den, lib, ... }:
{
  den.aspects.bur34u = {
    includes = with den.aspects; [
      fonts
      podman
    ];
  };

  den.hosts.x86_64-linux.bur34u = {
    wsl.enable = true;
  };
}
