-- These are functions that are used within the Lua
-- configuration and are not meant for export to the end
-- user.

local get_os = function()
	return vim.loop.os_uname().sysname
end

local couples = {
	["'"] = "'",
	['"'] = '"',
	["`"] = "`",
	["{"] = "}",
	["["] = "]",
	["("] = ")",
	["<"] = ">",
}

return {
	get_os = get_os,
	get_home = function()
		return os.getenv("HOME")
	end,
	has_value = function(table, val)
		for _, value in ipairs(table) do
			if value == val then
				return true
			end
		end
		return false
	end,
	merge = function(...)
		local res = {}
		for _, t in ipairs({ ... }) do
			for _, value in ipairs(t) do
				table.insert(res, value)
			end
		end
		return res
	end,
	get_visual_selection_indices = function()
		local c_buf, s_row, s_col, _ = unpack(vim.fn.getpos("'<"))
		local _, e_row, e_col, _ = unpack(vim.fn.getpos("'>"))

		s_row = s_row - 1
		s_col = s_col - 1
		e_row = e_row - 1
		e_col = e_col - 1

		return c_buf, s_row, s_col, e_row, e_col
	end,
	get_couple = function(key)
		return key, couples[key]
	end,
	couples = couples,
}
