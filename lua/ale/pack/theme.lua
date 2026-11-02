require("mini.icons").setup()
require("mini.notify").setup()
require("mini.cursorword").setup({ delay = 100 })
require("mini.indentscope").setup({
  symbol = "│",
  options = { try_as_border = true },
})

require("mini.statusline").setup({
  content = {
    active = function()
      local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
      local git           = MiniStatusline.section_git({ trunc_width = 75 })
      local diff          = MiniStatusline.section_diff({ trunc_width = 75 })
      local diagnostics   = MiniStatusline.section_diagnostics({ trunc_width = 75 })
      local lsp           = MiniStatusline.section_lsp({ trunc_width = 120 })
      local filename      = MiniStatusline.section_filename({ trunc_width = 140 })
      local fileinfo      = MiniStatusline.section_fileinfo({ trunc_width = 120 })
      local location      = MiniStatusline.section_location({ trunc_width = 75 })
      return MiniStatusline.combine_groups({
        { hl = mode_hl,                 strings = { mode } },
        { hl = 'MiniStatuslineDevinfo', strings = { git, diff, diagnostics, lsp } },
        '%<',
        { hl = 'MiniStatuslineFilename', strings = { filename } },
        '%=',
        { hl = 'MiniStatuslineFileinfo', strings = { fileinfo, location } },
      })
    end,
  },
})

require("mini.trailspace").setup()

require("rose-pine").setup({
  dim_inactive_windows = true,
  styles = { transparency = true },
  highlight_groups = {
    -- Make the statusline blend with the background
    StatusLine = { fg = "subtle", bg = "base" },
    -- Better indent scope coloring
    MiniIndentscopeSymbol = { fg = "muted" },
  },
})

vim.cmd.colorscheme("rose-pine")
