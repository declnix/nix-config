{ config, lib, ... }:
{
  apps = lib.mapAttrs (_: pkg: "${pkg}/bin/${pkg.meta.mainProgram}") config.packages;
}
