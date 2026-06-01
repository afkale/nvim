require("mason").setup()
local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities = vim.tbl_deep_extend(
  "force", capabilities, require("mini.completion").get_lsp_capabilities()
)
vim.lsp.config("*", { capabilities = capabilities })
vim.diagnostic.config({ virtual_text = true })

vim.lsp.config(
  "lua_ls",
  { settings = { Lua = { diagnostics = { globals = { "vim" } }, } } }
)
vim.lsp.enable({ "lua_ls", "ruff", "pyright" })


-- KEYMAPS --
local kmopts = { noremap = true, silent = true }
vim.keymap.set("n", "gd", vim.lsp.buf.definition, kmopts)
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, kmopts)
vim.keymap.set("n", "gri", vim.lsp.buf.references, kmopts)
vim.keymap.set("n", "grn", vim.lsp.buf.rename, kmopts)
vim.keymap.set("n", "gra", vim.lsp.buf.code_action, kmopts)
vim.keymap.set("n", "gft", function()
  vim.g.autoformat = not vim.g.autoformat
  vim.notify(vim.g.autoformat and 'Formatting Active' or 'Formatting Disabled', vim.log.levels.INFO)
end)
vim.keymap.set("n", "gff", vim.lsp.buf.format, kmopts)
vim.keymap.set("n", "ge", vim.diagnostic.setqflist, kmopts)
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, kmopts)
vim.keymap.set("n", "fs", vim.lsp.buf.workspace_symbol, kmopts)
vim.keymap.set("n", "K", function() vim.lsp.buf.hover { border = "single" } end, kmopts)
vim.keymap.set("n", "E", function() vim.diagnostic.open_float { border = "single" } end, kmopts)
-- KEYMAPS --
