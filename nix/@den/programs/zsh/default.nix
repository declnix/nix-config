{ den, ... }:
{
  den.aspects.zsh = {
    zsh = {
      oh-my-zsh.plugins = [ "git" ];
      zsh-autosuggestions.enable = true;
      zsh-syntax-highlighting.enable = true;
      zsh-fzf-history-search.enable = true;

      plugins.compinit = "autoload -Uz compinit && compinit";

      plugins.prompt = ''
        if [[ -n $SSH_CLIENT ]]; then
          PROMPT="%F{green}%n@%m%f %B%F{magenta}❯%f%b "
        else
          PROMPT="%B%F{magenta}❯%f%b "
        fi
      '';
    };
  };

  flake-file.inputs.nzf.url = "github:declnix/nzf";
}