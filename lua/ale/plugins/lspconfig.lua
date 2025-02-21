return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "hrsh7th/nvim-cmp" },
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
				ruff = {},
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
								globals = { "vim" }, -- Avoid "undefined global 'vim'" error
								disable = { "missing-fields" }, -- Optional: Prevent some annoying warnings
								diagnosticMode = "workspace",
							},
							workspace = {
								checkThirdParty = false, -- Disable "Do you want to configure your workspace?" prompt
								library = {
									vim.env.VIMRUNTIME, -- Include Neovim runtime files
									"${3rd}/luv/library", -- Add additional libraries from LazyDev
									"LazyVim", -- Add LazyVim as a recognized library
								},
							},
							telemetry = { enable = false }, -- Disable telemetry
							completion = {
								callSnippet = "Replace", -- Better function snippet behavior
							},
						},
					},
				},
				pyright = {
					settings = {
						pyright = { disableOrganizeImports = true },
						python = {
							analysis = {
								-- typeCheckingMode = "strict",
								autoSearchPaths = true,
								useLibraryCodeForTypes = true,
								diagnosticMode = "workspace",
							}
						},
					},
				},
			},
		},
		config = function(_, opts)
			local lspconfig = require("lspconfig")

			-- LSP servers setup configuration
			for server, config in pairs(opts.servers) do
				config.capabilities = require("cmp_nvim_lsp").default_capabilities()
				lspconfig[server].setup(config)
			end

			-- Diagnostic configuration
			vim.diagnostic.config({
				float = { source = true },
				virtual_text = {
					enable = true,
					spacing = 4,
					prefix = "■",
				},
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
			})

			-- Keymap for LSP actions
			local keymap_opts = { noremap = true, silent = true }
			vim.keymap.set("n", "gri", vim.lsp.buf.references, keymap_opts)
			vim.keymap.set("n", "grn", vim.lsp.buf.rename, keymap_opts)
			vim.keymap.set("n", "gra", vim.lsp.buf.code_action, keymap_opts)

			vim.keymap.set("n", "gfd", "<CMD>lua vim.g.autoformat = not vim.g.autoformat<CR>")
			vim.keymap.set("n", "gff", vim.lsp.buf.format, keymap_opts)

			vim.keymap.set("n", "gel", vim.diagnostic.setqflist, keymap_opts)
			vim.keymap.set("n", "gee", vim.diagnostic.open_float, keymap_opts)

			vim.keymap.set("n", "gd", vim.lsp.buf.definition, keymap_opts)
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, keymap_opts)
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, keymap_opts)

			vim.keymap.set("n", "K", vim.lsp.buf.hover, keymap_opts)
		end,
	},
}
