{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
let
  tmfInput = inputs.tmf or (throw "inputs.tmf is required in flake inputs.");
in
{
  options.flakeAdapters.tmf = lib.mkOption {
    type = lib.types.deferredModule;
    default = { };
  };

  config = {
    packages = [
      (tmfInput.lib.tmuxConfiguration {
        inherit pkgs;
        modules = [ config.flakeAdapters.tmf ];
      }).package
    ];
  };
}
