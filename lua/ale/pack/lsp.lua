require("mason").setup()
local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities = vim.tbl_deep_extend(
  "force", capabilities, require("mini.completion").get_lsp_capabilities()
)
vim.lsp.config("*", { capabilities = capabilities })
vim.diagnostic.config({ virtual_text = true })

vim.lsp.enable({
  "ty",
  "ruff",
  "rust_analyzer",
  "jsonls",
  "marksman",
  "bashls",
  "dockerls",
  "lua_ls",
  "basedpyright",
  "eslint",
  "gopls",
  "html"
})


local map = require("ale.keys").map

map("n", "gd", vim.lsp.buf.definition, "Go to definition")
map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
map("n", "gri", vim.lsp.buf.references, "Find references")
map("n", "grn", vim.lsp.buf.rename, "Rename symbol")
map("n", "gra", vim.lsp.buf.code_action, "Code actions")
map("n", "gft", function()
  vim.g.autoformat = not vim.g.autoformat
  vim.notify(vim.g.autoformat and 'Formatting Active' or 'Formatting Disabled', vim.log.levels.INFO)
end, "Toggle auto-format on save")
map("n", "gff", vim.lsp.buf.format, "Format buffer")
map("n", "ge", vim.diagnostic.setqflist, "Send all diagnostics to quickfix")
map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
map("n", "fs", vim.lsp.buf.workspace_symbol, "Search workspace symbols")
map("n", "K", function() vim.lsp.buf.hover { border = "single" } end, "Show hover information")
map("n", "E", function() vim.diagnostic.open_float { border = "single" } end, "Show diagnostic details in float")
