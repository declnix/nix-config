{
  lib,
  den,
  inputs,
  ...
}:
{
  den.aspects.zsh = {
    zsh = { pkgs, ... }: {
      initConfig = ''
        # Plugins
        zsh-defer source ${pkgs.zsh-defer}/share/zsh-defer/zsh-defer.plugin.zsh
        source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
        source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
        source "${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh"
        source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh
        
        function zvm_config() {
          ZVM_VI_INSERT_ESCAPE_BINDKEY=jk
          ZVM_INSERT_MODE_CURSOR=be
          ZVM_NORMAL_MODE_CURSOR=bl
        }
      '';

      history = {
        size = 50000;
        save = 50000;
      };
      
      setopt = [
        "APPEND_HISTORY"
        "HIST_IGNORE_SPACE"
        "HIST_IGNORE_ALL_DUPS"
        "HIST_SAVE_NO_DUPS"
        "HIST_FIND_NO_DUPS"
      ];
    };
  };

  flake-file.inputs.zef.url = "github:declnix/zef";
}
