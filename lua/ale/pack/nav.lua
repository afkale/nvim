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

local miniclue = require('mini.clue')
miniclue.setup({
  triggers = {
    { mode = { 'n', 'x' }, keys = '<Leader>' },
    { mode = 'n',          keys = '[' },
    { mode = 'n',          keys = ']' },
    { mode = 'i',          keys = '<C-x>' },
    { mode = { 'n', 'x' }, keys = 'g' },
    { mode = { 'n', 'x' }, keys = "'" },
    { mode = { 'n', 'x' }, keys = '`' },
    { mode = { 'n', 'x' }, keys = '"' },
    { mode = { 'i', 'c' }, keys = '<C-r>' },
    { mode = 'n',          keys = '<C-w>' },
    { mode = { 'n', 'x' }, keys = 'z' },
  },

  clues = {
    miniclue.gen_clues.square_brackets(),
    miniclue.gen_clues.builtin_completion(),
    miniclue.gen_clues.g(),
    miniclue.gen_clues.marks(),
    miniclue.gen_clues.registers(),
    miniclue.gen_clues.windows(),
    miniclue.gen_clues.z(),
  },
})
