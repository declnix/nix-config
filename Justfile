# build and activate NixOS configuration
@switch host=`hostname`:
    sudo nixos-rebuild switch --flake ".#{{host}}"

# build NixOS configuration without activating
@build host=`hostname`:
    sudo nixos-rebuild build --flake ".#{{host}}"

# build and run a VM
@vm host=`hostname`:
    nixos-rebuild build-vm --flake ".#{{host}}"
    ./result/bin/run-{{host}}-vm

# format files
@fmt:
    nix fmt

# regenerate flake.nix
@flake:
    nix run ".#write-flake"
