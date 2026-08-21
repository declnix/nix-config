{ den, ... }:
{
  den.aspects.c4rg0x = {
    provides.nixos-user = { user, ... }: {
      nixos = {
        users.users.${user.userName}.initialPassword = "test";
      };

      includes = [
        den.batteries.primary-user
        (den.batteries.user-shell "zsh")
      ]
      ++ [ den.aspects.development den.aspects.zscaler ];
    };
  };
}
