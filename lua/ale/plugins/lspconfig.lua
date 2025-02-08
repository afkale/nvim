return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "saghen/blink.cmp" },
			{
				"folke/lazydev.nvim",
				ft = "lua", -- only load on lua files
				opts = {
					library = {
						-- See the configuration section for more details
						-- Load luvit types when the `vim.uv` word is found
						{ path = "${3rd}/luv/library", words = { "vim%.uv" } },

						-- Only load the lazyvim library when the `LazyVim` global is found
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
				lua_ls = {},
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
				bashls = { filetypes = { "sh", "zsh" } },
				pyright = {
					settings = {
						pyright = { disableOrganizeImports = true },
						python = { analysis = { ignore = { "*" } } },
					},
				},
			},
		},
		config = function(_, opts)
			local lspconfig = require("lspconfig")
			for server, config in pairs(opts.servers) do
				config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
				lspconfig[server].setup(config)
			end
		end,
	},
}
