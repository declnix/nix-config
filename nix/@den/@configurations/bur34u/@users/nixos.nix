{ den, ... }:
{
  den.aspects.bur34u = {
    provides.nixos = {
      vim = {
        languages.typescript = {
          enable = true;
          lsp.enable = true;
          lsp.servers = [ "angular-language-server" ];
          treesitter.enable = true;
        };
        languages.html = {
          enable = true;
          lsp.enable = true;
          lsp.servers = [ "angular-language-server" ];
          treesitter.enable = true;
        };
        languages.css = {
          enable = true;
          lsp.enable = true;
          treesitter.enable = true;
        };
        languages.java = {
          enable = true;
          lsp.enable = true;
          treesitter.enable = true;
          extensions.maven-nvim.enable = true;
        };
      };

      hjem =
        { pkgs, ... }:
        {
          environment.sessionVariables.JDTLS_JVM_ARGS = "-javaagent:${pkgs.lombok}/share/java/lombok.jar";
        };
    };
  };
}
