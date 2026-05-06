{ inputs, lib }:
{
  imports = [ ./zsh.nix ];
  _module.args.inputs = inputs;
}
