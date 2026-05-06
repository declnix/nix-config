# Subplan: Create nix/hjem/zsh.nix

## Objective
Implement the core Zsh module definition supporting plugin management (`dag` ordering) and `initConfig`.

## Implementation Steps
1. [✓] Create `nix/hjem/zsh.nix`.
2. [✓] Implement module options: `enable`, `plugins` (with `after`/`before` logic), and `initConfig`.
3. [✓] Implement `config` logic to render `dag` entries and `initConfig` into `.zshrc`.

## Snippet
```nix
{ lib, config, ... }:
let
  inherit (lib) mkOption types concatStringsSep mapAttrs filterAttrs mkIf;
  wrapCfg = config.rum.wrappered.zsh;
  dag = wrapCfg.inputs.dag.lib { inherit lib; };
in {
  options.rum.wrappered.zsh = {
    enable = lib.mkEnableOption "zsh wrapper with dag-based plugin management";
    inputs = mkOption {
      type = types.attrs;
      default = { };
      description = "Flake inputs passed from den aspect";
    };
    plugins = mkOption { 
      type = types.attrsOf (types.submodule { 
        options = { 
          enable = lib.mkEnableOption "plugin";
          after = mkOption { type = types.listOf types.str; default = []; };
          before = mkOption { type = types.listOf types.str; default = []; };
          text = mkOption { type = types.lines; };
        }; 
      }); 
      default = {}; 
    };
    initConfig = mkOption { type = types.lines; default = ""; };
  };
  config = mkIf wrapCfg.enable {
    rum.programs.zsh.enable = true;
    rum.programs.zsh.initConfig = let
      enabled = filterAttrs (_: v: v.enable) wrapCfg.plugins;
      dagEntries = mapAttrs (name: p:
        if p.after != [] then dag.entryAfter p.after p.text
        else if p.before != [] then dag.entryBefore p.before p.text
        else dag.entryAnywhere p.text
      ) enabled;
    in concatStringsSep "\n" [ (dag.render { entries = dagEntries; }) wrapCfg.initConfig ];
  };
}
```

## Technical Notes
- `inputs` option accepts flake inputs dict passed from den aspect
- `dag = wrapCfg.inputs.dag.lib { inherit lib; }` — dag.lib is a function requiring `lib` parameter
- `dag.render { entries = dagEntries; }` requires named arguments and returns a string (not list)
- Plugin ordering via DAG: `entryAfter`, `entryBefore`, `entryAnywhere` functions from dag.lib

## Verification
1. [✓] Created `nix/hjem/zsh.nix` and implemented logic with inputs option
2. [✓] DAG-based plugin rendering correctly calls `dag.render { entries = ... }`
3. [✓] Module integrates with `rum.programs.zsh` config
