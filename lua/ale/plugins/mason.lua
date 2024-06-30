return {
	{
		"williamboman/mason.nvim",
		dependencies = {
			{ "williamboman/mason-lspconfig.nvim" },
			{ "neovim/nvim-lspconfig" },
		},
		config = function()
			require("mason").setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})

			local lspconfig = require("lspconfig")
			local capabilities =
				require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				on_init = function(client)
					local path = client.workspace_folders[1].name
					if vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc") then
						return
					end

					client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
						runtime = {
							version = "LuaJIT",
						},
						workspace = {
							checkThirdParty = false,
							library = {
								vim.env.VIMRUNTIME,
							},
						},
					})
				end,
				settings = {
					Lua = {},
				},
			})

			lspconfig.pyright.setup({})
			lspconfig.tsserver.setup({
				init_options = {
					plugins = {
						{
							name = "@vue/typescript-plugin",
							location = "/usr/lib/node_modules/@vue/language-server/node_modules/@vue/typescript-plugin",
							languages = { "javascript", "typescript", "vue" },
						},
					},
				},
				filetypes = {
					"javascript",
					"typescript",
					"vue",
				},
			})

			-- LSP CMDS
			local opts = { noremap = true, silent = true }

			vim.keymap.set("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
			vim.keymap.set("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
			vim.keymap.set("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
			vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
			vim.keymap.set("n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
			vim.keymap.set("n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
			vim.keymap.set(
				"n",
				"<leader>wl",
				"<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
				opts
			)
			vim.keymap.set("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
			vim.keymap.set("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
			vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
			vim.keymap.set("n", "<leader>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
			vim.keymap.set("n", "<leader>ff", "<cmd>Format<CR>", opts)
			-- vim.keymap.set("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
			-- vim.keymap.set("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
			-- vim.keymap.set("n", "<leader>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
		end,
	},
}
