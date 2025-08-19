local function grep_and_replace()
  local find = vim.fn.input({ prompt = "Search: " })
  if not find then return end

  local replace = vim.fn.input({ prompt = "Replace: " })

  if not replace then return end

  local safe_find = vim.fn.escape(find, '/\\')

  vim.cmd("sil!grep! " .. find)
  local items = #vim.fn.getqflist() > 1
  if not items then return end

  vim.cmd("cdo s/" .. safe_find .. "/" .. replace .. "/gc | update")
  vim.cmd("cclose")
end

vim.keymap.set("n", "<leader>crn", grep_and_replace)
