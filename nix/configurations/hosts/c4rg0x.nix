{ den, ... }:
{
  den.aspects.nixos.provides.c4rg0x =
    { ... }:
    {
      nixos = {
        users.users.declnix.initialPassword = "test";
      };

      includes = [
        den.batteries.primary-user
        (den.batteries.user-shell "zsh")
      ]
      ++ (with den.aspects; [
        development
        ai
      ]);
    };

  den.hosts.x86_64-linux.c4rg0x.users.declnix = { };

  den.aspects.c4rg0x =
    { host, ... }:
    {
      includes = with den.aspects; [
        wsl
        zscaler
      ];
    };

  den.hosts.x86_64-linux.c4rg0x = { };
}
