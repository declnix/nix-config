# Subplan: Migrate existing plugins

## Objective
Refactor and migrate Tmux plugins to the new `rum.programs.tmux.plugins` structure.

## Implementation Steps
1. Migrate hardcoded `run-shell` plugins from legacy locations.
2. Define dependencies for plugins.

## Snippet (Example)
```nix
rum.programs.tmux.plugins = {
  sensible = { enable = true; text = "run-shell ${pkgs.tmuxPlugins.sensible.rtp}"; };
  resurrect = { 
    enable = true; 
    after = ["sensible"]; 
    text = "run-shell ${pkgs.tmuxPlugins.resurrect.rtp}"; 
  };
  continuum = { 
    enable = true; 
    after = ["resurrect"]; 
    text = "run-shell ${pkgs.tmuxPlugins.continuum.rtp}"; 
  };
};
```

## Verification
1. Verify `tmux.conf` plugin loading order.
