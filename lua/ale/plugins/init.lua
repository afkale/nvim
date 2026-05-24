return {
  {
    'stevearc/quicker.nvim',
    ft = "qf",
    opts = {},
    config = function()
      local quicker = require("quicker")
      quicker.setup()

      vim.keymap.set("n", "<leader>cc", quicker.toggle, { desc = "Toggle quickfix" })
    end
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim", branch = "master" },
    },
    build = "make tiktoken",
    opts = {
    },
  },
}
