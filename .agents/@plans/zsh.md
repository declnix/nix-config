# Plan: Implement custom Zsh module and integration

## Goal
Replace the external Zsh module from `hjem-rum` with a custom implementation in `nix/hjem/zsh.nix` using `dag`, and simplify the configuration structure by flattening it.

## Plan

### ~~1. Add `dag` to `nix/@den/hjem.nix` and update~~
~~Integrate `dag` dependency into the project's flake configuration.~~
~~[Subplan: zsh/add-dag.md](zsh/add-dag.md)~~

### 2. Create `nix/hjem/zsh.nix`
Implement the core Zsh module definition supporting plugin management and configuration initialization.
[Subplan: zsh/create-zsh-module.md](zsh/create-zsh-module.md)

### 3. Aggregate modules in `nix/hjem/default.nix`
Configure module aggregation to include the new custom Zsh module within the `hjem` system.
[Subplan: zsh/aggregate-modules.md](zsh/aggregate-modules.md)

### 4. Update `nix/@den/hjem.nix`
Simplify module imports to rely on the new local `hjem` configuration structure.
[Subplan: zsh/update-hjem-config.md](zsh/update-hjem-config.md)

### 5. Cleanup and integration
Remove legacy Zsh app definitions and register the Zsh aspect in the new module.
[Subplan: zsh/cleanup-and-integration.md](zsh/cleanup-and-integration.md)

### 6. Update dependency modules
Adjust existing dependency modules to utilize the new `rum.programs.zsh.initConfig` paths.
[Subplan: zsh/update-deps.md](zsh/update-deps.md)

### 7. Migrate existing plugins
Refactor and migrate Zsh plugins to the new `rum.programs.zsh.plugins` structure with deferred loading.
[Subplan: zsh/migrate-plugins.md](zsh/migrate-plugins.md)

### 8. Update host-specific Zsh proxy configuration
Refactor host-specific proxy settings to integrate with the new Zsh module configuration.
[Subplan: zsh/update-proxy.md](zsh/update-proxy.md)
