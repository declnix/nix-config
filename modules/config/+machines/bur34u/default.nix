{ den
, lib
, ...
}:
{
  den.aspects.bur34u = {
    provides.nixos-user = { user, ... }: {
      nvim = { pkgs, ... }: lib.mkMerge [
        {
          # frontend
          lsp.presets = {
            angular-language-server.enable = true;
            typescript-language-server.enable = true;
          };

          lsp.servers.typescript-language-server.filetypes = [
            "typescript"
            "typescriptreact"
            "javascript"
            "javascriptreact"
          ];

          languages = {
            typescript = {
              enable = true;
              lsp = {
                enable = true;
                servers = [ "angular-language-server" ];
              };
              treesitter.enable = true;
            };

            html = {
              enable = true;
              lsp = {
                enable = true;
                servers = [ "angular-language-server" ];
              };
              treesitter.enable = true;
            };

            css = {
              enable = true;
              lsp = {
                enable = true;
              };
              treesitter.enable = true;
            };
          };
        }
        {
          # backend
          lsp.servers.jdt-language-server.cmd = lib.mkForce (lib.generators.mkLuaInline ''
            (function()
              local root = vim.fs.root(0, {
                '.git',
                'build.gradle',
                'build.gradle.kts',
                'build.xml',
                'pom.xml',
                'settings.gradle',
                'settings.gradle.kts',
              }) or vim.fn.getcwd()
              local name = vim.fn.fnamemodify(root, ':t')
              local workspace = name .. '-' .. string.sub(vim.fn.sha256(root), 1, 12)
              return {
                '${lib.getExe pkgs.jdt-language-server}',
                '-configuration',
                vim.fn.stdpath('cache') .. '/jdtls/config',
                '-data',
                vim.fn.stdpath('cache') .. '/jdtls/workspace/' .. workspace,
                unpack(vim.tbl_map(function(arg)
                  return '--jvm-arg=' .. arg
                end, vim.split(os.getenv('JDTLS_JVM_ARGS') or "", '%s+', { trimempty = true }))),
              }
            end)()
          '');

          languages = {
            java = {
              enable = true;
              lsp = {
                enable = true;
              };
              treesitter.enable = true;
            };

            kotlin = {
              enable = true;
              lsp = {
                enable = true;
              };
              treesitter.enable = true;
            };
          };
        }
      ];

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
        environment.sessionVariables.JDTLS_JVM_ARGS = "-javaagent:${pkgs.lombok}/share/java/lombok.jar";

        packages = [ pkgs.openshift ];
      };

      nixos = {
        users.users.${user.userName}.initialPassword = "test";
      };

      includes = [
        den.batteries.primary-user
        (den.batteries.user-shell "zsh")
      ]
      ++ [ den.aspects.development ];
    };

    nixos = {
      # Reserve ports for local development services.
      boot.kernel.sysctl."net.ipv4.ip_local_reserved_ports" = "61000-64999";
    };

    includes = with den.aspects; [ podman fonts ];
  };

  den.hosts.x86_64-linux.bur34u = {
    wsl.enable = true;
    users.nixos-user.userName = "nixos";
  };
}
