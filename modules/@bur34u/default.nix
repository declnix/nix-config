{
  inputs,
  den,
  lib,
  bur34u,
  ...
}:
{

  den.aspects.bur34u = {
    includes = (
      with den.aspects;
      [
        podman
        fonts
      ]
    );
  };

  den.hosts.x86_64-linux.bur34u = {
    wsl.enable = true;
  };
}
