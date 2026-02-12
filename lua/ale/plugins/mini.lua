return {
  {
    "nvim-mini/mini.completion",
    version = "*",
    config = function()
      require("mini.icons").tweak_lsp_kind()
      require("mini.completion").setup()
    end
  },
  {
    'nvim-mini/mini.files',
    dependencies = { 'nvim-mini/mini.icons' },
    config = function()
      local files = require("mini.files")
      require('mini.icons').setup()

      files.setup({ mappings = { close = '<ESC>' } })

      vim.keymap.set("n", "<leader>e",
        function() files.open(vim.fn.expand('%:p:.')) end,
        { desc = "Toggle Mini files in path.", noremap = true, silent = true }
      )

      vim.keymap.set("n", "<leader>E",
        function() files.open() end,
        { desc = "Toggle Mini files", noremap = true, silent = true }
      )
    end
  },
}
