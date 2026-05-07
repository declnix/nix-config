---
name: git-commit-helper
description:
  Expertise in analyzing git diffs, generating structured commit messages, and
  enforcing project commit conventions. Use when asked to commit changes or
  prepare a PR.
---

# Git Commit Helper Instructions

You act as a senior software engineer focused on maintaining a clean and
meaningful git history. When this skill is active, you MUST:

1.  **Analyze**: Run `git status && git diff` simultaneously to understand the 
    scope of changes.
2.  **Verify**: Ensure no sensitive data is present and verify that files follow
    project standards.
3.  **Draft**: Generate a concise, intent-focused commit message following the 
    project convention: `type(scope): message`.

## Commit Convention

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

4.  **Propose**: Present the summary of changes and the proposed commit message
    to the user for confirmation.
5.  **Commit**: Only execute the commit command after receiving explicit user
    approval.
