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
				pyright = {
					settings = {
						python = {
							analysis = {
								autoSearchPaths = true,
								typeCheckingMode = "off",
								autoImportCompletions = true,
								diagnosticMode = "workspace"
							}
						}
					}
				}
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

			local util = require("lspconfig.util")
			lspconfig.root_dir = util.root_pattern("pyproject.toml", ".git")

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
			local set = vim.keymap.set
			local kmopts = { noremap = true, silent = true }

			set("n", "gri", vim.lsp.buf.references, kmopts)
			set("n", "grn", vim.lsp.buf.rename, kmopts)
			set("n", "gra", vim.lsp.buf.code_action, kmopts)

			set("n", "gft", function()
				vim.g.autoformat = not vim.g.autoformat
				vim.notify(vim.g.autoformat and 'Formatting Active' or 'Formatting Disabled', vim.log.levels.INFO)
			end)
			set("n", "gff", vim.lsp.buf.format, kmopts)

			set("n", "<leader>cd", vim.diagnostic.setqflist, kmopts)
			set("n", "E", vim.diagnostic.open_float, kmopts)

			set("n", "gd", vim.lsp.buf.definition, kmopts)
			set("n", "gD", vim.lsp.buf.declaration, kmopts)
			set("n", "gi", vim.lsp.buf.implementation, kmopts)
			set("n", "fs", vim.lsp.buf.workspace_symbol, kmopts)

			set("n", "K", vim.lsp.buf.hover, kmopts)
		end,
	},
}
