# Plan: Implement custom Zsh module and integration

## Goal
Replace the external Zsh module from `hjem-rum` with a custom implementation in `nix/hjem/zsh.nix` using `dag`, and simplify the configuration structure by flattening it.

## Plan

### [✓] 1. Add `dag` to `nix/@den/hjem.nix` and update
Integrate `dag` dependency into the project's flake configuration.
[Subplan: zsh/add-dag.md](zsh/add-dag.md)

### [✓] 2. Create `nix/hjem/zsh.nix`
Implement the core Zsh module definition supporting plugin management and configuration initialization.
[Subplan: zsh/create-zsh-module.md](zsh/create-zsh-module.md)

### [✓] 3. Aggregate modules in `nix/hjem/default.nix`
Configure module aggregation to include the new custom Zsh module within the `hjem` system.
[Subplan: zsh/aggregate-modules.md](zsh/aggregate-modules.md)

### ~~4. Update `nix/@den/hjem.nix`~~
Simplify module imports to rely on the new local `hjem` configuration structure.
[Subplan: zsh/update-hjem-config.md](zsh/update-hjem-config.md)

### [✓] 5. Cleanup and integration
Remove legacy Zsh app definitions and register the Zsh aspect in the new module with inputs forwarding.
[Subplan: zsh/cleanup-and-integration.md](zsh/cleanup-and-integration.md)

### [✓] 6. Update dependency modules
Adjust existing dependency modules to utilize the new `rum.wrappered.zsh.initConfig` paths.
[Subplan: zsh/update-deps.md](zsh/update-deps.md)

### [✓] 7. Migrate existing plugins
Refactor and migrate Zsh plugins to the new `rum.programs.zsh.plugins` structure with deferred loading.
[Subplan: zsh/migrate-plugins.md](zsh/migrate-plugins.md)

### [✓] 8. Update host-specific Zsh proxy configuration
Refactor host-specific proxy settings to integrate with the new Zsh module configuration.
[Subplan: zsh/update-proxy.md](zsh/update-proxy.md)

## Completion Notes

**Final Implementation (May 7, 2026)**

Successfully implemented zsh plugin migration using custom den class with forwarder pattern:

- **Custom Zsh Class**: `den.aspects.zsh` with domain key `zsh` containing all plugin definitions
- **Forwarder Pattern**: `den.ctx.user.includes` routes zsh class to hjem via `den.provides.forward`
- **Module Rendering**: `den.lib.zsh.module` evaluates zsh config with aspect resolution, collecting:
  - Base plugins from `den.aspects.zsh`
  - User-specific aspects via `den.lib.parametric.fixedTo`
  - Host-wide contributions via `provides.to-users`
  - User contributions via `provides.${user.aspect.name}`
  - Host contributions via `provides.to-hosts`
- **Plugin Ordering**: DAG-based via `nix/hjem/zsh.nix` with `zsh-defer` for deferred loading
- **Proxy Integration**: `provides.to-users.zsh` from `proxy.nix` properly merged into initConfig
- **No Duplication**: Fixed duplication issue by using forwarder pattern instead of direct aspect collection

All plugins appear once in final zshrc with correct DAG ordering.
