return {
	"hrsh7th/vim-vsnip",
	dependencies = {
		{ "neovim/nvim-lspconfig" },
		{ "onsails/lspkind-nvim" },
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "hrsh7th/cmp-buffer" },
		{ "hrsh7th/cmp-path" },
		{ "hrsh7th/cmp-cmdline" },
		{ "hrsh7th/nvim-cmp" },
		{ "saadparwaiz1/cmp_luasnip" },
		{
			"L3MON4D3/LuaSnip",
			version = "v2.*",
			build = "make install_jsregexp",
			dependencies = {
				{ "rafamadriz/friendly-snippets", lazy = true },
			},
			priority = 1000,
			config = function()
				require("luasnip.loaders.from_vscode").lazy_load()
			end,
		},
	},
	config = function()
		local cmp = require("cmp")
		local lspkind = require("lspkind")

		cmp.setup({
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			mapping = cmp.mapping.preset.insert({
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-j>"] = cmp.mapping.select_next_item(),
				["<C-k>"] = cmp.mapping.select_prev_item(),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				["<Tab>"] = cmp.mapping.confirm({ select = true }),
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip", option = { use_show_condition = false } },
				{ name = "path" },
				{ name = "vsnip" },
			}, {
				{ name = "buffer" },
			}),
			formatting = {
				format = lspkind.cmp_format({
					mode = "symbol_text",
					maxwidth = 50,
					ellipsis_char = "...",
					before = function(entry, vim_item)
						vim_item.menu = ({
							nvim_lsp = "[LSP]",
							luasnip = "[Snippet]",
							buffer = "[Buffer]",
							path = "[Path]",
						})[entry.source.name]
						return vim_item
					end,
				}),
			},
			experimental = {
				ghost_text = true,
			},
		})

		-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won"t work anymore).
		cmp.setup.cmdline({ "/", "?" }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = { { name = "buffer" } },
		})

		-- Use cmdline & path source for ":" (if you enabled `native_menu`, this won"t work anymore).
		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
			matching = { disallow_symbol_nonprefix_matching = false },
		})

		local function tab_complete()
			local luasnip = require("luasnip")
			if luasnip.expand_or_jumpable() then
				return "<cmd>lua require'luasnip'.jump(1)<CR>"
			else
				return "<Tab>"
			end
		end

		-- Map the Tab key in insert and select mode
		vim.keymap.set("i", "<Tab>", tab_complete, { expr = true, noremap = true, silent = true })
		vim.keymap.set("s", "<Tab>", tab_complete, { expr = true, noremap = true, silent = true })
		vim.keymap.set("i", "<S-Tab>", [[<cmd>lua require'luasnip'.jump(-1)<CR>]], { noremap = true, silent = true })
		vim.keymap.set("s", "<S-Tab>", [[<cmd>lua require'luasnip'.jump(-1)<CR>]], { noremap = true, silent = true })
	end,
}
