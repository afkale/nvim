local utils = {}

utils.switch = function()
  local map = {
    True = "False",
    False = "True",
    ["true"] = "false",
    ["false"] = "true",
    ["const"] = "let",
    ["let"] = "const",
    ["or"] = "and",
    ["and"] = "or",
    ["yes"] = "no",
    ["no"] = "yes",
  }

  local word = vim.fn.expand("<cword>")
  local substitution = map[word]

  if substitution ~= nil then
    vim.api.nvim_feedkeys("*#cw" .. substitution, "n", false)
    vim.api.nvim_input("<ESC>")
  elseif word ~= '' then
    vim.notify("No substitution found for '" .. word .. "'", vim.log.levels.WARN)
  end
end

vim.keymap.set("n", "<C-s>", utils.switch, {}) -- Switch character pairs
return utils
