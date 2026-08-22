{ lib, ... }:
{
  den.aspects.gaia = {
    provides.nixos-user = {
      zsh = { pkgs, ... }: {
        initConfig =
          let
            ocCompletion = pkgs.runCommand "oc-zsh-completion" { } ''
              plugin_dir=$out/share/zsh/plugins/oc
              mkdir -p "$plugin_dir"
              ${pkgs.openshift}/bin/oc completion zsh > "$plugin_dir/oc.plugin.zsh"
            '';
          in
          lib.mkAfter ''
            source "${pkgs.oh-my-zsh}/share/oh-my-zsh/plugins/mvn/mvn.plugin.zsh"
            source "${pkgs.oh-my-zsh}/share/oh-my-zsh/plugins/npm/npm.plugin.zsh"
            source "${ocCompletion}/share/zsh/plugins/oc/oc.plugin.zsh"
          '';
      };

      hjem = { pkgs, ... }: {
        packages = [ pkgs.openshift ];
      };
    };
  };
}
