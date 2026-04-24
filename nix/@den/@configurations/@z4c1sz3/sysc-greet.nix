{ den, inputs, ... }:
{
  den.aspects.z4c1sz3 =
    { host, ... }:
    {
      nixos =
        { ... }:
        {
          imports = [ inputs.sysc-greet.nixosModules.default ];
          services.sysc-greet = {
            enable = true;
            compositor = "niri";
          };
        };
    };

  flake-file.inputs.sysc-greet = {
    url = "github:Nomadcxx/sysc-greet";
    inputs.nixpkgs.follows = "nixpkgs";
  };
}
