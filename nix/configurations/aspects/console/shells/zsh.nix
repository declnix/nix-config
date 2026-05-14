{
  lib,
  den,
  inputs,
  ...
}:
let
  zshForward =
    { user, host }:
    den.batteries.forward {
      each = lib.singleton user;
      fromClass = _: "zsh";
      intoClass = _: "hjem";
      intoPath = _: [
        "rum"
        "programs"
        "zsh"
      ];
      fromAspect = u: u.aspect;
      adaptArgs = args: { inherit (args) pkgs; };
    };
in
{
  den.aspects.zsh = {
    hjem =
      { pkgs, ... }:
      {
        rum.programs.zsh = {
          enable = true;

          plugins = {
            zsh-defer = {
              enable = true;
              text = "source ${pkgs.zsh-defer}/share/zsh-defer/zsh-defer.plugin.zsh";
            };

            zsh-autosuggestions = {
              enable = true;
              after = [ "zsh-defer" ];
              text = "source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh";
            };

            git-plugin = {
              enable = true;
              after = [ "zsh-autosuggestions" ];
              text = ''
                _git_plugin_setup() {
                  source ${pkgs.oh-my-zsh}/share/oh-my-zsh/lib/git.zsh
                  source ${pkgs.oh-my-zsh}/share/oh-my-zsh/plugins/git/git.plugin.zsh
                }
                zsh-defer _git_plugin_setup
              '';
            };

            zsh-syntax-highlighting = {
              enable = true;
              after = [ "zsh-autosuggestions" ];
              text = "zsh-defer source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh";
            };

            zsh-vi-mode = {
              enable = true;
              after = [ "zsh-autosuggestions" ];
              text = ''
                function zvm_config() {
                  ZVM_VI_INSERT_ESCAPE_BINDKEY=jk
                  ZVM_INSERT_MODE_CURSOR=be
                  ZVM_NORMAL_MODE_CURSOR=bl
                }
                source "${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh"
              '';
            };

            zsh-compinit = {
              enable = true;
              text = "autoload -U compinit && compinit";
            };

            zsh-fzf-tab = {
              enable = true;
              after = [ "zsh-compinit" ];
              text = "source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh";
            };

            zsh-fzf-history-search = {
              enable = true;
              after = [
                "zsh-fzf-tab"
                "zsh-vi-mode"
              ];
              text = ''
                source ${pkgs.zsh-fzf-history-search}/share/zsh-fzf-history-search/zsh-fzf-history-search.zsh
                bindkey -M viins '^R' fzf_history_search
              '';
            };

            history = {
              enable = true;
              before = [ "zsh-defer" ];
              text = ''
                HISTDUP=erase
                setopt appendhistory sharehistory hist_ignore_space hist_ignore_all_dups hist_save_no_dups hist_find_no_dups
              '';
            };

            prompt = {
              enable = true;
              after = [ "zsh-fzf-history-search" ];
              text = ''
                if [[ -n $SSH_CLIENT ]]; then
                  PROMPT="%F{green}%n@%m%f %B%F{magenta}❯%f%b "
                else
                  PROMPT="%B%F{magenta}❯%f%b "
                fi
              '';
            };
          };
        };
      };
  };

  den.schema.user.includes = [ zshForward ];
}
