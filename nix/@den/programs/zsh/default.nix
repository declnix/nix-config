{ den, ... }:
{
  den.aspects.zsh = {
    zsh = {
      enableCompletion = true;
      oh-my-zsh.plugins = [ "git" ];
      zsh-autosuggestions.enable = true;
      zsh-syntax-highlighting.enable = true;
      zsh-fzf-history-search.enable = true;
      zsh-fzf-tab.enable = true;

      history = {
        enable = true;
        ignoreAllDups = true;
      };

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
