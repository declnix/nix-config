# @plugins
{ pkgs, ... }:
{
  programs.nvf.settings.vim = {
    extraPlugins = {
      fyler-nvim = {
        package = pkgs.vimPlugins.fyler-nvim;
        setup = ''
          require('fyler').setup {};
        '';
      };
    };

    "fzf-lua".enable = true;
  };
}
