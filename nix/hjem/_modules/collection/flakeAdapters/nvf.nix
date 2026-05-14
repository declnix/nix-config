{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
let
  nvfInput =
    inputs.nvf or (throw ''
      inputs.nvf is required in flake inputs.
      Add: inputs.nvf.url = "github:notashelf/nvf";
      Add to hjem.extraModules:
        {
          _module.args.inputs = inputs;
        }
    '');

  hmOptions =
    (nvfInput.homeManagerModules.default {
      inherit pkgs lib;
      config = { };
    }).options;
in
{
  options.nvf = hmOptions.programs.nvf.settings;

  config = {
    packages = [ config.nvf.vim.build.finalPackage ];
  };
}
