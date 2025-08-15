return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp", },
      {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
          library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            { path = "LazyVim",            words = { "LazyVim" } },
          },
        }
      },
    },
    opts = {
      servers = {
        zls = {},
        nushell = {},
        rust_analyzer = {},
        jsonls = {},
        marksman = {},
        bashls = { filetypes = { "sh", "zsh" } },
        dockerls = {
          settings = {
            docker = {
              languageserver = {
                formatter = {
                  ignoreMultilineInstructions = true,
                },
              },
            }
          }
        },
        lua_ls = {},
        ruff = {},
        pyright = {
          settings = {
            pyright = {
              disableOrganizeImports = true,
            },
            python = {
              analysis = {
                ignore = { '*' },
              },
            },
          },
        },
        angularls = {},
        eslint = {}
      },
    },
    config = function(_, opts)
      local lspconfig = require("lspconfig")
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        require("cmp_nvim_lsp").default_capabilities()
      )

      -- LSP servers setup configuration
      for server, config in pairs(opts.servers) do
        config.capabilities = capabilities
        lspconfig[server].setup(config)
      end
    end,
  },
}
