{
  lib,
  den,
  inputs,
  ...
}:
{
  den.aspects.nvim = {
    vim = {
      theme.enable = true;
      tabline.nvimBufferline.enable = true;
      visuals.nvim-web-devicons.enable = true;
      mini.icons.enable = true;
      autocomplete.blink-cmp.enable = true;
      lsp = {
        enable = true;
        formatOnSave = true;
        lspconfig.enable = true;
      };
    };
  };

  den.default.nixos.hjem.extraModules = lib.mkAfter [
    ./_hjem-module.nix
  ];

  flake-file.inputs.nvf.url = "github:notashelf/nvf";
}
