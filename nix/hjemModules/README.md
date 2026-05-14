# Hjem Modules Overrides

The structure within this directory mirrors the layout of the `hjem-rum` repository (specifically its `modules/` directory).

This mirrored layout enables **automated module disabling** in `nix/configurations/hjem.nix`. Every local module automatically disables its upstream counterpart in `hjem-rum` to prevent option collisions and ensure local overrides take precedence without manual configuration.
