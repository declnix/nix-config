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
      maps.normal = {
        "<C-p>" = {
          action = "<cmd>FzfLua files<CR>";
          desc = "Find files";
        };
        "<C-S-f>" = {
          action = "<cmd>FzfLua live_grep<CR>";
          desc = "Search in files";
        };
        "<C-b>" = {
          action = ":Neotree toggle<CR>";
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
