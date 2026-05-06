# Subplan: Create nix/hjem/nvf.nix

## Objective
Implement a module that wraps `nvf.lib.neovimConfiguration`.

## Implementation Steps
1. Create `nix/hjem/nvf.nix`.
2. Wrap `nvf` configuration logic.

## Snippet
```nix
{ lib, config, pkgs, inputs, ... }:
let
  cfg = config.rum.programs.nvf;
in {
  options.rum.programs.nvf = {
    enable = lib.mkEnableOption "nvf";
    settings = lib.mkOption { type = lib.types.anything; default = {}; };
  };

  config = lib.mkIf cfg.enable {
    packages = [
      (inputs.nvf.lib.neovimConfiguration {
        inherit pkgs;
        modules = [ cfg.settings ];
      }).neovim
    ];
  };
}
```

## Verification
1. Verify `nvf` availability.
