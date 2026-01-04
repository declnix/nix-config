{ inputs, ... }:
final: prev:
let
  unstable = import inputs.nixpkgs-unstable { system = final.system; };
in
{
  vimPlugins = prev.vimPlugins // {
    fyler-nvim = unstable.vimPlugins.fyler-nvim;
  };
}
