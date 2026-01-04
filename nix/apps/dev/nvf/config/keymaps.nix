# @plugins
{
  programs.nvf.settings.vim.keymaps = [
    # File explorer (fyler)
    {
      key = "<leader>e";
      mode = [ "n" ];
      action = ":Fyler kind=float<CR>";
    }
    # Fuzzy finder (fzf-lua)
    {
      key = "<leader>ff";
      mode = [ "n" ];
      action = ":FzfLua files<CR>";
    }
  ];
}
