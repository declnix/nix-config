# Subplan: Create nix/hjem/tmux.nix

## Objective
Implement the core Tmux module definition supporting plugin management (`dag` ordering) and `initConfig`.

## Implementation Steps
1. Create `nix/hjem/tmux.nix`.
2. Define options for `plugins` (with `after`/`before` support) and `initConfig`.
3. Implement `config` logic to generate `tmux.conf`.

## Snippet
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

## Verification
1. Ensure the module compiles.
