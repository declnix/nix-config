# Plan: Implement custom Neovim (nvf) module and integration

## Goal
Replace the custom `den` aspect wrapper for `nvf` with a native `hjem` module (`nix/hjem/nvf.nix`), allowing direct use of `rum.programs.nvf` while maintaining compatibility with the existing `nvf` module system.

## Plan

### 1. Create `nix/hjem/nvf.nix`
Implement a module that wraps `nvf.lib.neovimConfiguration`.
[Subplan: nvf/create-nvf-module.md](nvf/create-nvf-module.md)

### 2. Update `nix/hjem/default.nix`
Ensure the new `nvf.nix` is included in the module aggregation.
[Subplan: nvf/aggregate-modules.md](nvf/aggregate-modules.md)

### 3. Migrate configuration from `@den/apps/nvim`
Shift configuration from `den.aspects` to `rum.programs.nvf.settings`.
[Subplan: nvf/migrate-config.md](nvf/migrate-config.md)

### 4. Cleanup
Remove legacy `nvim` app definitions and the complex `den.lib.nvim` parametric system.
[Subplan: nvf/cleanup.md](nvf/cleanup.md)
