{ den, ... }:
{
  den.aspects.dev-tools = {
    hjem =
      { pkgs, ... }:
      {
        packages = with pkgs; [
          ripgrep
          bat
          fzf
          zoxide
          direnv
          nix-direnv
          eza
        ];
        zsh.extraConfig = ''
          source ${pkgs.fzf}/share/fzf/key-bindings.zsh
          source ${pkgs.fzf}/share/fzf/completion.zsh
          eval "$(${pkgs.zoxide}/bin/zoxide init zsh)"
          eval "$(${pkgs.direnv}/bin/direnv hook zsh)"
          alias ls="${pkgs.eza}/bin/eza"
          alias ll="${pkgs.eza}/bin/eza -la"
          alias lt="${pkgs.eza}/bin/eza --tree"
        '';
      };

    includes = with den.aspects; [
      zsh
      tmux
      git
      nvim
    ];
  };
}
