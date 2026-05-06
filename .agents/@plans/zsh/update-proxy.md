# Subplan: Update host-specific Zsh proxy configuration

## Objective
Refactor host-specific proxy settings to integrate with the new Zsh module configuration.

## Implementation Steps
1. Update `nix/@den/@hosts/bur34u/proxy.nix`.
2. Change `provides.to-users.zsh` to use `rum.programs.zsh.initConfig`.

## Snippet
```nix
    provides.to-users = {
      zsh = {
        rum.programs.zsh.initConfig = ''
          if [ -f /run/nix-proxy.env ]; then
            ${sourceExported "/run/nix-proxy.env"}
          fi
        '';
      };
    };
```

## Verification
1. Verify environment variables are correctly exported in Zsh on the target host.
