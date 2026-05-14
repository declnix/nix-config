{ den, ... }:
{
  den.aspects.c4rg0x.provides.declnix =
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
      ]);
    };

  den.hosts.x86_64-linux.c4rg0x.users.declnix = { };
}
