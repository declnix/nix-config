{
  den,
  ...
}:
{
  den.default.includes = [
    den.batteries.mutual-provider
    den.batteries.hostname
    den.batteries.define-user
    den.batteries.inputs'
  ]
  ++ (with den.aspects; [
    nix
    essentials
  ]);

  den.default.nixos = {
    system.stateVersion = "25.11";
  };
}
