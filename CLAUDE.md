# CLAUDE.md

## Commits

- Never add `Co-Authored-By` lines to commits.
- Follow the commit convention defined in `CONTRIBUTING.md` — read it before committing.

## Den configuration conventions

### File naming
- Entry-point files are named `default.nix`.
- The `@` prefix belongs on directories only (for sort order), never on files.

### Merging short files
- Files under ~20 lines are candidates for merging into `default.nix`.
- Keep a file separate if it contains `flake-file.inputs` — that signals an external dependency that is easier to locate in its own file.
- Keep a file separate if it has a clearly distinct domain (e.g. `wsl.nix`, `comma.nix`).

### Small hosts (e.g. WSL)
- Merge host and user config into a single `default.nix`.

### Block order in host files
- User provides → user host registration → host aspect → host registration.

### User aspects
- User aspects must always be host-scoped: `den.aspects.<user>.provides.<host>`.
- Never create a global `den.aspects.<user>` unless explicitly asked.

### Hjem modules vs aspects
- Programs with shell integrations (aliases, functions, init snippets) belong in a rum module under `nix/hjem/`.
- Aspects only aggregate and enable modules — they do not define program logic inline.

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
