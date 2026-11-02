local map = require("ale.keys").map

-- Grep operator: use <leader>f as a prefix but with a specific motion.
-- e.g., <leader>giw  → grep word under cursor
--       <leader>f 2j → grep next two lines
-- The <leader>f mapping is an operator-pending mapping, so it doesn't conflict
-- with <leader>ff, <leader>fg, etc. as long as leader combinations are typed
-- within the timeoutlen window.
function _G.grep_operator(type)
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
  vim.o.operatorfunc = 'v:lua.grep_operator'
  return 'g@'
end, "Grep operator (motion)", { expr = true })


-- Undotree
map("n", "<leader>u", function()
  local ok, undotree = pcall(require, "undotree")
  if ok then
    undotree.open()
  else
    vim.cmd("packadd nvim.undotree")
    require("undotree").open()
  end
end, "Toggle Builtin undotree")

-- Toggle line numbers
map("n", "<leader>tn", function()
  if vim.opt.number:get() then
    vim.opt.number = false
    vim.opt.relativenumber = false
    vim.notify("Numbers hidden", vim.log.levels.INFO)
  else
    vim.opt.number = true
    vim.opt.relativenumber = true
    vim.notify("Numbers shown", vim.log.levels.INFO)
  end
end, "Toggle line numbers")

-- Toggle wrap
map("n", "<leader>tw", function()
  vim.opt.wrap = not vim.opt.wrap:get()
  vim.notify("Wrap: " .. tostring(vim.opt.wrap:get()), vim.log.levels.INFO)
end, "Toggle line wrap")

-- Terminal helper: open terminal in current directory
map("n", "<leader>ft", ":term<CR>", "Open terminal in current window")

-- Make Y behave like D (yank to end of line)
map("n", "Y", "y$", "Yank to end of line")
