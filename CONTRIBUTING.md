## Commit Convention (Host Scope Strategy)

### Format

```
type(scope): short imperative message
```

---

### Scope Rules

* `scope = <hostname>` → change affects only a single host
* `scope = core` → global or shared change
* No other scopes are allowed
* Do not mix multiple hosts in one commit

---

### Allowed Types

* `feat`
* `fix`
* `refactor`
* `chore`
* `style`
* `docs`
* `ci`

---

### Decision Rules

1. If the change affects only one host → use that hostname as the scope.
2. If the change affects:

   * multiple hosts,
   * shared directories,
   * flake configuration,
   * shared modules,
     → use `core`.
3. Scope reflects the **blast radius of the change**, not the file type.

---

### Examples

Host-specific:

```
feat(c4rg0x): enable container runtime
refactor(pstnd01): extract home module
fix(c4rg0x): correct network interface
```

Global:

```
feat(core): add shared home module
refactor(core): simplify flake outputs
fix(core): correct nixpkgs input
style(core): format repository
```

---

### Additional Rules

If a previously host-local module becomes shared:

```
refactor(core): move backup module to shared
```

The commit should always describe the **scope of impact**, not the technical form of the change.

---

When copying configuration from one host to another, use the same commit titles with the target hostname as scope, maintaining the same granularity:

```
feat(c4rg0x): enable zsh autosuggestion and syntax highlighting
feat(c4rg0x): enable zoxide with zsh integration
```

becomes:

```
feat(pstnd01): enable zsh autosuggestion and syntax highlighting
feat(pstnd01): enable zoxide with zsh integration
```
