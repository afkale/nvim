local map = require("ale.keys").map

-- Grep operator lives in ale/grep.lua (loaded via ale/init.lua).


-- Undotree
map("n", "<leader>u", function()
  local ok, undotree = pcall(require, "undotree")
  if ok then
    undotree.open()
  else
    vim.cmd("packadd nvim.undotree")
    require("undotree").open()
  end
end, "Toggle undotree")

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
map("n", "<leader>ft", ":term<CR>", "Open terminal")

