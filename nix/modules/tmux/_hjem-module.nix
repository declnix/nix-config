  {
        lib,
        config,
        pkgs,
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
        wrapCfg = config.tmux;
        dag = wrapCfg.inputs.dag.lib { inherit lib; };
      in
      {
        options.tmux = {
          enable = lib.mkEnableOption "tmux wrapper";
          inputs = mkOption {
            type = types.attrs;
            default = { };
            description = "Flake inputs passed from den aspect";
          };
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
          packages = [ pkgs.tmux ];
          files.".config/tmux/tmux.conf".text = (
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
              concatStringsSep "\n" [
                (dag.render { entries = dagEntries; })
                wrapCfg.initConfig
              ]
            );
        };
      }
