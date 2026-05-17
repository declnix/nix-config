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
    type = lib.types.submoduleWith {
      modules = import "${zefInput}/modules/modules.nix";
      specialArgs = { inherit pkgs; };
    };
    default = { };
  };

  config = {
    packages = [
      config.flakeAdapters.zef.zsh.build.finalPackage
    ];
  };
}
