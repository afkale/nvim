local M = {}

M.switch = function()
	local map = {
		True = "False",
		False = "True",
		["true"] = "false",
		["false"] = "true",
		["or"] = "and",
		["and"] = "or",
	}

	local word = vim.fn.expand("<cword>")
	local substitution = map[word]

	if substitution ~= nil then
		vim.api.nvim_feedkeys("ciw" .. substitution, "n", false)
		vim.api.nvim_input("<ESC>")
	end
end

M.kmset = vim.keymap.set
return M
