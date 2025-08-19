local utils = {}

local WordSwitch = {}
local H = {}

WordSwitch.config = {}

WordSwitch.setup = function(config)
  _G.WordSwitch = WordSwitch
  config = H.setup_config(config)
end

H.default_config = vim.deepcopy(WordSwitch.config)

H.check_type = function(name, val, ref, allow_nil)
  if type(val) == ref or (ref == 'callable' and vim.is_callable(val)) or (allow_nil and val == nil) then return end
  H.error(string.format('`%s` should be %s, not %s', name, ref, type(val)))
end

H.setup_config = function(config)
  H.check_type('config', config, 'table', true)
  config = vim.tbl_deep_extend('force', vim.deepcopy(H.default_config), config or {})

  return config
end

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
