return {
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"echasnovski/mini.icons"
		},
		version = "*",
		config = function()
			local cmp = require("cmp")

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

			local win_config = {
				border = nil,
				winhighlight = 'Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None',
				zindex = 1001,
				scrolloff = 0,
				col_offset = 0,
				side_padding = 1,
				scrollbar = false,
			}

			cmp.setup({
				performance = performance,
				window = {
					completion = win_config,
					documentation = win_config,
				},

				experimental = { ghost_text = true },
				mapping = mappings,
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
				}, {
					{ name = "buffer" },
					{ name = "path" },
				}),
				sorting = sorting,
				formatting = {
					fields = { "abbr", "kind", "menu" },
					expandable_indicator = true,

					format = function(entry, vim_item)
						local kind = vim_item.kind
						vim_item.kind = MiniIcons.get("lsp", kind) .. " "
						vim_item.menu = "[" .. kind .. "]"
						return vim_item
					end
				}
			})

			cmp.setup.cmdline({ "/", "?" }, {
				performance = performance,
				mapping = cmp.mapping.preset.cmdline(),
				sources = { { name = "buffer" } },
				sorting = sorting,
			})

			cmp.setup.cmdline(":", {
				performance = performance,
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources(
					{ { name = "path" }, }, { { name = "cmdline" } }
				),
				sorting = sorting,
				matching = {
					disallow_symbol_nonprefix_matching = true,
					disallow_fullfuzzy_matching = false,
					disallow_partial_matching = false,
					disallow_prefix_unmatching = false,
					disallow_fuzzy_matching = false,
					disallow_partial_fuzzy_matching = false,
				},
			})
		end
	},
}
