{den, ...}: {
  den.aspects.nvim = {
    vim = {
      theme.enable = true;
      tabline.nvimBufferline.enable = true;
    };
  };
  flake-file.inputs.nvf.url = "github:notashelf/nvf";
}
