{ den, inputs, ... }:
{
  den.aspects.declnix.provides.z4c1sz3 = {
    hjem = { pkgs, ... }: let
      network = inputs.astal.packages.${pkgs.system}.network;
      battery = inputs.astal.packages.${pkgs.system}.battery;
      ags = inputs.ags.packages.${pkgs.system}.default;
    agsWrapper = pkgs.writeShellScriptBin "ags" ''
  export GI_TYPELIB_PATH=${network}/lib/girepository-1.0:${battery}/lib/girepository-1.0:${pkgs.networkmanager}/lib/girepository-1.0''${GI_TYPELIB_PATH:+:$GI_TYPELIB_PATH}
  exec ${ags}/bin/ags "$@"
'';
    in {
      packages = [ agsWrapper ];
      files.".config/ags".source = ./.;
      rum.desktops.niri.spawn-at-startup = [
        [ "ags" "run" ]
      ];
    };
  };
  flake-file.inputs = {
    astal = {
      url = "github:aylur/astal";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ags = {
      url = "github:aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.astal.follows = "astal";
    };
  };
}