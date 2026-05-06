# Plan: Implement custom Tmux module and integration

## Goal
Replace the external Tmux configuration from `nix/@den/apps/tmux` with a custom implementation in `nix/hjem/tmux.nix` using `dag`, allowing per-plugin `after`/`before` dependency management similar to the Zsh implementation.

## Detailed changes

### 1. Create `nix/hjem/tmux.nix`
*   **File:** `nix/hjem/tmux.nix` (new)
*   **Change:** Implement a Tmux module supporting `plugins` (with `dag` ordering) and `initConfig`.
*   **Snippet:**
```nix
{ lib, config, inputs, ... }:
let
  inherit (lib) mkOption types concatStringsSep mapAttrs filterAttrs;
  dag = inputs.dag.lib;
  cfg = config.rum.programs.tmux;
in {
  options.rum.programs.tmux = {
    enable = lib.mkEnableOption "tmux";
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
    files.".config/tmux/tmux.conf".text = let
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

### 2. Cleanup and integration (`tmux/default.nix` -> `tmux.nix`)
*   **Files:** Remove `nix/@den/apps/tmux/den.nix`, remove `nix/@den/apps/tmux/default.nix`.
*   **Change:** Move Tmux aspect definition directly to `nix/hjem/tmux.nix`.
*   **Snippet (added to `nix/hjem/tmux.nix`):**
```nix
den.aspects.tmux = {
  hjem = { ... }: {
    rum.programs.tmux.enable = true;
  };
};
```

### 3. Migrate existing plugins (Expanded)
*   **File:** `nix/hjem/tmux.nix`
*   **Change:** Move hardcoded `run-shell` plugins from `nix/@den/apps/tmux/default.nix` to `rum.programs.tmux.plugins`.
*   **Snippet (Migration Example):**
```nix
rum.programs.tmux.plugins = {
  sensible = { enable = true; text = "run-shell ${pkgs.tmuxPlugins.sensible.rtp}"; };
  resurrect = { 
    enable = true; 
    after = ["sensible"]; 
    text = "run-shell ${pkgs.tmuxPlugins.resurrect.rtp}"; 
  };
  continuum = { 
    enable = true; 
    after = ["resurrect"]; 
    text = "run-shell ${pkgs.tmuxPlugins.continuum.rtp}"; 
  };
};
```

## Verification
*   Verify `.config/tmux/tmux.conf` generation and plugin ordering (Sensible -> Resurrect -> Continuum).
