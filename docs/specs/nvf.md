# Spec: Implement custom Neovim (nvf) module and integration

## Goal
Replace the custom `den` aspect wrapper for `nvf` with a native `hjem` module (`nix/hjem/nvf.nix`). This module will wrap `nvf` configuration, allowing direct use of `rum.programs.nvf` while maintaining compatibility with the existing `nvf` module system.

## Detailed changes

### 1. Create `nix/hjem/nvf.nix`
*   **File:** `nix/hjem/nvf.nix` (new)
*   **Change:** Implement a module that wraps `nvf.lib.neovimConfiguration`.
*   **Snippet:**
```nix
{ lib, config, pkgs, inputs, ... }:
let
  cfg = config.rum.programs.nvf;
in {
  options.rum.programs.nvf = {
    enable = lib.mkEnableOption "nvf";
    settings = lib.mkOption { type = lib.types.anything; default = {}; };
  };

  config = lib.mkIf cfg.enable {
    packages = [
      (inputs.nvf.lib.neovimConfiguration {
        inherit pkgs;
        modules = [ cfg.settings ];
      }).neovim
    ];
  };
}
```

### 2. Update `nix/hjem/default.nix`
*   **File:** `nix/hjem/default.nix`
*   **Change:** Ensure `nvf.nix` is included in the aggregation.

### 3. Migrate configuration from `@den/apps/nvim`
*   **File:** `nix/@den/@hosts/bur34u/@users/nixos.nix`
*   **Change:** Shift configuration from `den.aspects.bur34u.provides.nixos.vim` to `rum.programs.nvf.settings`.
*   **Snippet:**
```nix
rum.programs.nvf = {
  enable = true;
  settings = {
    vim = {
      # ... original configuration migrated here
    };
  };
};
```

### 4. Cleanup
*   **Files:** Remove `nix/@den/apps/nvim/` and the associated logic in `den.nix`.
*   **Change:** Deprecate the complex `den.lib.nvim` parametric module system in favor of standard `nvf` module composition.

### 5. Verification
*   Verify that `nvf` is correctly built and available in the environment.
*   Ensure that language support (e.g., LSP, treesitter) and plugins are correctly loaded via `rum.programs.nvf.settings`.
