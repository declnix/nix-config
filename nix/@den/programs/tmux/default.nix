{ den, ... }:
{
  den.aspects.tmux = {
    config.tmux.settings = {
      mouse = true;
      base-index = 1;
      status-style = "bg=default";
      status-justify = "centre";
      status-left = "";
      status-right = "";
      window-status-format = "#[fg=gray] #I:#W ";
      window-status-current-format = "#[fg=white,bold] #I:#W ";
    };

    hjem = { pkgs, ... }: {
      packages = [ pkgs.tmux ];
      files.".config/tmux/tmux.conf".text = den.lib.tmux.package pkgs den.aspects.tmux { };
    };
  };

  flake-file.inputs.ntf.url = "github:declnix/ntf";
}
