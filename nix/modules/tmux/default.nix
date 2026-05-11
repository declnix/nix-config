{
  lib,
  den,
  inputs,
  ...
}:
let
  tmuxForward =
    { host, user }:
    { class, aspect-chain }:
    den._.forward {
      each = lib.singleton true;
      fromClass = _: "tmux";
      intoClass = _: "hjem";
      intoPath = _: [ "tmux" ];
      fromAspect = _: lib.head aspect-chain;
      adapterModule = {
        options.initConfig = lib.mkOption {
          type = lib.types.lines;
          default = "";
        };
      };
    };
in
{

  den.aspects.tmux = {
    includes = [ tmuxForward ];

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
  
  den.default.nixos.hjem.extraModules = lib.mkAfter [
    ./_hjem-module.nix
  ];
}
