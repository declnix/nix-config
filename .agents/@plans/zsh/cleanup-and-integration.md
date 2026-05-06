# Subplan: Cleanup and integration

## Objective
Remove legacy Zsh app definitions and register the Zsh aspect in the new module.

## Implementation Steps
1. Remove `nix/@den/apps/zsh/den.nix` and `nix/@den/apps/zsh/default.nix`.
2. Add `den.aspects.zsh` definition to `nix/hjem/zsh.nix`.

## Snippet
```nix
den.aspects.zsh = {
  hjem = { ... }: {
    rum.programs.zsh.enable = true;
  };
};
```

## Verification
1. Verify that `den.aspects.zsh` correctly enables the new module.
