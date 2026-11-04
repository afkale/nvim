-- LSP servers we always want. mason-lspconfig installs any that are missing;
-- vim.lsp.enable also picks up the same servers when they come from the system
-- (rustup, go install, uv, ...) rather than Mason.
local servers = {
  "ty",        -- TypeScript type checker (ty) – no separate lsp/ty.lua config
  "ruff",
  "rust_analyzer",
  "jsonls",
  "marksman",
  "bashls",
  "dockerls",
  "lua_ls",
  "eslint",
  "gopls",
  "html",
  "cssls",
  "ts_ls",
  "yamlls",
}

require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = servers,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities = vim.tbl_deep_extend(
  "force", capabilities, require("mini.completion").get_lsp_capabilities()
)
vim.lsp.config("*", { capabilities = capabilities })
vim.diagnostic.config({ virtual_text = true })

-- Load per-server config overrides from the lsp/ directory.
-- Each file returns a table that gets merged into the config.
for _, name in ipairs(servers) do
  local ok, config = pcall(require, "lsp." .. name)
  if ok and type(config) == "table" and next(config) then
    vim.lsp.config(name, config)
  end
end

vim.lsp.enable(servers)


local map = require("ale.keys").map

map("n", "gd", vim.lsp.buf.definition, "Go to definition")
map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
map("n", "gri", vim.lsp.buf.references, "Find references")
map("n", "grn", vim.lsp.buf.rename, "Rename symbol")
map("n", "gra", vim.lsp.buf.code_action, "Code actions")
map("n", "gft", function()
  vim.g.autoformat = not vim.g.autoformat
  vim.notify(vim.g.autoformat and 'Formatting Active' or 'Formatting Disabled', vim.log.levels.INFO)
end, "Toggle auto-format")
map("n", "gff", vim.lsp.buf.format, "Format buffer")
map("n", "ge", vim.diagnostic.setqflist, "Send diagnostics to quickfix")
map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
map("n", "fs", vim.lsp.buf.workspace_symbol, "Search workspace symbols")
map("n", "K", function() vim.lsp.buf.hover { border = "single" } end, "Show hover info")
map("n", "E", function() vim.diagnostic.open_float { border = "single" } end, "Show diagnostic float")
