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

-- Operator-pending mapping for F
vim.keymap.set('n', '<leader>f', function()
  vim.o.operatorfunc = 'v:lua.grep_operator'
  return 'g@'
end, { expr = true, silent = true, desc = "Grep operator" })


-- Undotree
vim.keymap.set("n", "<leader>u", function()
  vim.cmd.packadd("nvim.undotree")
  require("undotree").open()
end, { desc = "Toggle Builtin undotree" })
