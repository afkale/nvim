require("mini.git").setup()

local map = require("ale.keys").map

local blame_width = 40
local blame_win = nil
local blame_src_buf = nil

map({ "n", "v" }, "<leader>gb", function()
  local win_before = vim.api.nvim_get_current_win()
  local buf_before = vim.api.nvim_get_current_buf()

  if blame_win ~= nil then
    -- Forget a blame window that was closed (stale handle -> would error)
    local stale = not vim.api.nvim_win_is_valid(blame_win)
    -- Refresh when invoked from a different source file
    if not stale and blame_win ~= win_before and blame_src_buf ~= buf_before then
      pcall(vim.api.nvim_win_close, blame_win, true)
      stale = true
    end
    if stale then
      blame_win = nil
      blame_src_buf = nil
    end
  end

  if blame_win == nil then
    vim.cmd("topleft vertical Git blame -- %")
    blame_win = vim.api.nvim_get_current_win()
    blame_src_buf = buf_before
  end
  if blame_win ~= win_before then
    vim.api.nvim_win_set_width(blame_win, blame_width)
  end
end, "Git blame (left split, width " .. blame_width .. ")")
