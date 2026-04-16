@switch:
    sudo nixos-rebuild switch --flake .

@vm:
    nixos-rebuild build-vm --flake .#$(hostname)
    ./result/bin/run-$(hostname)-vm

@fmt:
    nixfmt $(find . -name '*.nix')

@flake: 
    nix run ".#write-flake"  
