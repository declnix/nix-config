{ pkgs, inputs, lib, ... }:

let
  tmuxModule = inputs.wrappers.lib.wrapModule ({ config, ... }: {
    options = {
      prefix = lib.mkOption {
        type = lib.types.str;
        default = "C-b";
        description = "Tmux prefix key";
      };

      baseIndex = lib.mkOption {
        type = lib.types.int;
        default = 1;
        description = "Base index for windows and panes";
      };

      terminal = lib.mkOption {
        type = lib.types.str;
        default = "screen-256color";
        description = "Default terminal type";
      };

      mouse = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable mouse support";
      };

      escapeTime = lib.mkOption {
        type = lib.types.int;
        default = 0;
        description = "Time in milliseconds for escape key";
      };

      historyLimit = lib.mkOption {
        type = lib.types.int;
        default = 10000;
        description = "Scrollback buffer size";
      };

      plugins = lib.mkOption {
        type = lib.types.listOf lib.types.package;
        default = [ ];
        description = "Tmux plugins";
      };

      extraConfig = lib.mkOption {
        type = lib.types.lines;
        default = "";
        description = "Extra tmux configuration";
      };
    };

    config = let
      tmuxConf = config.pkgs.writeText "tmux.conf" ''
        # Prefix
        set -g prefix ${config.prefix}

        # Base index
        set -g base-index ${toString config.baseIndex}
        setw -g pane-base-index ${toString config.baseIndex}

        # Terminal
        set -g default-terminal "${config.terminal}"

        # Mouse
        set -g mouse ${if config.mouse then "on" else "off"}

        # Escape time
        set -sg escape-time ${toString config.escapeTime}

        # History
        set -g history-limit ${toString config.historyLimit}

        # Plugins
        ${lib.concatMapStringsSep "\n"
        (p: "run-shell ${p}/share/tmux-plugins/*/*.tmux") config.plugins}

        # Extra config
        ${config.extraConfig}

        # Local config (not managed by Nix)
        if-shell "[ -f ~/.tmux.conf.local ]" "source-file ~/.tmux.conf.local"
      '';
    in {
      package = config.pkgs.writeShellScriptBin "tmux" ''
        exec ${config.pkgs.tmux}/bin/tmux -f ${tmuxConf} "$@"
      '';

      extraPackages = config.plugins;
    };
  });

  # Default configuration
  defaultWrapper = tmuxModule.apply {
    inherit pkgs;

    prefix = "C-a";
    baseIndex = 1;
    mouse = true;
    escapeTime = 0;

    plugins = with pkgs.tmuxPlugins; [ sensible yank ];

    extraConfig = ''
      # Vi mode
      setw -g mode-keys vi

      # Split panes with | and -
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"

      # Vim-like pane navigation
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      # Resize panes
      bind -r H resize-pane -L 5
      bind -r J resize-pane -D 5
      bind -r K resize-pane -U 5
      bind -r L resize-pane -R 5

      # Reload local config
      bind r if-shell "[ -f ~/.tmux.conf.local ]" "source-file ~/.tmux.conf.local; display 'Local config reloaded!'" "display 'No local config found'"

      # Status bar
      set -g status-style bg=default,fg=white
      set -g status-left "#[fg=green]#S "
      set -g status-right "#[fg=yellow]%H:%M"
    '';
  };
in defaultWrapper.wrapper // {
  apply = cfg:
    (tmuxModule.apply (lib.recursiveUpdate { inherit pkgs; } cfg)).wrapper;
  meta.mainProgram = "tmux";
}
