return {
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-vsnip",
			"hrsh7th/vim-vsnip",
		},
		version = "*",
		config = function()
			local cmp = require("cmp")

			vim.g.vsnip_snippet_dir = "~/.config/nvim/snippets"

			local performance = {
				debounce = 60,
				throttle = 30,
				fetching_timeout = 500,
				filtering_context_budget = 100,
				confirm_resolve_timeout = 80,
				async_budget = 1,
				max_view_entries = 30
			}
			local sorting = {
				comparators = {
					cmp.config.compare.offset,
					cmp.config.compare.exact,
					cmp.config.compare.score,
					cmp.config.compare.recently_used,
					cmp.config.compare.locality,
					cmp.config.compare.kind,
					cmp.config.compare.sort_text,
					cmp.config.compare.length,
					cmp.config.compare.order,
				}
			}

			cmp.setup({

				performance = performance,
				experimental = { ghost_text = true },
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<Tab>"] = cmp.mapping.confirm({ select = true }),
					["<C-y>"] = cmp.mapping.confirm({ select = true })
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "vsnip" },
				}, {
					{ name = "buffer" },
					{ name = "path" },
				}),
				sorting = sorting
			})
			cmp.setup.cmdline({ "/", "?" }, {
				performance = performance,
				mapping = cmp.mapping.preset.cmdline(),
				sources = { { name = "buffer" } },
				sorting = sorting
			})
			cmp.setup.cmdline(":", {
				performance = performance,
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" }
				}),
				sorting = sorting
			})
		end
	},
}
