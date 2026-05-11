{
  den,
  ...
}:
{
  den.default.includes = [
    den._.mutual-provider
    den._.hostname
    den._.define-user
    den._.inputs'
  ]
  ++ (with den.aspects; [
    nix
    essentials
  ]);

  den.default.nixos = {
    system.stateVersion = "25.11";
  };
}
