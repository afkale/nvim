vim.pack.add({
  { src = "https://github.com/rose-pine/neovim",                        name = "rose-pine" },
  { src = "https://github.com/nvim-lualine/lualine.nvim",               name = "lualine" },

  { src = "https://github.com/lewis6991/gitsigns.nvim",                 name = "gitsigns" },
  { src = "https://github.com/afkale/wswitcher.nvim",                   name = "wswitcher" },

  { src = "https://github.com/nvim-mini/mini.nvim",                     name = "mini.nvim" },

  { src = "https://github.com/stevearc/quicker.nvim",                   name = "quicker" },
  { src = "https://github.com/neovim/nvim-lspconfig",                   name = "nvim-lspconfig" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter",         name = "nvim-treesitter",        branch = "main" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter-context", name = "nvim-treesitter-context" },


  { src = "https://github.com/mfussenegger/nvim-dap",                   name = "nvim-dap" },
  { src = "https://github.com/mfussenegger/nvim-dap-python",            name = "nvim-dap-python" },
  { src = "https://github.com/igorlfs/nvim-dap-view",                   name = "nvim-dap-view" },
  { src = "https://github.com/mason-org/mason.nvim",                    name = "nvim-mason" },

  { src = "https://github.com/tpope/vim-fugitive",                      name = "vim-fungitive" },
})

require("ale.pack.theme")
require("ale.pack.git")
require("ale.pack.nav")
require("ale.pack.treesitter")
require("ale.pack.cmp")
require("ale.pack.lsp")
require("ale.pack.dap")
