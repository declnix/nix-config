{ ... }:
{
  den.aspects.bur34u = {
    provides.nixos-user = {
      zsh = { pkgs, ... }: {
        plugins = {
          omz-mvn = {
            load = "idle";
            package = pkgs.oh-my-zsh;
            source = "share/oh-my-zsh/plugins/mvn/mvn.plugin.zsh";
          };

          omz-npm = {
            load = "idle";
            package = pkgs.oh-my-zsh;
            source = "share/oh-my-zsh/plugins/npm/npm.plugin.zsh";
          };

          oc =
            let
              package = pkgs.runCommand "oc-zsh-completion" { } ''
                plugin_dir=$out/share/zsh/plugins/oc
                mkdir -p "$plugin_dir"
                ${pkgs.openshift}/bin/oc completion zsh > "$plugin_dir/oc.plugin.zsh"
              '';
            in
            {
              load = "idle";
              inherit package;
              source = "share/zsh/plugins/oc/oc.plugin.zsh";
            };
        };
      };

      hjem = { pkgs, ... }: {
        packages = [ pkgs.openshift ];
      };
    };
  };
}
