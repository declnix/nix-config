{
  lib,
  config,
  inputs,
  ...
}:
let
  inherit (lib)
    mkOption
    types
    concatStringsSep
    mapAttrs
    filterAttrs
    mkIf
    ;
  dag = inputs.dag.lib;
  wrapCfg = config.rum.wrappered.zsh;
in
{
  options.rum.wrappered.zsh = {
    enable = lib.mkEnableOption "zsh wrapper with dag-based plugin management";
    plugins = mkOption {
      type = types.attrsOf (
        types.submodule {
          options = {
            enable = lib.mkEnableOption "plugin";
            after = mkOption {
              type = types.listOf types.str;
              default = [ ];
            };
            before = mkOption {
              type = types.listOf types.str;
              default = [ ];
            };
            text = mkOption { type = types.lines; };
          };
        }
      );
      default = { };
    };
    initConfig = mkOption {
      type = types.lines;
      default = "";
    };
  };

  config = mkIf wrapCfg.enable {
    rum.programs.zsh.enable = true;
    rum.programs.zsh.initConfig =
      let
        enabled = filterAttrs (_: v: v.enable) wrapCfg.plugins;
        dagEntries = mapAttrs (
          name: p:
          if p.after != [ ] then
            dag.entryAfter p.after p.text
          else if p.before != [ ] then
            dag.entryBefore p.before p.text
          else
            dag.entryAnywhere p.text
        ) enabled;
      in
      concatStringsSep "\n" (dag.render dagEntries ++ [ wrapCfg.initConfig ]);
  };
}
