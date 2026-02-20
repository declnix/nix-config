set shell := ["bash", "-euo", "pipefail", "-c"]

_log level msg:
    @BLUE="\033[1;34m"; GREEN="\033[1;32m"; RED="\033[1;31m"; RESET="\033[0m"; \
    case "{{level}}" in \
        info) printf "${BLUE}%s${RESET}\n" "{{msg}}" ;; \
        ok)   printf "${GREEN}%s${RESET}\n" "{{msg}}" ;; \
        err)  printf "${RED}%s${RESET}\n" "{{msg}}" ;; \
    esac

@switch host="":
    h="{{host}}"; \
    h="${h:-$(hostname)}"; \
    width=60; \
    line=$(printf '%*s' "$width" '' | tr ' ' '='); \
    just _log info "$line"; \
    just _log info "→ switching configuration: $h"; \
    just _log info "$line"; \
    impure=$(nix eval --raw ".#nixosConfigurations.${h}.config._module.args.requiresImpure" 2>/dev/null || echo false); \
    sudo nixos-rebuild switch --flake ".#${h}" ${impure:+--impure} \
      && just _log ok "✔ success" \
      || just _log err "✘ failed"
