# apps/zsh.nix - bez meta
{ pkgs, inputs, ... }:
let
  wrappers = inputs.wrappers.lib;
  
  wrapped = wrappers.wrapPackage {
    inherit pkgs;
    package = pkgs.zsh;
    
    preHook = ''
      export ZDOTDIR=${pkgs.writeTextDir ".zshrc" ''
        PROMPT='%F{green}%n@%m%f %F{blue}%~%f %# '
        HISTFILE=~/.zsh_history
        HISTSIZE=10000
        SAVEHIST=10000
        alias ll='ls -lah'
        [ -f "$HOME/.zshrc" ] && source "$HOME/.zshrc"
      ''}
    '';
  };
in
{
  type = "app";
  program = "${wrapped}/bin/zsh";
}