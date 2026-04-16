{ ... }:
{
  den.aspects.tmux = {
    hjem =
      { pkgs, ... }:
      {
        tmux = {
          mouse = true;
          baseIndex = 1;
          extraConfig = ''
            set -g status-style bg=default
            set -g status-justify centre
            set -g status-left ""
            set -g status-right ""
            set -g window-status-format "#[fg=gray] #I:#W "
            set -g window-status-current-format "#[fg=white,bold] #I:#W "
          '';
        };
      };
  };
}
