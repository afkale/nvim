-- utils.kmset the leader key to spac
vim.g.mapleader = " "

local opts = { noremap = true, silent = true }

-- Copy mappings using system clipboard
vim.keymap.set({ "v", "x" }, "<leader>y", '"+y', opts)   -- Copy selection to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], opts) -- Copy current line or selection
vim.keymap.set("n", "<leader>Y", [["+Y]], opts)          -- Copy entire line

-- Better J behavior
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines and keep cursor position" })

-- Move lines up/down
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Better indenting in visual mode
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

-- Window resizing shortcuts
vim.keymap.set("n", "<A-h>", ":vertical resize -2<CR>", opts) -- Decrease window width
vim.keymap.set("n", "<A-l>", ":vertical resize +2<CR>", opts) -- Increase window width
vim.keymap.set("n", "<A-j>", ":resize +2<CR>", opts)          -- Increase window height
vim.keymap.set("n", "<A-k>", ":resize -2<CR>", opts)          -- Decrease window height

-- Window navigation mappings
vim.keymap.set("n", "<C-h>", "<C-w>h", opts) -- Move left
vim.keymap.set("n", "<C-l>", "<C-w>l", opts) -- Move right
vim.keymap.set("n", "<C-j>", "<C-w>j", opts) -- Move down
vim.keymap.set("n", "<C-k>", "<C-w>k", opts) -- Move up

vim.keymap.set("t", "<C-\\><C-\\>", "<C-\\><C-n>", opts)

-- Quickfix
vim.keymap.set("n", "<leader>cc", ":copen<CR>")
vim.keymap.set("n", "<C-n>", ":cnext<CR>")
vim.keymap.set("n", "<C-p>", ":cprev<CR>")

-- Miscellaneous shortcuts
vim.keymap.set("v", "<C-s>", ":sort", opts) -- Sort lines visual

function _G.grep_operator(type)
  local saved_reg = vim.fn.getreg('"')
  local saved_regtype = vim.fn.getregtype('"')
  if type == 'char' or type == 'line' or type == 'block' then
    vim.cmd('normal! `[v`]y')
    local text = vim.fn.escape(vim.fn.getreg('"'), [[.,^$*[]\/~(){}|?+-":<>]])
    vim.cmd('silent grep!  "' .. text .. '"')
  end
  vim.fn.setreg('"', saved_reg, saved_regtype)
end

-- Operator-pending mapping for F
vim.keymap.set('n', '<leader>f', function()
  vim.o.operatorfunc = 'v:lua.grep_operator'
  return 'g@'
end, { expr = true, silent = true, desc = "Grep operator" })
