# Subplan: Add dag to nix/@den/hjem.nix and update

## Objective
Integrate `dag` dependency into the project's flake configuration to enable ordered configuration management.

## Implementation Steps
1. Add `dag.url = "github:denful/dag";` to `flake-file.inputs` in `nix/@den/hjem.nix`.
2. Run `just flake` to update the flake lock file and expose the new input.

## Snippet
```nix
flake-file.inputs = {
  # ...
  dag.url = "github:denful/dag";
};
```

## Verification
1. Verify `flake.lock` contains `dag`.
2. Ensure `just flake` completes successfully without errors.
