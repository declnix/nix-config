# @nix-config-modules
{ inputs, lib, ... }:
{
  nix-config.apps.nzf = {
    home =
      { pkgs, lib, ... }:
      {
        programs.nzf = {
          plugins = with pkgs; {
            zsh-fzf-tab = rec {
              config = ''
                source ${zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh
              '';

              defer = true;

              extraPackages = [ fzf ];
            };

            zsh-fzf-history-search = {
              config = ''
                source ${zsh-fzf-history-search}/share/zsh-fzf-history-search/zsh-fzf-history-search.plugin.zsh
              '';

              defer = true;
              after = [ "zsh-vi-mode" ];

              extraPackages = [ fzf ];
            };

            zsh-f-sy-h = rec {
              config = ''
                source ${zsh-f-sy-h}/share/zsh/site-functions/F-Sy-H.plugin.zsh
              '';
            };

            zsh-vi-mode = rec {
              config = ''
                source ${zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
              '';
            };

            git = rec {
              config = ''
                source ${oh-my-zsh}/share/oh-my-zsh/plugins/git/git.plugin.zsh
              '';
            };

            robbyrussell = rec {
              config = ''
                autoload -Uz colors && colors
                setopt PROMPT_SUBST
                source ${oh-my-zsh}/share/oh-my-zsh/lib/git.zsh
                source ${oh-my-zsh}/share/oh-my-zsh/lib/async_prompt.zsh
                source ${oh-my-zsh}/share/oh-my-zsh/themes/robbyrussell.zsh-theme
              '';

              after = [ "zsh-f-sy-h" ];
            };
          };
          enable = true;
        };

        programs.zsh = {
          initContent = ''
            [[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
          '';

          shellAliases = {
            cat = "bat";
          };
          enable = true;
        };

        programs.fzf = {
          enable = true;
        };

        programs.eza = {
          enableZshIntegration = true;
          enable = true;
        };

        programs.bat = {
          enable = true;
        };
      };

    tags = [ "dev" ];
  };

  nix-config.modules.home-manager = [
    inputs.nzf.homeModules.default
  ];
}
