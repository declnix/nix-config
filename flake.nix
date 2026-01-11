# =============================================================================
# # @declnix's nix config
#
# > ⚡ Personal NixOS configuration repo, powered by flakes.
#
# ## Overview
# Modular and reproducible NixOS setup.
# Structured with flakelight, extended via wrappers,
# and organized around hosts and apps.
#
# ## Usage
# ```sh
# sudo nixos-rebuild switch --flake .#<hostname>
# ```
#
# ## License
# MIT
# =============================================================================

{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Flakelight – structure, auto-discovery, conventions
    flakelight.url = "github:nix-community/flakelight";

    # Wrappers overlay (lassulus)
    wrappers.url = "github:lassulus/wrappers";
  };

  outputs = { flakelight, ... }@inputs: flakelight ./. { inherit inputs; };
}
