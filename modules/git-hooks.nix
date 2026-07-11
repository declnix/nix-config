{ inputs, lib, ... }:
{
  imports = [
    inputs.git-hooks-nix.flakeModule
  ];

  perSystem = { ... }: {
    agents.instructions = lib.mkOrder 200 [
      ''
        - Commit messages: use `scope: short description`, e.g. `kr7va: add audio support`.
        - For host-specific module changes under `modules/config/+machines/<host>/`, use the host as the scope and include the module in the title as `host: module -> title`, e.g. `kr7va: niri -> extract config`.
      ''
    ];

    pre-commit = {
      check.enable = true;
      settings.hooks = {
        treefmt.enable = true;
        deadnix = {
          enable = true;
          settings.edit = true;
        };
      };
    };
  };

  flake-file.inputs.git-hooks-nix = {
    url = "github:cachix/git-hooks.nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };
}
