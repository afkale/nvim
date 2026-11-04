-- Grep operator: use <leader>f as a prefix but with a specific motion.
-- e.g., <leader>fiw  → grep word under cursor
--       <leader>f 2j → grep next two lines
-- The <leader>f mapping is an operator-pending mapping, so it doesn't conflict
-- with <leader>ff, <leader>fg, etc. as long as leader combinations are typed
-- within the timeoutlen window.

local map = require("ale.keys").map

local M = {}

function M.grep_operator(type)
  local saved_reg = vim.fn.getreg('"')
  local saved_regtype = vim.fn.getregtype('"')
  if type == 'char' or type == 'line' or type == 'block' then
    vim.cmd('normal! `[v`]y')
    local text = vim.fn.escape(vim.fn.getreg('"'), [[.,^$*[]\/~(){}|?+-":<>]])
    vim.cmd('silent grep!  "' .. text .. '"')
  end
  vim.fn.setreg('"', saved_reg, saved_regtype)
end

-- Operator-pending mapping for Grep (e.g., <leader>fiw to grep word under cursor motion)
map("n", "<leader>f", function()
  vim.o.operatorfunc = 'v:lua.require(\'ale.grep\').grep_operator'
  return 'g@'
end, "Grep via motion", { expr = true })

return M
