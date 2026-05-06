# Plan: Implement custom Tmux module and integration

## Goal
Replace the external Tmux configuration from `nix/@den/apps/tmux` with a custom implementation in `nix/hjem/tmux.nix` using `dag`, allowing per-plugin `after`/`before` dependency management.

## Plan

### 1. Create `nix/hjem/tmux.nix`
Implement the core Tmux module definition supporting plugin management (`dag` ordering) and `initConfig`.
[Subplan: tmux/create-tmux-module.md](tmux/create-tmux-module.md)

### 2. Cleanup and integration
Remove legacy Tmux app definitions and register the Tmux aspect in the new module.
[Subplan: tmux/cleanup-and-integration.md](tmux/cleanup-and-integration.md)

### 3. Migrate existing plugins
Refactor and migrate Tmux plugins to the new `rum.programs.tmux.plugins` structure.
[Subplan: tmux/migrate-plugins.md](tmux/migrate-plugins.md)
