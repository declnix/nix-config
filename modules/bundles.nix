{ den, ... }:
{
  den.aspects.console = {
    includes = with den.aspects; [ bat eza fzf zoxide tmux zsh ];
  };

  den.aspects.development = {
    includes = with den.aspects; [ console direnv git ripgrep devbox nvim ];
  };

  den.aspects.remote-control = {
    includes = with den.aspects; [ tailscale ssh ];
  };
}
