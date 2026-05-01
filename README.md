# ❄️ My Nix Configuration

Welcome to my personal computing environment, managed entirely with Nix and [den](https://github.com/vic/den). This repository stores my system-wide settings, terminal workflows, and development environment, ensuring a consistent experience across all my machines.

### 🏠 The Design Philosophy
I designed this custom layout to optimize how my changes migrate and evolve across different machines. The structure reflects my specific workflow:

- **Configurations (`nix/@den/@configurations/`):** Host-specific setups (e.g., my home workstation vs. office machine).
- Aspects (`nix/@den/aspects/`): High-level, logical groupings that often compose multiple `programs` and settings (e.g., `dev-ai` or `essentials`) to define my workflow.
- Programs (`nix/@den/programs/`): Atomic, reusable configurations for specific tools (e.g., Neovim, tmux, zsh) that I share across multiple machines.
- Hjem (`nix/hjem/`): My custom `rum` module library. This is where I define reusable options, package configurations, and cross-program integrations (e.g., automatically setting up zsh aliases for tools like `bat`, `eza`, or `lazygit`).

This structure gives me the flexibility to keep my setup modular and maintainable while moving between different environments.

### 🚀 Common Commands
*If you are working with this repository, these are the commands I use most often:*

- **Apply current configuration:**
  ```bash
  just switch
  ```
- **Build current configuration (dry run):**
  ```bash
  just build
  ```
- **Format code:**
  ```bash
  just fmt
  ```
- **Cleanup old generations:**
  ```bash
  just cleanup
  ```

---
*Built with passion, managed with Nix.*
