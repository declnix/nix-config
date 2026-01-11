{
  pkgs,
  inputs,
  lib,
  ...
}:

let
  zshModule = inputs.wrappers.lib.wrapModule (
    { config, ... }:
    {
      options = {
        aliases = lib.mkOption {
          type = lib.types.attrsOf lib.types.str;
          default = { };
          description = "Shell aliases";
        };

        initExtra = lib.mkOption {
          type = lib.types.lines;
          default = "";
          description = "Extra shell initialization";
        };

        plugins = lib.mkOption {
          type = lib.types.attrsOf (
            lib.types.submodule {
              options = {
                src = lib.mkOption { type = lib.types.package; };
                file = lib.mkOption {
                  type = lib.types.str;
                  default = "";
                };
              };
            }
          );
          default = { };
          description = "Zsh plugins";
        };

        historySize = lib.mkOption {
          type = lib.types.int;
          default = 10000;
        };
      };

      config = {
        package = config.pkgs.zsh;

        # Dodaj pluginy do PATH
        extraPackages = lib.mapAttrsToList (_: p: p.src) config.plugins;

        env.ZDOTDIR = "${config.pkgs.writeTextDir ".zshrc" ''
          # History
          HISTSIZE=${toString config.historySize}
          SAVEHIST=${toString config.historySize}
          HISTFILE=~/.zsh_history

          # Options
          setopt SHARE_HISTORY
          setopt HIST_IGNORE_DUPS
          setopt HIST_IGNORE_SPACE

          # Plugins
          ${lib.concatStringsSep "\n" (
            lib.mapAttrsToList (
              _: p:
              if p.file != "" then
                "source ${p.src}/${p.file}"
              else
                "source ${p.src}/share/zsh/site-functions/*.plugin.zsh 2>/dev/null || true"
            ) config.plugins
          )}

          # Aliases
          ${lib.concatStringsSep "\n" (lib.mapAttrsToList (k: v: "alias ${k}='${v}'") config.aliases)}

          # Extra config
          ${config.initExtra}

          # Local config (not managed by Nix)
          [[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
        ''}";
      };
    }
  );

  defaultWrapper = zshModule.apply {
    inherit pkgs;

    plugins = {
      syntax-highlighting = {
        src = pkgs.zsh-syntax-highlighting;
        file = "share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh";
      };
      autosuggestions = {
        src = pkgs.zsh-autosuggestions;
        file = "share/zsh-autosuggestions/zsh-autosuggestions.zsh";
      };
    };

    aliases = {
      cat = "bat";
      ls = "eza --icons";
      ll = "eza -la --icons";
      grep = "rg";
    };

    initExtra = ''
      # Prompt
      autoload -Uz vcs_info
      precmd() { vcs_info }
      setopt PROMPT_SUBST
      PROMPT='%F{green}%n@%m%f:%F{blue}%~%f ''${vcs_info_msg_0_} %# '

      # Key bindings
      bindkey '^[[A' history-search-backward
      bindkey '^[[B' history-search-forward
    '';
  };
in
defaultWrapper.wrapper
// {
  apply = cfg: (zshModule.apply (lib.recursiveUpdate { inherit pkgs; } cfg)).wrapper;
  meta.mainProgram = "zsh";
}
