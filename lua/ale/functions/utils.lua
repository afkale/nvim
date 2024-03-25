-- These are functions that are used within the Lua
-- configuration and are not meant for export to the end
-- user.

local get_os = function()
	return vim.loop.os_uname().sysname
end

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
	end
}
