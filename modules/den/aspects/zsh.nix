{ den, lib, ... }:
{
  den.aspects.zsh = {
    zsh = { lib, pkgs, ... }: {
      enable = true;

      initConfig = ''
        HISTFILE="''${ZDOTDIR:-$HOME}/.zsh_history"
        HISTSIZE=100000
        SAVEHIST=100000

        setopt append_history
        setopt extended_history
        setopt hist_ignore_dups
        setopt hist_ignore_space
        setopt hist_reduce_blanks
        setopt share_history

        autoload -Uz compinit
        compinit

        zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
        zstyle ':completion:*' menu select
        zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"

        ZSH_CACHE_DIR="''${ZSH_CACHE_DIR:-''${XDG_CACHE_HOME:-$HOME/.cache}/oh-my-zsh}"
        mkdir -p "$ZSH_CACHE_DIR/completions"

        source "${pkgs.oh-my-zsh}/share/oh-my-zsh/plugins/dirhistory/dirhistory.plugin.zsh"
        source "${pkgs.oh-my-zsh}/share/oh-my-zsh/plugins/colored-man-pages/colored-man-pages.plugin.zsh"
        source "${pkgs.oh-my-zsh}/share/oh-my-zsh/plugins/git/git.plugin.zsh"
        source "${pkgs.oh-my-zsh}/share/oh-my-zsh/plugins/docker/docker.plugin.zsh"
        source "${pkgs.oh-my-zsh}/share/oh-my-zsh/plugins/docker-compose/docker-compose.plugin.zsh"
        source "${pkgs.zsh-autoenv}/share/zsh-autoenv/autoenv.plugin.zsh"
        source "${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh"
        source "${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
        ${lib.getExe pkgs.fzf} --zsh | source /dev/stdin
        eval "$(${lib.getExe pkgs.zsh-patina} activate)"

        PROMPT="%B%F{magenta}#%f%b "
      '';
    };

    includes = [
      (den.batteries.unfree [ "zsh-autoenv" ])
    ];
  };

  den.schema.user.includes = [
    ({ user }:
      den.batteries.forward {
        each = lib.singleton user;
        fromClass = _: "zsh";
        intoClass = _: "hjem";
        intoPath = _: [ "rum" "programs" "zsh" ];
        fromAspect = u: u.aspect;
        adaptArgs = args: { inherit (args) pkgs; inherit lib; };
      })
  ];
}
