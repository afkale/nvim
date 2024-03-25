local cmp_nvim_lsp_status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
local mason_status_ok, mason = pcall(require, "mason")
local mason_lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
local mason_tool_installer_ok, mason_tool_installer = pcall(require, "mason-tool-installer")
local lsp_format_ok, lsp_format = pcall(require, "lsp-format")
local u = require("ale.functions.utils")

if not (mason_status_ok and mason_lspconfig_ok and cmp_nvim_lsp_status_ok and lsp_format_ok and mason_tool_installer_ok) then
	vim.api.nvim_err_writeln("Mason, Mason LSP Config, Completion, or LSP Format not installed!")
	return
end

mason.setup()


lsp_format.setup({
	order = {
		"tsserver",
		"eslint",
	},
})

-- This is the callback function that runs after LSP attaches which configures the LSP,
-- which sets the LSP settings like formatting and keymaps, etc.
local on_attach = function(client, bufnr)
	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	client.config.flags.debounce_text_changes = 200

	client.server_capabilities.documentFormattingProvider = true

	if u.has_value({ "eslint", "lua_ls", "pyright", "clangd" }, client.name) then
		lsp_format.on_attach(client)
	end

	-- Keymaps
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
	vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, {})
	vim.keymap.set("n", "gr", vim.lsp.buf.references, {})
	vim.keymap.set("n", "gs", function()
		vim.cmd.vsplit()
		vim.lsp.buf.definition()
	end, {})
	vim.keymap.set("n", "gv", function()
		vim.cmd.split()
		vim.lsp.buf.definition()
	end, {})
	vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help)
	vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, {})
	vim.keymap.set("n", "<leader>lq", vim.diagnostic.setqflist, {})
	vim.keymap.set("n", "<leader>li", vim.lsp.buf.implementation, {})
	vim.keymap.set("n", "<leader>lt", vim.lsp.buf.type_definition, {})
	vim.keymap.set("n", "<leader>lr", vim.lsp.buf.references, {})
	vim.keymap.set("n", "<leader>lc", vim.lsp.buf.incoming_calls, {})

	vim.keymap.set("n", "]W", function()
		vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
	end)

	vim.keymap.set("n", "[W", function()
		vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
	end)

	vim.keymap.set("n", "]w", function()
		vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARN })
	end)

	vim.keymap.set("n", "[w", function()
		vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.WARN })
	end)

	vim.keymap.set("n", "<leader>d", function()
		vim.diagnostic.setqflist({})
	end)
end

local servers = {
	"clangd",
	"pyright",
	"eslint-lsp",
	"lua-language-server",
	"vue-language-server",
	"typescript-language-server",
	--	"marksman",
	--	"tailwindcss",
}

local linters = {
	"pyflakes"
}

local debuggers = {}

local all = u.merge(servers, linters, debuggers)

-- Setup Mason + LSPs + CMP
require("ale.lsp.cmp")
mason_tool_installer.setup({
	ensure_installed = all,
	run_on_start = true,
	automatic_installation = true
})

-- Setup each server
local normal_capabilities = vim.lsp.protocol.make_client_capabilities()
local capabilities = cmp_nvim_lsp.default_capabilities(normal_capabilities)
for _, s in pairs(servers) do
	local server_config_ok, mod = pcall(require, "ale.lsp.servers." .. s)
	if not server_config_ok then
		require("notify")("The LSP '" .. s .. "' does not have a config.", "warn")
	else
		mod.setup(on_attach, capabilities)
	end
end

-- Global diagnostic settings
vim.diagnostic.config({
	virtual_text = true,
	severity_sort = true,
	update_in_insert = false,
	float = {
		header = "",
		source = true,
		border = "solid",
		focusable = true,
	},
})

-- Change Error Signs in Gutter
local signs = { Error = "✘", Warn = " ", Hint = "", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
