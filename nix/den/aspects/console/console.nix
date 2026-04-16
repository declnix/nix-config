{ den, ... }:
{
  den.aspects.console = {
    includes = with den.aspects; [
      zsh
      tmux
    ];
  };
}
