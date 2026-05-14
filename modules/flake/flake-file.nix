{ lib, ... }:
{
  flake-file.inputs = {
    flake-file.url = lib.mkForce "github:denful/flake-file";
  };
}
