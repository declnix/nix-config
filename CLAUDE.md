# CLAUDE.md

## Commits

- Never add `Co-Authored-By` lines to commits.
- Follow the commit convention defined in `CONTRIBUTING.md` — read it before committing.

## Nix

- Before running `nix run .#write-flake` or any command that evaluates the flake, ensure new files are tracked by git (`git add`). `import-tree` and `flake-file` only see git-tracked files.
- When you need to inspect a flake input or library repo (e.g. nixpkgs, home-manager, nvf), first check if it is already cloned at `~/@github/<owner>/<repo>`. If it is, read from there. If not, clone it to that path and read files directly — never fetch individual files over HTTP.
- Never list or glob the Nix store (`/nix/store/…`). The store tree is enormous and listing it wastes context. The only permitted exception is reading a single, fully-known store path for final verification — and only when you already have the exact path.

## Comments

- Only add a comment when it explains a non-obvious workaround at a specific location. Do not describe what code does.
- Never add decorative section banners (`###…`) unless a file is long enough that navigation aids are genuinely necessary.
- All comments must be in English.

## Exploring external repositories

- Do not fetch individual files from GitHub via HTTP. Instead, clone the repo to `~/@github/<owner>/<repo>` and read files directly.
- Before cloning, check if `~/@github/<owner>/<repo>` already exists — if so, use it as-is.
