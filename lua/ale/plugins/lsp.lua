return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
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
        "zls",
        "ruff",
        "rust_analyzer",
        "jsonls",
        "marksman",
        "bashls",
        "dockerls",
        "lua_ls",
        "pyright",
        "angularls",
        "eslint"
      },
    },
    config = function(_, opts) vim.lsp.enable(opts.servers) end,
  },
}
