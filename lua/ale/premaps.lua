local kmopts = { noremap = true, silent = true }

-- LSP Keymaps
vim.keymap.set("n", "gri", vim.lsp.buf.references, kmopts)
vim.keymap.set("n", "grn", vim.lsp.buf.rename, kmopts)
vim.keymap.set("n", "gra", vim.lsp.buf.code_action, kmopts)
vim.keymap.set("n", "gft", function()
  vim.g.autoformat = not vim.g.autoformat
  vim.notify(vim.g.autoformat and 'Formatting Active' or 'Formatting Disabled', vim.log.levels.INFO)
end)
vim.keymap.set("n", "gff", vim.lsp.buf.format, kmopts)
vim.keymap.set("n", "ge", vim.diagnostic.setqflist, kmopts)
vim.keymap.set("n", "gd", vim.lsp.buf.definition, kmopts)
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, kmopts)
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, kmopts)
vim.keymap.set("n", "fs", vim.lsp.buf.workspace_symbol, kmopts)
vim.keymap.set("n", "K", function() vim.lsp.buf.hover { border = "single" } end, kmopts)
vim.keymap.set("n", "E", function() vim.diagnostic.open_float { border = "single" } end, kmopts)

-- FZF Keymaps
local isPickLoaded, _ = pcall(require, "mini.pick")
if isPickLoaded then
  vim.keymap.set("n", "<leader><space>", ":Pick files tool='git'<CR>", kmopts)
  vim.keymap.set("n", "<leader>ff", ":Pick files<CR>", kmopts)
  vim.keymap.set("n", "<leader>fg", ":Pick grep_live<CR>", kmopts)
  vim.keymap.set("n", "<leader>fh", ":Pick help<CR>", kmopts)
  vim.keymap.set("n", "<leader>fr", ":Pick resume<CR>", kmopts)
end

-- OIL Keymaps
local isFilesLoaded, files = pcall(require, "mini.files")
if isFilesLoaded then
  vim.keymap.set("n", "<leader>e", files.open, { desc = "Toggle Mini files", noremap = true, silent = true })
end

-- HARPOON Keymaps
local isHarpoonLoaded, _ = pcall(require, "harpoon")
if isHarpoonLoaded then
  vim.keymap.set('n', '<leader>ma', ':lua require("harpoon.mark").add_file()<CR>', kmopts)
  vim.keymap.set('n', '<leader>mm', ':lua require("harpoon.ui").toggle_quick_menu()<CR>', kmopts)
  vim.keymap.set('n', '<leader>mp', ':lua require("harpoon.ui").nav_prev()<CR>', kmopts)
  vim.keymap.set('n', '<leader>mn', ':lua require("harpoon.ui").nav_next()<CR>', kmopts)
  vim.keymap.set('n', '<leader>1', ':lua require("harpoon.ui").nav_file(1)<CR>', kmopts)
  vim.keymap.set('n', '<leader>2', ':lua require("harpoon.ui").nav_file(2)<CR>', kmopts)
  vim.keymap.set('n', '<leader>3', ':lua require("harpoon.ui").nav_file(3)<CR>', kmopts)
  vim.keymap.set('n', '<leader>4', ':lua require("harpoon.ui").nav_file(4)<CR>', kmopts)
  vim.keymap.set('n', '<leader>5', ':lua require("harpoon.ui").nav_file(5)<CR>', kmopts)
  vim.keymap.set('n', '<leader>6', ':lua require("harpoon.ui").nav_file(6)<CR>', kmopts)
  vim.keymap.set('n', '<leader>7', ':lua require("harpoon.ui").nav_file(7)<CR>', kmopts)
  vim.keymap.set('n', '<leader>8', ':lua require("harpoon.ui").nav_file(8)<CR>', kmopts)
  vim.keymap.set('n', '<leader>9', ':lua require("harpoon.ui").nav_file(9)<CR>', kmopts)
end


-- QUICKER Keymaps
local isQuickerLoaded, quicker = pcall(require, "quicker")
if isQuickerLoaded then
  vim.keymap.set("n", "<leader>cc", quicker.toggle, { desc = "Toggle quickfix" })
end

-- VIMSPECTOR keymaps
vim.keymap.set("n", "<leader>dd", "<cmd>call vimspector#Launch()<CR>", kmopts)
vim.keymap.set("n", "<leader>dq", ":call vimspector#Reset()<CR>", kmopts)
vim.keymap.set("n", "<leader>dc", ":call vimspector#StepOut()<CR>", kmopts)
vim.keymap.set("n", "<leader>dn", ":call vimspector#StepOver()<CR>", kmopts)
vim.keymap.set("n", "<leader>di", ":call vimspector#StepInto()<CR>", kmopts)
vim.keymap.set("n", "<leader>db", ":call vimspector#ToggleBreakpoint()<CR>", kmopts)
vim.keymap.set("n", "<leader>dw", ":call vimspector#AddWatch()<CR>", kmopts)
vim.keymap.set("n", "<leader>de", ":call vimspector#Evaluate()<CR>", kmopts)
