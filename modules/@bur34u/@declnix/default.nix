{
  inputs,
  den,
  bur34u_declnix,
  ...
}:
{
  den.aspects.bur34u.provides.declnix =
    { ... }:
    {
      vim = {
        # LSP server presets
        lsp.presets = {
          angular-language-server.enable = true;
          typescript-language-server.enable = true;
        };

        # TypeScript LSP configuration
        lsp.servers.typescript-language-server.filetypes = [
          "typescript"
          "typescriptreact"
          "javascript"
          "javascriptreact"
        ];

        # Language support
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

          java = {
            enable = true;
            lsp = {
              enable = true;
            };
            treesitter.enable = true;
          };
        };
      };

      hjem =
        { pkgs, ... }:
        {
          environment.sessionVariables.JDTLS_JVM_ARGS = "-javaagent:${pkgs.lombok}/share/java/lombok.jar";
        };

      nixos = {
        users.users.declnix.initialPassword = "test";
      };

      includes = [
        den.batteries.primary-user
        (den.batteries.user-shell "zsh")
      ]
      ++ (with den.aspects; [ development ]);
    };

  den.hosts.x86_64-linux.bur34u.users.declnix = { };
}
