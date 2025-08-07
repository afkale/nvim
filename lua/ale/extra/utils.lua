local M = {}

M.switch = function()
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
		vim.api.nvim_feedkeys("ciw" .. substitution, "n", false)
		vim.api.nvim_input("<ESC>")
	else
		vim.notify("No substitution found for '" .. word .. "'", vim.log.levels.WARN)
	end
end

M.kmset = vim.keymap.set
return M
