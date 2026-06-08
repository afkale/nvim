require("mini.cmdline").setup()
require("quicker").setup()

local files = require("mini.files")
local pick = require("mini.pick")
pick.setup()

files.setup({
  mappings = {
    close = "<ESC>",
    go_in = "<CR>",
    go_in_plus = "L",
    go_out = "_",
    go_out_plus = "H"
  }
})

vim.keymap.set("n", "<leader>e",
  function() files.open(vim.fn.expand('%:p:.')) end,
  { desc = "Toggle Mini files in path.", noremap = true, silent = true }
)

vim.keymap.set("n", "<leader>E",
  function() files.open() end,
  { desc = "Toggle Mini files", noremap = true, silent = true }
)
vim.keymap.set(
  "n", "<leader>cc", ":lua require('quicker').toggle()<CR>",
  { desc = "Toggle quickfix", noremap = true, silent = true }
)
vim.keymap.set("n", "<leader>ff", pick.builtin.files, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>fh", pick.builtin.help, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>fg", pick.builtin.grep_live, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>fr", pick.builtin.resume, { noremap = true, silent = true })
