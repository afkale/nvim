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
vim.keymap.set("n", "<leader>cc", ":lua require('quicker').toggle()<CR>", { desc = "Toggle quickfix" })
vim.keymap.set("n", "<leader>ff", pick.builtin.files, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>fh", pick.builtin.help, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>fg", pick.builtin.grep_live, { noremap = true, silent = true })

vim.keymap.set("n", "<leader>ma", ":lua require('harpoon.mark').add_file()<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>mm", ":lua require('harpoon.ui').toggle_quick_menu()<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>mp", ":lua require('harpoon.ui').nav_prev()<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>mn", ":lua require('harpoon.ui').nav_next()<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>1", ":lua require('harpoon.ui').nav_file(1)<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>2", ":lua require('harpoon.ui').nav_file(2)<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>3", ":lua require('harpoon.ui').nav_file(3)<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>4", ":lua require('harpoon.ui').nav_file(4)<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>5", ":lua require('harpoon.ui').nav_file(5)<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>6", ":lua require('harpoon.ui').nav_file(6)<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>7", ":lua require('harpoon.ui').nav_file(7)<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>8", ":lua require('harpoon.ui').nav_file(8)<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>9", ":lua require('harpoon.ui').nav_file(9)<CR>", { noremap = true, silent = true })
