local theme = "mocha"

return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				transparent_background = true,
				integrations = {
					cmp = true,
					native_lsp = {
						enabled = true,
					},
				},
			})

			local palette = require("catppuccin.palettes").get_palette(theme)

			vim.api.nvim_set_hl(0, "CmpItemAbbr", { fg = palette.text })
			vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = palette.blue, bold = true })
			vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = palette.overlay2 })
			vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = palette.mauve })
			vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = palette.mauve })
			vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = palette.flamingo })
			vim.api.nvim_set_hl(0, "CmpItemKindField", { fg = palette.flamingo })
			vim.api.nvim_set_hl(0, "CmpItemKindClass", { fg = palette.peach })
			vim.api.nvim_set_hl(0, "CmpItemKindInterface", { fg = palette.teal })
			vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = palette.red })

			vim.cmd("colorscheme catppuccin-" .. theme)
		end
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { { "echasnovski/mini.icons", opts = {} } },
		config = function()
			local lualine = require("lualine")
			local dap = require("dap")

			local palette = require("catppuccin.palettes").get_palette(theme)
			local colors = {
				bg       = palette.base,
				fg       = palette.text,
				yellow   = palette.yellow,
				cyan     = palette.teal,
				darkblue = palette.surface0,
				green    = palette.green,
				orange   = palette.peach,
				violet   = palette.mauve,
				magenta  = palette.pink,
				blue     = palette.blue,
				red      = palette.red,
			}

			local conditions = {
				buffer_not_empty = function()
					return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
				end,
				hide_in_width = function()
					return vim.fn.winwidth(0) > 80
				end,
				check_git_workspace = function()
					local filepath = vim.fn.expand("%:p:h")
					local gitdir = vim.fn.finddir(".git", filepath .. ";")
					return gitdir and #gitdir > 0 and #gitdir < #filepath
				end,
				dap_active = function()
					return dap.session() ~= nil
				end
			}

			-- Config
			local config = {
				theme = "catppuccin-" .. theme,
				options = {
					-- Disable sections and component separators
					component_separators = "",
					section_separators = "",
					theme = {
						-- We are going to use lualine_c an lualine_x as left and
						-- right section. Both are highlighted by c theme .  So we
						-- are just setting default looks o statusline
						normal = { c = { fg = colors.fg, bg = colors.bg } },
						inactive = { c = { fg = colors.fg, bg = colors.bg } },
					},
				},
				sections = {
					-- these are to remove the defaults
					lualine_a = {},
					lualine_b = {},
					lualine_y = {},
					lualine_z = {},
					-- These will be filled later
					lualine_c = {},
					lualine_x = {},
				},
				inactive_sections = {
					-- these are to remove the defaults
					lualine_a = {},
					lualine_b = {},
					lualine_y = {},
					lualine_z = {},
					lualine_c = {},
					lualine_x = {},
				},
			}

			-- Inserts a component in lualine_c at left section
			local function ins_left(component)
				table.insert(config.sections.lualine_c, component)
			end

			-- Inserts a component in lualine_x at right section
			local function ins_right(component)
				table.insert(config.sections.lualine_x, component)
			end

			ins_left({
				function()
					return "▊"
				end,
				color = { fg = colors.blue },  -- Sets highlighting of component
				padding = { left = 0, right = 1 }, -- We don't need space before this
			})

			ins_left({
				function() return " " end,
				color = function()
					-- auto change color according to neovims mode
					local mode_color = {
						n = colors.red,
						i = colors.green,
						v = colors.blue,
						[""] = colors.blue,
						V = colors.blue,
						c = colors.magenta,
						no = colors.red,
						s = colors.orange,
						S = colors.orange,
						[""] = colors.orange,
						ic = colors.yellow,
						R = colors.violet,
						Rv = colors.violet,
						cv = colors.red,
						ce = colors.red,
						r = colors.cyan,
						rm = colors.cyan,
						["r?"] = colors.cyan,
						["!"] = colors.red,
						t = colors.red,
					}
					return { fg = mode_color[vim.fn.mode()] }
				end,
				padding = { right = 1 },
			})

			ins_left({
				function()
					local filename = vim.fn.expand("%:t")
					return MiniIcons.get("file", filename) .. "  " .. filename
				end,
				cond = conditions.buffer_not_empty,
				color = { fg = colors.magenta },
			})

			ins_left({ "location" })

			ins_left({ "progress", color = { fg = colors.fg, gui = "bold" } })

			ins_left({
				'lsp_status',
				icon = '', -- f013
				symbols = {
					-- Standard unicode symbols to cycle through for LSP progress:
					spinner = { '', '', '', '', '', '' },
					-- Standard unicode symbol for when LSP is done:
					done = '',
					-- Delimiter inserted between LSP names:
					separator = ' ',
				},
				ignore_lsp = {},
				color = { fg = colors.magenta },
			})

			ins_left({
				function() return " " end,
				color = { fg = colors.green, gui = "bold" },
				cond = conditions.dap_active,
				padding = { left = 1 },
			})

			ins_left({
				"diagnostics",
				sources = { "nvim_diagnostic" },
				symbols = { error = " ", warn = " ", info = " " },
				diagnostics_color = {
					error = { fg = colors.red },
					warn = { fg = colors.yellow },
					info = { fg = colors.cyan },
				},
			})

			-- Insert mid section. You can make any number of sections in neovim :)
			-- for lualine it's any number greater then 2
			ins_left({ function() return "%=" end })

			-- Add components to right sections
			ins_right({
				"o:encoding",   -- option component same as &encoding in viml
				fmt = string.upper, -- I'm not sure why it's upper case either ;)
				cond = conditions.hide_in_width,
				color = { fg = colors.green, gui = "bold" },
			})

			ins_right({
				"fileformat",
				fmt = string.upper,
				icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
				color = { fg = colors.green, gui = "bold" },
			})

			ins_right({
				"branch",
				icon = "",
				color = { fg = colors.violet, gui = "bold" },
			})

			ins_right({
				"diff",
				-- Is it me or the symbol for modified us really weird
				symbols = { added = " ", modified = "󰝤 ", removed = " " },
				diff_color = {
					added = { fg = colors.green },
					modified = { fg = colors.orange },
					removed = { fg = colors.red },
				},
				cond = conditions.hide_in_width,
			})

			ins_right({
				function()
					return "▊"
				end,
				color = { fg = colors.blue },
				padding = { left = 1 },
			})

			-- Now don't forget to initialize lualine
			lualine.setup(config)
		end,
	},
}
