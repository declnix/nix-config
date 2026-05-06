# Subplan: Migrate existing plugins

## Objective
Refactor and migrate Zsh plugins to the new `rum.programs.zsh.plugins` structure with deferred loading.

## Implementation Steps
1. Move plugins from legacy locations to `rum.programs.zsh.plugins`.
2. Implement helper logic for conditional `zsh-defer` application.

## Snippet (Example)
```nix
rum.programs.zsh.plugins = {
  zsh-vi-mode = { enable = true; text = "source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh"; };
  zsh-fzf-history-search = { 
    enable = true; 
    after = ["zsh-defer" "zsh-vi-mode"]; 
    text = "zsh-defer source ${pkgs.zsh-fzf-history-search}/share/zsh-fzf-history-search/zsh-fzf-history-search.zsh"; 
  };
  # ... 
};
```

## Verification
1. Test plugin loading order and deferral.
