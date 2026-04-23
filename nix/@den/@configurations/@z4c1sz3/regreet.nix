{ den, ... }:
{
  den.aspects.z4c1sz3 =
    { ... }:
    {
      nixos =
        { pkgs, ... }:
        {
          programs.regreet = {
            enable = true;
            font = {
              package = pkgs.nerd-fonts.jetbrains-mono;
              name = "JetBrainsMono Nerd Font";
              size = 14;
            };
            extraCss = ''
              window {
                background-color: #000000;
              }

              box#main_box {
                background: transparent;
              }

              label {
                color: #cdd6f4;
              }

              entry {
                background: transparent;
                color: #cdd6f4;
                border: none;
                border-bottom: 1px solid #585b70;
                border-radius: 0;
                box-shadow: none;
                padding: 4px 0;
              }

              entry:focus {
                box-shadow: none;
              }

              button {
                background: transparent;
                color: transparent;
                border: none;
                border-radius: 0;
                box-shadow: none;
                padding: 0;
                min-height: 0;
              }
            '';
          };
        };
    };
}
