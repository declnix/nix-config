{
  den,
  lib,
  inputs,
  ...
}:
{
  den.lib.nvim.package =
    pkgs: vimAspect: ctx:
    (inputs.nvf.lib.neovimConfiguration {
      inherit pkgs;
      modules = [ (den.lib.nvim.module vimAspect ctx) ];
    }).neovim;

  den.lib.nvim.module =
    vimAspect: ctx:
    let
      vimClass =
        { class, aspect-chain }:
        den._.forward {
          each = lib.singleton true;
          fromClass = _: "vim";
          intoClass = _: "nvf";
          intoPath = _: [ "vim" ];
          fromAspect = _: lib.head aspect-chain;
          adaptArgs = lib.id;
        };

      aspect = den.lib.parametric.fixedTo ctx {
        includes = [
          vimClass
          vimAspect
        ];
      };
    in
    den.lib.aspects.resolve "nvf" aspect;

  den.aspects.nvim = {
    hjem =
      { pkgs, ... }:
      {
        packages = [ (den.lib.nvim.package pkgs den.aspects.nvim { }) ];
        environment.sessionVariables.EDITOR = "nvim";
      };

    vim = {
      theme.enable = true;
      lsp.enable = true;
      lsp.formatOnSave = true;

      languages.nix = {
        enable = true;
        format.enable = true;
        lsp.enable = true;
      };

      fzf-lua.enable = true;
      luaConfigPost = ''
        vim.api.nvim_create_autocmd("QuitPre", {
          callback = function()
            local wins = vim.tbl_filter(function(win)
              return vim.api.nvim_win_is_valid(win)
                and vim.api.nvim_win_get_config(win).relative == ""
                and vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "neo-tree"
            end, vim.api.nvim_list_wins())
            if #wins == 1 then
              vim.cmd("Neotree close")
            end
          end,
        })

        function _toggle_neotree()
          local cur = vim.api.nvim_get_current_win()
          local nt_open = false
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            if vim.api.nvim_win_is_valid(win) and vim.bo[vim.api.nvim_win_get_buf(win)].filetype == "neo-tree" then
              nt_open = true
              break
            end
          end
          if nt_open then
            vim.cmd("Neotree close")
            if vim.api.nvim_win_is_valid(cur) and vim.bo[vim.api.nvim_win_get_buf(cur)].filetype ~= "neo-tree" then
              vim.api.nvim_set_current_win(cur)
            end
          else
            vim.cmd("Neotree focus")
          end
        end
      '';
      maps.normal = {
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
        "<leader>e" = {
          action = "<cmd>lua _toggle_neotree()<CR>";
          desc = "Toggle file explorer";
        };
      };

      filetree.neo-tree = {
        enable = true;
        setupOpts = {
          enable_git_status = true;
          enable_diagnostics = true;
        };
      };

      visuals.nvim-web-devicons.enable = true;
      tabline.nvimBufferline.enable = true;
    };
  };

  flake-file.inputs.nvf.url = "github:notashelf/nvf";
}
