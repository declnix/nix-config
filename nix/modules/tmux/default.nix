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
      intoPath = _: [ "tmux" ];
      fromAspect = u: u.aspect;
      adaptArgs = args: { inherit (args) pkgs; };
    };
in
{

  den.aspects.tmux = {
    tmux = { pkgs, ... }: {
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
            run-shell ${pkgs.tmuxPlugins.sensible.rtp}
            run-shell ${pkgs.tmuxPlugins.resurrect.rtp}
            run-shell ${pkgs.tmuxPlugins.continuum.rtp}
            '';
          };
        };

      inputs = { inherit (inputs) dag; };
    };
  };

  den.schema.user.includes = [ tmuxForward ];
  
  den.default.nixos.hjem.extraModules = lib.mkAfter [
    ./_hjem-module.nix
  ];
}
