# Commit Procedures and Conventions

## Workflow (The "Flow")
1. **Analyze**: Run `git status && git diff` simultaneously.
2. **Verify**: Check for secrets and project standards.
3. **Draft**: Create a message following `type(scope): message`.
4. **Propose**: Show summary and message to the user.
5. **Commit**: ONLY commit after user confirmation.

## Conventions

### Types
| Type | When |
|------|------|
| `feat` | new aspect, program, host, or user |
| `fix` | bug fix in configuration |
| `refactor` | restructuring without behavior change |
| `docs` | documentation, README, CLAUDE.md |
| `chore` | `flake.lock` updates, housekeeping, renames |

### Scopes
- **Programs/aspects:** `niri`, `git`, `wsl`, `zsh`, `tmux`, `nvf`, `fonts`, `hjem`, `nix`, `podman`
- **AI:** `ai` (use `docs(ai)` prefix for AI-related documentation)
- **Hosts:** `z4c1sz3`, `bur34u`, `c4rg0x`
- **Global:** `flake`, `den`, `hardware`

### Rules
- Scope = name of the **host** when the change is host-specific, otherwise name of the aspect or file being changed.
- Message lowercase, no trailing period.
- Omit scope only for truly global commits (e.g., `init`).
- STRICTLY prohibit the use of `Co-Authored-By`.
