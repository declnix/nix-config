{ den, ... }:
{
  den.aspects.bur34u = {
    provides.nixos = {
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
            lsp.enable = true;
            treesitter.enable = true;
          };

          java = {
            enable = true;
            lsp.enable = true;
            treesitter.enable = true;
            extensions.maven-nvim.enable = true;
          };
        };
      };

      # Environment setup for Java
      hjem = { pkgs, ... }: {
        environment.sessionVariables.JDTLS_JVM_ARGS =
          "-javaagent:${pkgs.lombok}/share/java/lombok.jar";
      };
    };
  };
}
