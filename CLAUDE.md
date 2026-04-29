# CLAUDE.md

## Commits

- Never add `Co-Authored-By` lines to commits.
- Read `CONTRIBUTING.md` and follow its commit convention before committing.

## Workflow

- Before running `nix run .#write-flake` or any command that evaluates the flake, ensure new files are tracked by git (`git add`). `import-tree` and `flake-file` only see git-tracked files.
- When inspecting a flake input or library repo (e.g. nixpkgs, home-manager, nvf), first check `~/@github/<owner>/<repo>`. If it exists, read from there. If not, clone it there and read files directly.
- Never fetch individual files from GitHub over HTTP.

## Den structure

- Entry-point files are named `default.nix`.
- The `@` prefix belongs on directories only (for sort order), never on files.
- For short host definitions, use a single `<host>.nix` file.
- For small hosts (e.g. WSL), merge host and user config into a single `default.nix`.
- Files under ~20 lines are candidates for merging into `default.nix`.
- Keep a file separate if it contains `flake-file.inputs` — that signals an external dependency that is easier to locate in its own file.
- Block order within an aspect file: `den.aspects.*` first, then other `den`/library config, then `flake-file.*` last.
- Within a `den.aspects.*` block: dedicated domain key (e.g. `vim`) first, then `hjem`, then `nixos`.
- Keep a file separate if it has a clearly distinct domain (e.g. `wsl.nix`, `comma.nix`).
- In host files, keep this block order: user provides → user host registration → host aspect → host registration.
- User aspects must always be host-scoped: `den.aspects.<user>.provides.<host>`.
- Never create a global `den.aspects.<user>` unless explicitly asked.

## Hjem modules

- For programs with user configuration, first check whether `hjem-rum` already provides the needed module.
- If `hjem-rum` has the module, use it instead of defining program logic inline in an aspect.
- If the module is missing, create a local module under `nix/hjem/`.
- Local modules should expose the basic properties the program needs, including `extraConfig` and shell integration when relevant.
- Aspects only aggregate and enable modules — they do not define program logic inline.

## Program libraries (lib.nix)

- When a program library needs to collect scattered `provides.to-users` contributions, define an inline parametric forwarder in `lib.nix`, not a separate provides aspect.
- The forwarder checks the parametric `class` parameter and conditionally includes contributions:
  ```nix
  zshFromProvidesToUsers = { class, aspect-chain }:
    if class == "zsh" then { includes = lib.concatMap (...) (lib.attrValues den.aspects); }
    else { };
  ```
- Include the forwarder directly in the parametric `includes` list, not via `den.default.includes`.

## Nix

- Format all Nix code the way `nixfmt` does — follow its indentation, line-breaking, and spacing conventions so that running `nixfmt` produces no diff.
- Never list or glob the Nix store (`/nix/store/…`). The store tree is enormous and listing it wastes context. The only permitted exception is reading a single, fully-known store path for final verification — and only when you already have the exact path.

## Comments

- Only add a comment when it explains a non-obvious workaround at a specific location. Do not describe what code does.
- Never add decorative section banners (`###…`) unless a file is long enough that navigation aids are genuinely necessary.
- All comments must be in English.
