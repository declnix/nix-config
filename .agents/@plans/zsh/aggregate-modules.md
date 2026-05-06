# Subplan: Aggregate modules in nix/hjem/default.nix

## Objective
Configure module aggregation to include the new custom Zsh module within the `hjem` system.

## Implementation Steps
1. Create `nix/hjem/default.nix` (or update if exists).
2. Implement `import-tree` pattern with `filterNot` to load all custom local modules.
3. Import `hjem-rum` modules.

## Snippet
```nix
{ inputs, lib, ... }: {
  imports = (inputs.import-tree ./.).filterNot (lib.hasSuffix "default.nix") ++ [
    inputs.hjem-rum.hjemModules.default
  ];
}
```

## Verification
1. Verify that modules in `nix/hjem/` are correctly aggregated.
