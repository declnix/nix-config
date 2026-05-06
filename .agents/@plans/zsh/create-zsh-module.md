# Subplan: Create nix/hjem/zsh.nix

## Objective
Implement the core Zsh module definition supporting plugin management (`dag` ordering) and `initConfig`.

## Implementation Steps
1. Create `nix/hjem/zsh.nix`.
2. Implement module options: `enable`, `plugins` (with `after`/`before` logic), and `initConfig`.
3. Implement `config` logic to render `dag` entries and `initConfig` into `.zshrc`.

## Snippet
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

## Verification
1. Ensure the module compiles within the nix environment.
