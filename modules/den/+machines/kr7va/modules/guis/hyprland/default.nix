{ inputs
, lib
, ...
}:
{
  den.aspects.kr7va = {
    provides.declnix = {
      hjem = { ... }: {
        files.".config/hypr".source = ./.;
      };

      nixos =
        { pkgs, ... }:
        let
          system = pkgs.stdenv.hostPlatform.system;
          hyprlandPackage = inputs.hyprland.packages.${system}.hyprland;
          portalPackage = inputs.hyprland.packages.${system}.xdg-desktop-portal-hyprland;
        in
        {
          programs.hyprland = {
            enable = true;
            package = hyprlandPackage;
            portalPackage = portalPackage;
            withUWSM = true;
          };

          nix.settings = {
            extra-substituters = lib.mkAfter [ "https://hyprland.cachix.org" ];
            extra-trusted-public-keys = lib.mkAfter [
              "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
            ];
          };

          services.greetd = {
            enable = true;
            settings.default_session = {
              command = "${lib.getExe pkgs.uwsm} start hyprland.desktop";
              user = "declnix";
            };
          };

          services.displayManager.defaultSession = lib.mkForce "hyprland-uwsm";

          environment.systemPackages = with pkgs; [
            alacritty
            xdg-utils
          ];

          security.polkit.enable = true;

          xdg.portal = {
            enable = true;
            extraPortals = lib.mkForce [ portalPackage ];
            config.common.default = lib.mkForce "hyprland";
          };
        };
    };
  };

  flake-file.nixConfig = {
    extra-substituters = lib.mkAfter [ "https://hyprland.cachix.org" ];
    extra-trusted-public-keys = lib.mkAfter [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };

  flake-file.inputs.hyprland.url = "github:hyprwm/Hyprland";
}
