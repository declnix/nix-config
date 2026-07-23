set quiet := true

host := `hostname`
machines_dir := "modules/config/+machines"

[no-exit-message]
_check_host host:
    #!/usr/bin/env bash
    set -euo pipefail

    if [ ! -d "{{machines_dir}}/{{host}}" ]; then
        echo '¯\_(ツ)_/¯  Choose a host from {{machines_dir}}.'
        exit 1
    fi

# [build] Build configuration for host
[no-exit-message]
build host=host:
    #!/usr/bin/env bash
    set -euo pipefail

    just _check_host "{{host}}"

    nixos-rebuild build \
        --flake ".#{{host}}" \
        -L \
        --show-trace \
        --accept-flake-config

# [switch] Apply configuration to host
[no-exit-message]
switch host=host:
    #!/usr/bin/env bash
    set -euo pipefail

    just _check_host "{{host}}"

    host_dir="{{machines_dir}}/{{host}}"

    if [ -f "$host_dir/Justfile" ]; then
        just \
            --justfile "$host_dir/Justfile" \
            --working-directory "$host_dir"
    fi

    printf '\033[1;32m\uf444 switch \033[0;32m%s\033[0m\n' "{{host}}"
    printf '\033[0;32m------------------------\033[0m\n'

    nixos-rebuild switch \
        --flake ".#{{host}}" \
        --elevate=sudo \
        -L \
        --show-trace \
        --accept-flake-config

    printf '\n'

# [boot] Schedule configuration for next boot
[no-exit-message]
boot host=host:
    #!/usr/bin/env bash
    set -euo pipefail

    just _check_host "{{host}}"

    nixos-rebuild boot \
        --flake ".#{{host}}" \
        --elevate=sudo \
        -L \
        --accept-flake-config

# [format] Format repository
format:
    nix fmt

# [check] Verify flake
check:
    nix flake check --show-trace --accept-flake-config

default:
    just --list
