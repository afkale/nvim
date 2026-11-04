require("mini.cmdline").setup()

local miniclue = require('mini.clue')
local files = require("mini.files")
local quicker = require("quicker")
local pick = require("mini.pick")
local has = require("ale.util")

pick.setup({
  options = {
    -- Use faster tools when available
    tool = has.has_fzf and "fzf" or nil,
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

-- Helper to reduce repetition in pick.builtin.cli() calls.
local function pick_cli(command, name)
  pick.builtin.cli({ command = command }, { source = { name = name } })
end

-- File explorer
map("n", "<leader>e", function() files.open(vim.fn.expand('%:p:.')) end, "Open file browser in path")
map("n", "<leader>E", files.open, "Open file browser")

-- Quickfix (leader-c group, consolidated here alongside quicker.nvim)
map("n", "<leader>cc", quicker.toggle, "Toggle quickfix")
map("n", "<leader>cn", ":cnext<CR>", "Next quickfix item")
map("n", "<leader>cp", ":cprev<CR>", "Previous quickfix item")
map("n", "<leader>co", ":copen<CR>", "Open quickfix window")
map("n", "<leader>cq", ":cclose<CR>", "Close quickfix window")

-- File finding - smart: use fd if available, otherwise fallback to find
map("n", "<leader>ff", function()
  if has.has_fd then
    pick_cli({ "fd", "--type=f", "--hidden", "--color=never", "--no-ignore" }, "Files (fd --hidden)")
  else
    pick.builtin.files()
  end
end, "Find files (hidden included)")

-- Grep with rg if available
map("n", "<leader>fg", function()
  if has.has_rg then
    pick.builtin.grep_live()
  else
    pick.builtin.grep()
  end
end, "Live grep across project")

-- Text grep (non-live, shows results as you type)
map("n", "<leader>fG", function()
  if has.has_rg then
    pick_cli({ "rg", "--no-heading", "--line-number", "--column", "--smart-case" }, "Grep (rg)")
  else
    pick.builtin.grep()
  end
end, "Grep text across project")

map("n", "<leader>fh", pick.builtin.help, "Find help tags")
map("n", "<leader>fr", pick.builtin.resume, "Resume last picker")
map("n", "<leader>fb", pick.builtin.buffers, "Find buffers")
map("n", "<leader>fm", function()
  pick_cli({ "find", vim.fn.expand("~/.config"), "-maxdepth", "3", "-type", "f" }, "Config files")
end, "Find config files")
map("n", "<leader>fM", function()
  pick_cli({ "find", vim.fn.stdpath("config"), "-maxdepth", "1", "-type", "f", "-o", "-type", "l" }, "Neovim config")
end, "Find neovim config files")
map("n", "<leader>f.", function()
  pick_cli({ "fd", "--type=f", "--hidden", "--color=never", "--no-ignore", "--strip-cwd-prefix" }, "Files (fd --hidden --no-ignore)")
end, "Find all files (including gitignored)")


