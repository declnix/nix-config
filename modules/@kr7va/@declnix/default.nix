{
  inputs,
  den,
  kr7va_declnix,
  ...
}:
{
  imports = [ (inputs.den.namespace "kr7va_declnix" false) ];

  den.aspects.kr7va.provides.declnix = {
    hjem =
      { pkgs, ... }:
      {
        rum.programs.alacritty = {
          enable = true;
          settings.window.decorations = "None";
        };
        rum.programs.fuzzel.enable = true;
      };

    user = {
      initialPassword = "password";
    };

    includes =
      (with den.aspects; [
        development
      ])
      ++ (builtins.attrValues kr7va_declnix)
      ++ [
        den.batteries.primary-user
        (den.batteries.user-shell "zsh")
      ];
  };

  kr7va_declnix.packages = {
    hjem =
      { pkgs, ... }:
      {
        packages = with pkgs; [
          codex
          gemini-cli
          wget
          curl
          firefox
        ];
      };
  };

  kr7va_declnix.ssh = {
    nixos = {
      # TODO: to setup it based on current user create battery
      services.openssh.settings.AllowUsers = [ "declnix" ];
    };
  };

  den.hosts.x86_64-linux.kr7va.users.declnix = { };
}
