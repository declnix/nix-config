# Subplan: Cleanup and integration

## Objective
Remove legacy Zsh app definitions and register the Zsh aspect in the new module with `inputs` forwarding to enable DAG-based plugin management.

## Implementation Steps
1. Remove `nix/@den/apps/zsh/den.nix` and `nix/@den/apps/zsh/default.nix`.
2. [✓] Add `den.aspects.zsh` definition to `nix/@den/apps/zsh.nix`.
3. [✓] Forward `inputs` from den to `rum.wrappered.zsh` module option.

## Snippet
```nix
{
  den,
  inputs,
  ...
}:
{
  den.aspects.zsh = {
    hjem = { ... }: {
      rum.wrappered.zsh = {
        enable = true;
        inherit inputs;
      };
    };
  };
}
```

## Technical Notes
- `inputs` are inherited from top-level and passed to `rum.wrappered.zsh` option
- `nix/hjem/zsh.nix` module accepts `inputs` via option and forwards to `dag.lib { inherit lib; }`
- This allows DAG-based plugin ordering via `inputs.dag.lib`

## Verification
1. [✓] `den.aspects.zsh` correctly enables the new module
2. [✓] `inputs.dag.lib` is accessible to zsh module for plugin DAG rendering
3. [✓] Flake builds without errors
