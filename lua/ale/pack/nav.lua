require("mini.cmdline").setup()

local miniclue = require('mini.clue')
local files = require("mini.files")
local quicker = require("quicker")
local pick = require("mini.pick")

pick.setup()
quicker.setup()
files.setup({
  mappings = {
    close = "<ESC>",
    go_in = "<CR>",
    go_in_plus = "L",
    go_out = "_",
    go_out_plus = "H"
  }
})
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

local map = require("ale.keys").map

map("n", "<leader>e", function() files.open(vim.fn.expand('%:p:.')) end, "Toggle Mini files in path.")
map("n", "<leader>E", files.open, "Toggle Mini files")
map("n", "<leader>cc", quicker.toggle, "Toggle quickfix")
map("n", "<leader>ff", pick.builtin.files, "Find files")
map("n", "<leader>fh", pick.builtin.help, "Find help tags")
map("n", "<leader>fg", pick.builtin.grep_live, "Live grep across project")
map("n", "<leader>fr", pick.builtin.resume, "Resume last picker")
