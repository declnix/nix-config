# Subplan: Update nix/@den/hjem.nix

## Objective
Simplify module imports to rely on the new local `hjem` configuration structure.

## Implementation Steps
1. Update `den.default.nixos.hjem.extraModules` in `nix/@den/hjem.nix`.
2. Point it to `nix/hjem/default.nix` and `hjem-impure`.

## Snippet
```nix
den.default.nixos.hjem.extraModules = [
  ../hjem/default.nix
  inputs.hjem-impure.hjemModules.default
];
```

## Verification
1. Ensure system configuration imports the new structure correctly.
