{ den, ... }:
{
  den.aspects.development = {
    hjem =
      { pkgs, ... }:
      {
        packages = with pkgs; [
          ripgrep
          devbox
        ];

        rum = {
          programs = {
            direnv = {
              enable = true;
              integrations.zsh.enable = true;
            };
            git.enable = true;
          };
        };
      };

    includes = with den.aspects; [
      console
      editors
    ];
  };
}
