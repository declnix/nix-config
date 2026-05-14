{
  lib,
  den,
  inputs,
  ...
}:
let
  tmuxForward =
    { host, user }:
    den.batteries.forward {
      each = lib.singleton user;
      fromClass = _: "tmux";
      intoClass = _: "hjem";
      intoPath = _: [
        "rum"
        "programs"
        "tmux"
      ];
      fromAspect = u: u.aspect;
      adaptArgs = args: { inherit (args) pkgs; };
    };
in
{

  den.aspects.tmux = {
    hjem =
      { ... }:
      {
        rum.programs.tmux = {
          enable = true;

          plugins = {
            initConfig = {
              enable = true;
              text = ''
                set -g mouse on
                set -g base-index 1
                set -g status-style "bg=default"
                set -g status-justify "centre"
                set -g status-left ""
                set -g status-right ""
                set -g window-status-format "#[fg=gray] #I:#W "
                set -g window-status-current-format "#[fg=white,bold] #I:#W "
              '';
            };
          };
        };
      };
  };

  den.schema.user.includes = [ tmuxForward ];
}
