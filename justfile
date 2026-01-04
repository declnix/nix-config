# Hostname from env or fallback
hostname := env_var_or_default('HOSTNAME', `hostname`)

# Detect impure mode from host file marker
# Looks for "@impure" in the corresponding host definition
impure_flag := if `grep -q '@impure' hosts/{{hostname}}.nix 2>/dev/null && echo true || echo false` == 'true' { '--impure' } else { '' }


# Color codes
BLUE := '\033[1;34m'
GREEN := '\033[1;32m'
RESET := '\033[0m'

# Default: list commands
[private]
@default:
    just --list

# Apply system configuration
@switch *ARGS: eval-macros
    just log "Applying NixOS configuration [host={{hostname}}]"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    just nixos-rebuild switch {{ARGS}}
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo
    just log "Configuration activated and running {{GREEN}}✓{{RESET}}"


# Build configuration
@build *ARGS: eval-macros
    just log "Building system configuration [host={{hostname}}]"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    just nixos-rebuild build {{ARGS}}
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo
    just log "Build complete → ./result {{GREEN}}✓{{RESET}}"


# helpers
[private]
@nixos-rebuild command *ARGS:
    sudo -E -H nixos-rebuild {{command}} --flake ".#{{hostname}}"  {{impure_flag}} {{ARGS}}


# Clean old generations
[private]
@clean:
    sudo nix-collect-garbage --delete-older-than 5d

# Format Nix files
[private]
@fmt:
    nixfmt **/*.nix

# Evaluate macros
[private]
@eval-macros:
    ./scripts/eval-macros.sh | xargs -r git add

# Logging
[private]
@log text:
    echo -e "{{BLUE}}▸{{RESET}} {{text}}"