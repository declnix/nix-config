{
  inputs,
  den,
  kr7va_declnix,
  ...
}:
{
  den.aspects.kr7va.provides.declnix = {
    hjem =
      { pkgs, ... }:
      {
        rum.programs.alacritty = {
          enable = true;
          settings.window.decorations = "None";
        };
        rum.programs.fuzzel.enable = true;

        packages = with pkgs; [
          claude-code
          codex
          gemini-cli
          wget
          curl
          firefox
          gh
        ];
      };

    nixos = {
      services.openssh.settings.AllowUsers = [ "declnix" ];
    };

    user = {
      initialPassword = "password";
    };

    includes =
      (with den.aspects; [
        development
      ])
      ++ [
        den.batteries.primary-user
        (den.batteries.user-shell "zsh")
        (den.batteries.unfree [ "claude-code" ])
      ];
  };

  den.hosts.x86_64-linux.kr7va.users.declnix = { };
}
