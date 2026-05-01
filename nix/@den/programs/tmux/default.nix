{ den, ... }:
{
  den.aspects.tmux = {
    tmux = {
      mouse = true;
      base-index = 1;
      status-style = "bg=default";
      status-justify = "centre";
      status-left = "";
      status-right = "";
      window-status-format = "#[fg=gray] #I:#W ";
      window-status-current-format = "#[fg=white,bold] #I:#W ";
    };
  };
  flake-file.inputs.ntf.url = "github:declnix/ntf";
}
