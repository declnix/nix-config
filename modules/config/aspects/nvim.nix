{ den, lib, inputs, ... }:
{
  den.aspects.nvim = {
    nvim = { pkgs, ... }:
      lib.mkMerge [
        {
          # ui
          theme.enable = true;
          statusline.lualine.enable = true;
          visuals.nvim-web-devicons.enable = true;
          mini.icons.enable = true;

          diagnostics = {
            enable = true;
            config.signs.text = lib.generators.mkLuaInline ''
              {
                [vim.diagnostic.severity.ERROR] = "󰅚 ",
                [vim.diagnostic.severity.WARN] = "󰀪 ",
                [vim.diagnostic.severity.INFO] = "󰋽 ",
                [vim.diagnostic.severity.HINT] = "󰌶 ",
              }
            '';
          };

          luaConfigPost = ''
            vim.o.mouse = "a"
          '';
        }
        {
          # completion
          autocomplete.blink-cmp = {
            enable = true;
            setupOpts = {
              sources = {
                default = lib.mkBefore [ "filemention" ];
                providers.filemention = {
                  name = "filemention";
                  module = "filemention.sources.blink";
                  enabled = true;
                  should_show_items = lib.generators.mkLuaInline ''
                    function(_, items)
                      return require("filemention").enabled(0) and #items > 0
                    end
                  '';
                };
              };
              keymap = {
                "<Down>" = [ "select_next" "fallback" ];
                "<Up>" = [ "select_prev" "fallback" ];
              };
              cmdline.keymap = {
                "<Down>" = [ "select_next" "show" "fallback" ];
                "<Up>" = [ "select_prev" "fallback" ];
              };
            };
          };
        }
        {
          # lsp
          lsp = {
            enable = true;
            formatOnSave = false;
            lspconfig.enable = true;
            mappings.format = null;
          };
          languages.nix = {
            enable = true;
            format.enable = true;
            lsp.enable = true;
          };
          languages.markdown = {
            enable = true;
            extensions.render-markdown-nvim.enable = true;
            format = {
              enable = true;
              type = [ "mdformat" ];
            };
          };
          session.nvim-session-manager = {
            enable = true;
            setupOpts = {
              autoload_mode = "CurrentDir";
              autosave_last_session = true;
              autosave_only_in_session = false;
            };
          };
        }
        {
          # fzf-lua
          fzf-lua = {
            enable = true;
            setupOpts = {
              winopts = {
                width = 1.0;
                height = 1.0;
                row = 0.50;
                col = 0.50;
              };
              keymap = {
                fzf = {
                  "ctrl-y" = "transform-query(pbpaste)";
                  "alt-v" = "transform-query(pbpaste)";
                };
              };
            };
          };
          keymaps = [
            {
              key = "<leader>ff";
              mode = "n";
              action = "<cmd>FzfLua files<CR>";
              desc = "Find files";
            }
            {
              key = "<leader>fg";
              mode = "n";
              action = "<cmd>FzfLua live_grep<CR>";
              desc = "Search in files";
            }
            {
              key = "<leader>fk";
              mode = "n";
              action = "<cmd>FzfLua keymaps<CR>";
              desc = "Find keymaps";
            }
            {
              key = "<leader>fb";
              mode = "n";
              action = "<cmd>FzfLua buffers<CR>";
              desc = "Find buffers";
            }
            {
              key = "<C-.>";
              mode = "n";
              action = "<cmd>FzfLua lsp_code_actions<CR>";
              desc = "Code actions";
            }
          ];
        }
        {
          # VS Code-style editor keymaps
          keymaps = [
            {
              key = "<leader>bd";
              mode = "n";
              action = "<cmd>lua require('bufdelete').bufdelete(0, false)<CR>";
              desc = "Close buffer";
            }
            {
              key = "<F2>";
              mode = "n";
              action = "<cmd>lua vim.lsp.buf.rename()<CR>";
              desc = "Rename symbol";
            }
            {
              key = "<F12>";
              mode = "n";
              action = "<cmd>lua vim.lsp.buf.definition()<CR>";
              desc = "Go to definition";
            }
            {
              key = "<S-F12>";
              mode = "n";
              action = "<cmd>lua vim.lsp.buf.references()<CR>";
              desc = "Find references";
            }
            # FIXME: nvf maps lsp.mappings.format to vim.lsp.buf.format, but
            # language formatters such as markdown/mdformat are registered via conform.
            {
              key = "<leader>lf";
              mode = "n";
              action = "<cmd>lua require('conform').format({ lsp_format = 'fallback' })<CR>";
              desc = "Format";
            }
          ];
        }
        {
          # file mentions
          extraPlugins.filemention.package = pkgs.vimUtils.buildVimPlugin {
            pname = "filemention.nvim";
            version = "unstable";
            src = pkgs.fetchFromGitHub {
              owner = "not-manu";
              repo = "filemention.nvim";
              rev = "d8aa9116fa441d0529c53bb5cb2c321f30d9544d";
              hash = "sha256-XeLy1GlSSD3xg5KZWQKJH+riTdcN8e2iIpF7dbGl2MY=";
            };
          };

          luaConfigPost = ''
            require('filemention').setup({
              root = "cwd",
            })
          '';
        }
        {
          # indentation detection
          extraPlugins.guess-indent.package = pkgs.vimPlugins.guess-indent-nvim;

          luaConfigPost = ''
            require('guess-indent').setup({})
          '';
        }
        {
          # fyler
          extraPlugins.fyler.package = pkgs.vimPlugins.fyler-nvim;

          luaConfigPost = ''
            local function fyler_buffer_paths()
              local paths = {}
              local seen = {}

              for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
                local path = vim.api.nvim_buf_get_name(bufnr)

                if path ~= "" and vim.bo[bufnr].buflisted and vim.bo[bufnr].buftype == "" then
                  local normalized = vim.fs.normalize(path)

                  if not seen[normalized] then
                    seen[normalized] = true
                    table.insert(paths, normalized)
                  end
                end
              end

              table.sort(paths)

              return paths
            end

            vim.api.nvim_create_user_command("FylerBuffers", function()
              local fyler = require("fyler")
              local current = vim.api.nvim_buf_get_name(0)

              fyler.toggle({ dir = vim.uv.cwd() })

              vim.schedule(function()
                for _, path in ipairs(fyler_buffer_paths()) do
                  fyler.navigate(path)
                end

                fyler.navigate(current)
              end)
            end, {})

            require('fyler').setup({
              views = {
                finder = {
                  follow_current_file = true,
                  win = {
                    kind = "float",
                    kinds = {
                      float = {
                        width = "100%";
                        height = "100%";
                        top = "0%";
                        left = "0%";
                      },
                    },
                  },
                },
              },
            })
          '';

          keymaps = [
            {
              key = "<C-b>";
              mode = "n";
              action = "<cmd>FylerBuffers<CR>";
              desc = "Toggle file explorer";
            }
            {
              key = "<leader>e";
              mode = "n";
              action = "<cmd>FylerBuffers<CR>";
              desc = "Toggle file explorer";
            }
          ];
        }
      ];

    hjem = {
      environment.sessionVariables = {
        EDITOR = "nvim";
        VISUAL = "nvim";
        GIT_EDITOR = "nvim";
      };
    };

    nixos = {
      environment.sessionVariables = {
        EDITOR = "nvim";
        VISUAL = "nvim";
        GIT_EDITOR = "nvim";
      };
    };
  };

  den.schema.user.includes = [
    ({ user, ... }:
      den.batteries.forward {
        each = lib.singleton user;
        fromClass = _: "nvim";
        intoClass = _: "hjem";
        intoPath = _: [ "nvf" "vim" ];
        fromAspect = u: u.aspect;
        adaptArgs = args: { inherit (args) pkgs; };
      })
  ];

  den.default.nixos.hjem.extraModules = lib.mkAfter [
    ({ inputs, lib, config, pkgs, ... }:
      let
        nvfInput = inputs.nvf or (throw "inputs.nvf is required in flake inputs.");
      in
      {
        options.nvf = lib.mkOption {
          type = lib.types.deferredModule;
          default = { };
        };

        config = {
          packages = [
            (nvfInput.lib.neovimConfiguration {
              inherit pkgs;
              modules = [ config.nvf ];
            }).neovim
          ];
        };
      })
    {
      _module.args.inputs = { inherit (inputs) nvf; };
    }
  ];

  flake-file.inputs.nvf.url = "github:notashelf/nvf";
}
