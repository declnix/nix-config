{...}: {
  den.aspects.nvim = {
    vim = {...}: {
      fzf-lua.enable = true;
      maps = {
        normal = {
          "<leader>ff" = {
            action = "<cmd>FzfLua files<CR>";
            desc = "Find files";
          };
          "<leader>fg" = {
            action = "<cmd>FzfLua live_grep<CR>";
            desc = "Search in files";
          };
          "<leader>fk" = {
            action = "<cmd>FzfLua keymaps<CR>";
            desc = "Find keymaps";
          };
        };
      };
    };
  };
}
