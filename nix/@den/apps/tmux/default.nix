{ den, ... }:
{
  den.aspects.tmux = {
    tmux =
      { pkgs, ... }:
      {
        initConfig = ''
          set -g mouse on
          set -g base-index 1
          set -g status-style "bg=default"
          set -g status-justify "centre"
          set -g status-left ""
          set -g status-right ""
          set -g window-status-format "#[fg=gray] #I:#W "
          set -g window-status-current-format "#[fg=white,bold] #I:#W "
          run-shell ${pkgs.tmuxPlugins.sensible.rtp}
          run-shell ${pkgs.tmuxPlugins.resurrect.rtp}
          run-shell ${pkgs.tmuxPlugins.continuum.rtp}
        '';
      };
  };
}
