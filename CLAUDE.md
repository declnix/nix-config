# CLAUDE.md

## Commits

- Never add `Co-Authored-By` lines to commits.
- Follow the commit convention defined in `CONTRIBUTING.md` — read it before committing.

## Nix

- Before running `nix run .#write-flake` or any command that evaluates the flake, ensure new files are tracked by git (`git add`). `import-tree` and `flake-file` only see git-tracked files.

## Exploring external repositories

- Do not fetch individual files from GitHub via HTTP. Instead, clone the repo to `~/@github/<owner>/<repo>` and read files directly.
- Before cloning, check if `~/@github/<owner>/<repo>` already exists — if so, use it as-is.
