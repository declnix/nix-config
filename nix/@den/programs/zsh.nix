{ ... }:
{
  den.aspects.zsh = {
    hjem =
      { pkgs, ... }:
      {
        packages = with pkgs; [
          oh-my-zsh
          zsh-autosuggestions
          zsh-syntax-highlighting
          zsh-fzf-history-search
        ];
        rum.programs.zsh = {
          enable = true;
          initConfig = ''
            autoload -Uz compinit && compinit
            export ZSH="${pkgs.oh-my-zsh}/share/oh-my-zsh"
            ZSH_THEME=""
            plugins=(git)
            source $ZSH/oh-my-zsh.sh
            source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
            source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
            source ${pkgs.zsh-fzf-history-search}/share/zsh-fzf-history-search/zsh-fzf-history-search.plugin.zsh
            PROMPT="%B%F{magenta}❯%f%b "
          '';
        };
      };
  };
}
