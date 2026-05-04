{ den, ... }:
{
  den.aspects.tmux = {
    tmux = {
      mouse = true;
      base-index = 1;

      plugins = {
        sensible.enable = true;
        resurrect.enable = true;
        continuum.enable = true;
      };

      extraConfig = ''
        set -g status-style "bg=default"
        set -g status-justify "centre"
        set -g status-left ""
        set -g status-right ""
        set -g window-status-format "#[fg=gray] #I:#W "
        set -g window-status-current-format "#[fg=white,bold] #I:#W "
      '';
    };
  };
  flake-file.inputs.ntf.url = "github:declnix/ntf";
}
