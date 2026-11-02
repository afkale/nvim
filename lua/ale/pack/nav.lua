require("mini.cmdline").setup()

local miniclue = require('mini.clue')
local files = require("mini.files")
local quicker = require("quicker")
local pick = require("mini.pick")

pick.setup({
  options = {
    -- Use faster tools when available
    tool = vim.fn.executable("fzf") == 1 and "fzf" or nil,
  },
})

quicker.setup()

files.setup({
  mappings = {
    close = "<ESC>",
    go_in = "<CR>",
    go_in_plus = "L",
    go_out = "_",
    go_out_plus = "H",
  },
  options = {
    -- Show hidden files by default
    permanently_show = { ".gitignore", ".env*", "*.yaml", "*.yml", "*.toml", "*.lua" },
    -- Don't show common ignored directories
    -- Hide these from the files view
    hide_dotfiles = false,
  },
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

-- File explorer
map("n", "<leader>e", function() files.open(vim.fn.expand('%:p:.')) end, "Toggle Mini files in path")
map("n", "<leader>E", files.open, "Toggle Mini files")

-- Quickfix
map("n", "<leader>cc", quicker.toggle, "Toggle quickfix")

-- File finding - smart: use fd if available, otherwise fallback to find
map("n", "<leader>ff", function()
  if vim.fn.executable("fd") == 1 then
    pick.builtin.cli({
      command = { "fd", "--type=f", "--hidden", "--color=never", "--no-ignore" },
    }, { source = { name = "Files (fd --hidden)" } })
  else
    pick.builtin.files()
  end
end, "Find files, including hidden paths")

-- Grep with rg if available
map("n", "<leader>fg", function()
  if vim.fn.executable("rg") == 1 then
    pick.builtin.grep_live()
  else
    pick.builtin.grep()
  end
end, "Live grep across project")

-- Text grep (non-live, shows results as you type)
map("n", "<leader>fG", function()
  if vim.fn.executable("rg") == 1 then
    pick.builtin.cli({
      command = { "rg", "--no-heading", "--line-number", "--column", "--smart-case" },
    }, { source = { name = "Grep (rg)" } })
  else
    pick.builtin.grep()
  end
end, "Grep text across project")

map("n", "<leader>fh", pick.builtin.help, "Find help tags")
map("n", "<leader>fr", pick.builtin.resume, "Resume last picker")
map("n", "<leader>fb", pick.builtin.buffers, "Find buffers")
map("n", "<leader>fm", function()
  pick.builtin.cli({
    command = { "find", vim.fn.expand("~/.config"), "-maxdepth", "3", "-type", "f" },
  }, { source = { name = "Config files" } })
end, "Find config files")
map("n", "<leader>fM", function()
  require("mini.pick").builtin.cli({
    command = { "find", vim.fn.stdpath("config"), "-maxdepth", "1", "-type", "f", "-o", "-type", "l" },
  }, { source = { name = "Neovim config" } })
end, "Find Neovim config files")
map("n", "<leader>f.", function()
  pick.builtin.cli({
    command = { "fd", "--type=f", "--hidden", "--color=never", "--no-ignore", "--strip-cwd-prefix" },
  }, { source = { name = "Files (fd --hidden --no-ignore)" } })
end, "Find all files, including gitignored")


