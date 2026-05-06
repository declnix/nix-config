# Subplan: Aggregate modules in nix/hjem/default.nix

## Objective
Configure module aggregation to include the new custom Zsh module within the `hjem` system.

## Implementation Steps
1. [✓] Create `nix/hjem/default.nix` with explicit module imports
2. [✓] Refactor `zsh.nix` to use wrapper pattern (`rum.wrappered.zsh`) to avoid conflicts with hjem-rum
3. [✓] Import all local modules and `hjem-rum` modules
4. [✓] Ensure input forwarding for modules requiring `inputs` (dag, etc.)

## Final Implementation
```nix
{ inputs, lib, ... }:
{
  imports = [
    ./bat.nix
    ./eza.nix
    ./lazygit.nix
    ./waybar.nix
    ./zsh.nix
    inputs.hjem-rum.hjemModules.default
  ];
}
```

## Key Decisions
- Used explicit module list instead of `import-tree` for clarity and control
- Refactored `zsh.nix` to define `options.rum.wrappered.zsh` instead of `options.rum.programs.zsh` to avoid option conflicts with hjem-rum
- Module forwards input via wrapper: `(import ../hjem/default.nix { inherit inputs lib; })`

## Verification
1. [✓] `nix flake check` passes without option conflicts
2. [✓] Modules aggregated correctly in hjem system
