# Flake-file Management Skill

This skill governs the management and regeneration of the `flake.nix` file using the `flake-file` tool.

## Procedures
- **Regenerating flake.nix**: When changing flake inputs in `nix/@den/`, the `flake.nix` file must be regenerated.
- **Command**: Always use `just flake`. This executes `nix run ".#write-flake"`, which handles the regeneration correctly.
- **Safety**: Do not manually edit `flake.nix`. Always rely on the project's orchestration tools.
