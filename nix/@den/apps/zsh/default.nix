{den, ...}: {
  den.aspects.zsh = {
    zsh = {pkgs, ...}: {
      plugins = {
        zsh-autosuggestions.source = "${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh";
        zsh-syntax-highlighting.source = "${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh";
        zsh-fzf-history-search.source = "${pkgs.zsh-fzf-history-search}/share/zsh-fzf-history-search/zsh-fzf-history-search.zsh";
      };

      initConfig = ''
        #
        ZSH="${pkgs.oh-my-zsh}/share/oh-my-zsh"
        plugins=(git)
        source "$ZSH/oh-my-zsh.sh"

        autoload -U compinit && compinit
        source "${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh"

        function zvm_config() {
          ZVM_LINE_INIT_MODE=n
          ZVM_VI_INSERT_ESCAPE_BINDKEY=jk
          ZVM_INSERT_MODE_CURSOR=be
          ZVM_NORMAL_MODE_CURSOR=bl
        }
        source "${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh"

        bindkey -M viins '^R' fzf_history_search

        HISTDUP=erase
        setopt appendhistory sharehistory hist_ignore_space hist_ignore_all_dups hist_save_no_dups hist_find_no_dups

        if [[ -n $SSH_CLIENT ]]; then
          PROMPT="%F{green}%n@%m%f %B%F{magenta}❯%f%b "
        else
          PROMPT="%B%F{magenta}❯%f%b "
        fi
      '';
    };
  };
}
