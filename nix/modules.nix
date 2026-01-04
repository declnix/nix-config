# @skip
{
  imports = [
    # @macro :: \
    #   grep -rl '@nix-config-modules' . \
    #   | xargs grep -L '@skip' \
    #   | sort
    ./apps/ai/claude-code.nix
    ./apps/ai/opencode.nix
    ./apps/dev/devbox.nix
    ./apps/dev/direnv.nix
    ./apps/dev/gh.nix
    ./apps/dev/git.nix
    ./apps/dev/nvf/nvf.nix
    ./apps/dev/nzf.nix
    ./apps/dev/tmux.nix
    ./apps/gui/ags.nix
    ./apps/gui/alacritty.nix
    ./apps/gui/kde.nix
    ./apps/gui/niri.nix
    ./apps/misc/fonts.nix
    ./apps/misc/host.nix
    ./apps/misc/sudo.nix
    ./apps/misc/wsl.nix
    ./apps/nix/nix-index.nix
    ./apps/utils/eza.nix
    ./apps/utils/fd.nix
    ./apps/utils/fzf.nix
    ./apps/utils/ripgrep.nix
    ./apps/utils/zoxide.nix
    ./apps/virt/podman.nix
    ./hosts/bl1ndsp0t/host.nix
    ./hosts/d34dsh1p/default.nix
    ./hosts/l4p0stv01d/default.nix
    # @end
  ];
}
