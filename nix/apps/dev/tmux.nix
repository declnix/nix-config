# @nix-config-modules
{ ... }:
{
  nix-config.apps.tmux = {
    home =
      { pkgs, ... }@inputs:
      {
        programs.tmux = {
          plugins = with pkgs.tmuxPlugins; [ battery ];

          extraConfig = ''
            # ==> configs
            setw -g mouse on
            setw -g mode-keys vi
            set -g status-left-style 'fg=white'
            set -g message-style 'fg=white bg=black bold'

            # statusbar
            #set -g status-position bottom
            #set -g status-justify left
            #set -g status-style 'fg=white'
            #set -g status-left '#[fg=orange bold] #S #[fg=white]:: '
            #set -g status-right '#[fg=gray bold] #(cat /sys/class/power_supply/BAT1/capacity)%% #[fg=white]:: #[fg=white bold]  %H:%M'
            #set -g status-right-length 50
            #set -g status-left-length 50
            #setw -g window-status-current-style 'fg=red  bold'
            #setw -g window-status-current-format '#W\#I'
            #setw -g window-status-style 'fg=colour241 bold'
            #setw -g window-status-format '#W\#I'
            #setw -g window-status-bell-style 'fg=colour2 bg=white bold'

            # custom keybindings
            bind -T root M-w choose-tree 

            set-option -g default-shell ${pkgs.zsh}/bin/zsh
            set -g default-terminal "tmux-256color"
            set -ga terminal-overrides ",xterm-256color:Tc"

            # ==> general
            ## status bar
            set -g base-index 1
            setw -g pane-base-index 1
            set-option -g status-position top
            set -g status on

            # ==> theme
            set -g status-bg "#161b22"
            set -g status-fg "#c9d1d9"
            set -g window-status-format '#[fg=#c9d1d9] #I:#W '
            set -g window-status-current-format '#[fg=#58a6ff] 󰻃 #I:#W '
            set -g status-left '#[fg=#ffdf5d]  #{=50:session_name}'
            set -g status-right '#[fg=green] #(cat /sys/class/power_supply/BAT1/capacity)%% #[fg=yellow]%H:%M'
            set -g pane-border-style fg="#313641"
            set -g pane-active-border-style fg="#58a6ff"
            set -g status-interval 5
            set -g status-justify centre
            set -g status-left-length 50
            set -g message-style fg="#c9d1d9",bg="#161b22"
          '';

          terminal = "tmux-256color";
          historyLimit = 100000;

          enable = true;
        };
      };

    tags = [
      "dev"
    ];
  };
}
