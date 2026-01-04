# @plugins
{
  programs.nvf.settings.vim = {
    tabline.nvimBufferline.enable = true;

    theme = {
      enable = true;
      name = "tokyonight";
      style = "night";
      transparent = false;
    };

    statusline.lualine = {
      enable = true;
      theme = "tokyonight";
    };

    mini.icons.enable = true;
  };
}
