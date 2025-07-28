return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp", },
			{
				"folke/lazydev.nvim",
				ft = "lua",
				opts = {
					library = {
						{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
						{ path = "LazyVim",            words = { "LazyVim" } },
					},
				}
			},
		},
		opts = {
			servers = {
				nushell = {},
				rust_analyzer = {},
				jsonls = {},
				marksman = {},
				bashls = { filetypes = { "sh", "zsh" } },
				dockerls = {
					settings = {
						docker = {
							languageserver = {
								formatter = {
									ignoreMultilineInstructions = true,
								},
							},
						}
					}
				},
				lua_ls = {
					settings = {
						Lua = {
							diagnostics = {
								enable = true,
								globals = { "vim" },
								diagnosticMode = "workspace",
							},
							workspace = {
								checkThirdParty = false,
								library = {
									vim.env.VIMRUNTIME, "${3rd}/luv/library", "LazyVim",
								},
							},
							telemetry = { enable = false },
							completion = {
								callSnippet = "Replace", -- Better function snippet behavior
							},
							format = {
								enable = true, -- Ensure formatting is enabled
								defaultConfig = {
									indent_style = "space",
									indent_size = 2,
								},
							},
						},
					},
				},
				-- ruff = {},
				pyright = {
					settings = {
						pyright = {
							disableOrganizeImports = true,
						},
						python = {
							analysis = {
								ignore = { '*' },
							},
						},
					},
				},
				angularls = {},
				eslint = {}
			},
		},
		config = function(_, opts)
			local lspconfig = require("lspconfig")
			local capabilities = vim.tbl_deep_extend(
				"force",
				{},
				vim.lsp.protocol.make_client_capabilities(),
				require("cmp_nvim_lsp").default_capabilities()
			)

			-- LSP servers setup configuration
			for server, config in pairs(opts.servers) do
				config.capabilities = capabilities
				lspconfig[server].setup(config)
			end
			-- Diagnostic configuration
			-- vim.diagnostic.config({
			-- 	float = { source = true },
			-- 	virtual_text = {
			-- 		enable = true,
			-- 		spacing = 4,
			-- 		prefix = "■",
			-- 	},
			-- 	signs = true,
			-- 	underline = true,
			-- 	update_in_insert = false,
			-- 	severity_sort = true,
			-- })
		end,
	},
}
