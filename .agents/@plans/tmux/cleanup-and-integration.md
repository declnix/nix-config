# Subplan: Cleanup and integration

## Objective
Remove legacy Tmux app definitions and register the Tmux aspect in the new module.

## Implementation Steps
1. Remove `nix/@den/apps/tmux/den.nix` and `default.nix`.
2. Add `den.aspects.tmux` to `nix/hjem/tmux.nix`.

## Snippet
```nix
den.aspects.tmux = {
  hjem = { ... }: {
    rum.programs.tmux.enable = true;
  };
};
```

## Verification
1. Ensure Tmux aspect is correctly registered.
