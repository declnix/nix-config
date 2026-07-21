set shell := ["bash", "-c"]
set quiet := true

host := `hostname`
machines_dir := "modules/config/+machines"

[no-exit-message]
_check_host host:
    @if [ ! -d "{{machines_dir}}/{{host}}" ]; then echo '¯\_(ツ)_/¯  Choose a host from {{machines_dir}}.'; exit 1; fi

# [build] Build configuration for host
[no-exit-message]
build host=host:
    @just _check_host "{{host}}" 2>/dev/null
    nixos-rebuild build --flake ".#{{host}}" --show-trace --accept-flake-config

# [switch] Apply configuration to host
[no-exit-message]
switch host=host:
    @just _check_host "{{host}}" 2>/dev/null
    @if [ -f "{{machines_dir}}/{{host}}/Makefile" ]; then make -C "{{machines_dir}}/{{host}}"; fi
    sudo nixos-rebuild switch --flake ".#{{host}}" --show-trace --accept-flake-config

# [boot] Schedule configuration for next boot
[no-exit-message]
boot host=host:
    @just _check_host "{{host}}" 2>/dev/null
    sudo nixos-rebuild boot --flake ".#{{host}}" --accept-flake-config

# [format] Format repository
format:
    nix fmt

# [check] Verify flake
check:
    nix flake check --show-trace --accept-flake-config

default:
    @just --list
