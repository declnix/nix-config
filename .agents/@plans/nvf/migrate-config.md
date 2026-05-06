# Subplan: Migrate configuration

## Objective
Shift configuration from `den.aspects` to `rum.programs.nvf.settings`.

## Implementation Steps
1. Update `nix/@den/@hosts/bur34u/@users/nixos.nix`.

## Snippet
```nix
rum.programs.nvf = {
  enable = true;
  settings = {
    vim = {
      # ... original configuration migrated here
    };
  };
};
```

## Verification
1. Verify Nvim configuration is correctly applied.
