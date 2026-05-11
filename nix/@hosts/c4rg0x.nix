{ den, ... }:
{
  den.aspects.nixos.provides.c4rg0x =
    { ... }:
    {
      nixos = {
        users.users.nixos.initialPassword = "test";
      };

      includes = [
        den.batteries.primary-user
        (den.batteries.user-shell "zsh")
      ]
      ++ (with den.aspects; [
        dev-tools
        dev-ai
      ]);
    };

  den.hosts.x86_64-linux.c4rg0x.users.nixos = { };

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
