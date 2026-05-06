# Plan: Implement custom Zsh module and integration

## Goal
Replace the external Zsh module from `hjem-rum` with a custom implementation in `nix/hjem/zsh.nix` using `dag`, and simplify the configuration structure by flattening it.

## Detailed changes

### 1. Add `dag` to `nix/@den/hjem.nix` and update
*   **File:** `nix/@den/hjem.nix`
*   **Change:** Add `dag` to `flake-file.inputs`. Run `just flake` after modification.
*   **Snippet:**
```nix
flake-file.inputs = {
  # ...
  dag.url = "github:denful/dag";
};
```

### 2. Create `nix/hjem/zsh.nix`
*   **File:** `nix/hjem/zsh.nix` (new)
*   **Change:** Implement a Zsh module supporting `plugins` and `initConfig`.
*   **Snippet:**
```nix
{ lib, config, inputs, ... }:
let
  inherit (lib) mkOption types concatStringsSep mapAttrs filterAttrs;
  dag = inputs.dag.lib;
  cfg = config.rum.programs.zsh;
in {
  options.rum.programs.zsh = {
    enable = lib.mkEnableOption "zsh";
    plugins = mkOption { type = types.attrsOf (types.submodule { 
      options = { 
        enable = lib.mkEnableOption "plugin";
        after = mkOption { type = types.listOf types.str; default = []; };
        before = mkOption { type = types.listOf types.str; default = []; };
        text = mkOption { type = types.lines; };
      }; 
    }); default = {}; };
    initConfig = mkOption { type = types.lines; default = ""; };
  };
  config = lib.mkIf cfg.enable {
    files.".zshrc".text = let
      enabled = filterAttrs (_: v: v.enable) cfg.plugins;
      dagEntries = mapAttrs (name: p:
        if p.after != [] then dag.entryAfter p.after p.text
        else if p.before != [] then dag.entryBefore p.before p.text
        else dag.entryAnywhere p.text
      ) enabled;
    in concatStringsSep "\n" (dag.render dagEntries ++ [ cfg.initConfig ]);
  };
}
```

### 3. Aggregate modules in `nix/hjem/default.nix`
*   **File:** `nix/hjem/default.nix` (new)
*   **Change:** Use the `import-tree` pattern with `filterNot` to aggregate custom local modules, then import `hjem-rum` modules.
*   **Snippet:**
```nix
{ inputs, lib, ... }: {
  imports = (inputs.import-tree ./.).filterNot (lib.hasSuffix "default.nix") ++ [
    inputs.hjem-rum.hjemModules.default
  ];
}
```

### 4. Update `nix/@den/hjem.nix`
*   **File:** `nix/@den/hjem.nix`
*   **Change:** Simplify `den.default.nixos.hjem.extraModules` to only import `nix/hjem/default.nix` and `hjem-impure`.
*   **Snippet:**
```nix
den.default.nixos.hjem.extraModules = [
  ../hjem/default.nix
  inputs.hjem-impure.hjemModules.default
];
```

### 5. Cleanup and integration (`zsh/default.nix` -> `zsh.nix`)
*   **Files:** Remove `nix/@den/apps/zsh/den.nix`, remove `nix/@den/apps/zsh/default.nix`.
*   **Change:** Move Zsh aspect definition directly to `nix/hjem/zsh.nix`.
*   **Snippet (added to `nix/hjem/zsh.nix`):**
```nix
den.aspects.zsh = {
  hjem = { ... }: {
    rum.programs.zsh.enable = true;
  };
};
```

### 6. Update dependency modules
*   **Files:** `nix/hjem/bat.nix`, `nix/hjem/eza.nix`, `nix/hjem/lazygit.nix`, `nix/hjem/waybar.nix`.
*   **Change:** Review and adjust `rum.programs.zsh.initConfig` paths.

### 7. Migrate existing plugins (Expanded)
*   **File:** `nix/hjem/zsh.nix`
*   **Change:** Move and refactor plugins from `nix/@den/apps/zsh/default.nix` and `nzf` to `rum.programs.zsh.plugins`. 
*   **Implementation Strategy:** Use a helper function (or logic within the module) to conditionally apply `zsh-defer` to plugin sourcing commands.

*   **Plugin Strategy & Order:**

| Plugin | Defer | Dependencies (Order) | Notes |
| :--- | :--- | :--- | :--- |
| `zsh-defer` | No | - | Required base for deferral. |
| `zsh-vi-mode` | No | - | Must load early, especially for keybindings. |
| `zsh-fzf-history-search` | Yes | After `zsh-defer`, `zsh-vi-mode` | Bindings must occur after `zsh-vi-mode` init. |
| `zsh-autosuggestions` | Yes | After `zsh-defer` | |
| `zsh-syntax-highlighting` | Yes | After `zsh-defer`, `zsh-autosuggestions` | Syntax-highlighting must load after autosuggestions to avoid conflicts. |
| `fzf-tab` | No | Before `zsh-autosuggestions` | |
| `oh-my-zsh (git)` | Yes | After `zsh-defer` | |

*   **Snippet (Migration Example using Defer):**
```nix
rum.programs.zsh.plugins = {
  zsh-vi-mode = { enable = true; text = "source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh"; };
  zsh-fzf-history-search = { 
    enable = true; 
    after = ["zsh-defer" "zsh-vi-mode"]; 
    text = "zsh-defer source ${pkgs.zsh-fzf-history-search}/share/zsh-fzf-history-search/zsh-fzf-history-search.zsh"; 
  };
  # ... 
};
```
*Note: Any plugin marked 'Yes' for defer should have `zsh-defer` prepended to its source command.*

### 8. Update host-specific Zsh proxy configuration
*   **File:** `nix/@den/@hosts/bur34u/proxy.nix`
*   **Change:** Update the `provides.to-users.zsh` section to use `rum.programs.zsh.initConfig` instead of the old structure.
*   **Snippet:**
```nix
    provides.to-users = {
      zsh = {
        rum.programs.zsh.initConfig = ''
          if [ -f /run/nix-proxy.env ]; then
            ${sourceExported "/run/nix-proxy.env"}
          fi
        '';
      };
    };
```
