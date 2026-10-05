require("mini.icons").setup()
require("mini.notify").setup()
require("mini.cursorword").setup()
require("mini.indentscope").setup()
require("mini.statusline").setup()
require("mini.trailspace").setup()
require("rose-pine").setup({ dim_inactive_windows = true, styles = { transparency = true } })

vim.cmd.colorscheme("rose-pine")
