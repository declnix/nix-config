{ den, ... }:
{

  den.aspects.nixos.provides.c4rg0x =
    { ... }:
    {
      nixos = {
        users.users.nixos.initialPassword = "test";
      };

      includes = [
        den._.primary-user
        (den._.user-shell "zsh")
      ]
      ++ (with den.aspects; [
        dev-tools
        dev-ai
      ]);
    };

  den.hosts.x86_64-linux.c4rg0x.users.nixos = { };
}
