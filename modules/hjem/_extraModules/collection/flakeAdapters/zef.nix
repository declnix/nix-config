{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
let
  zefInput = inputs.zef or (throw "inputs.zef is required in flake inputs.");
in
{
  options.flakeAdapters.zef = lib.mkOption {
    type = lib.types.deferredModule;
    default = { };
  };

  config = {
    packages = [
      (zefInput.lib.zshConfiguration {
        inherit pkgs;
        modules = [ config.flakeAdapters.zef ];
      }).package
    ];
  };
}
