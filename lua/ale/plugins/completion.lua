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

			local performance = { max_view_entries = 30 }

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

			local mappings = cmp.mapping.preset.insert({
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				["<C-y>"] = cmp.mapping.confirm({ select = true })
			})

			cmp.setup({
				performance = performance,
				experimental = { ghost_text = true },
				mapping = mappings,
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
				sources = cmp.config.sources(
					{ { name = "path" }, }, { { name = "cmdline" } }
				),
				sorting = sorting
			})
		end
	},
}
