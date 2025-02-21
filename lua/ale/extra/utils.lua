local M = {}
--- This function should validate the buffer or return a valid one.
--- @param buf any
--- @return any
M.create_buffer = function(buf)
	local buf = buf or -1

	if buf and vim.api.nvim_buf_is_valid(buf) then
		return buf
	end

	return vim.api.nvim_create_buf(false, true)
end

---
--- Gets the current Neovim UI size.
--- Returns width, height, and their respective column and row offsets.
---
---@param sizep number The percentage of the Neovim window size (between 0 and 1) to calculate.
---@return table size Table containing width, height, col, and row.
---@nodiscard
---
M.calculate_centered_window_size = function(opts)
	opts = opts or {}

	local width = opts.width or math.floor(vim.o.columns * opts.sizep)
	local height = opts.height or math.floor(vim.o.lines * opts.sizep)
	local col = math.floor((vim.o.columns - width) / 2)
	local row = math.floor((vim.o.lines - height) / 2)

	return { width = width, height = height, col = col, row = row }
end

---
--- Creates a floating window in Neovim with specified options.
--- If no options are provided, default values are used for positioning and sizing.
---
---@param opts table Options for configuring the floating window.
---  - `row` (number|nil) : Row position of the window. Defaults to 40.
---  - `col` (number|nil) : Column position of the window. Defaults to 40.
---  - `width` (number|nil) : Width of the window. Defaults to 40.
---  - `height` (number|nil) : Height of the window. Defaults to 40.
---  - `buf` (integer|nil) : Buffer ID to associate with the window. Defaults to a newly created buffer.
---  - `sizep` (integer|nil) : Buffer ID to associate with the window. Defaults to a newly created buffer.
---  - `centered` (boolean) : Buffer ID to associate with the window. Defaults to a newly created buffer.
---@return table result A table containing the `buf` and `win`:
---  - `buf` (integer) : Buffer ID used in the window.
---  - `win` (integer) : Window ID created by the floating window.
---
M.create_floating_window = function(opts)
	opts = opts or {}

	-- Set the window centered by default
	opts.centered = (opts.centered == nil or opts.centered == true)
	if opts.centered then
		local csize = M.calculate_centered_window_size({
			width = opts.width, height = opts.height, sizep = opts.sizep or 0.8
		})
		opts.width = csize.width
		opts.height = csize.height
		opts.row = csize.row
		opts.col = csize.col
	end

	-- Default window configuration
	local win_config = {
		relative = "editor",
		row = opts.row or 40,
		col = opts.col or 40,
		width = opts.width or 40,
		height = opts.height or 40,
		style = "minimal",
		border = "rounded"
	}

	-- Create buffer (if not provided)
	local buf = M.create_buffer(opts.buf)

	-- Create and open the floating window
	local win = vim.api.nvim_open_win(buf, true, win_config)

	-- Return the buffer and window identifiers
	return { buf = buf, win = win }
end

local valid_places = { topleft = true, botright = true, rightbelow = true, leftabove = true }
local valid_options = { split = true, vsplit = true, new = true, vnew = true }

---
--- Creates a split in Neovim with specified options.
---
---@param opts table Options for configuring the split.
---  - `place` (string) : The place where the split is going to be created.
---  - `option` (string) : The spliting behavior for the place selected.
---  - `buf` (integer|nil) : Buffer ID to associate with the window. Defaults to a newly created buffer.
---@return table result A table containing the `buf` and `win`:
---  - `buf` (integer) : Buffer ID used in the window.
---  - `win` (integer) : Window ID created by the split window.
---
M.create_split = function(opts)
	local place = opts.place
	local option = opts.option

	-- Validate inputs
	if not valid_places[place] then
		error("Invalid 'place' value. Allowed: 'topleft', 'botright', 'rightbelow', 'leftabove'")
	end
	if not valid_options[option] then
		error("Invalid 'option' value. Allowed: 'split', 'vsplit', 'new', 'vnew'")
	end

	-- Execute split command, example: topleft split
	local command = string.format(":%s %s", opts.place, opts.option)
	vim.cmd(command)

	-- Get the newly created window ID
	local win = vim.api.nvim_get_current_win()
	local buf = M.create_buffer(opts.buf)

	vim.api.nvim_set_current_buf(buf)
	vim.api.nvim_win_set_height(win, opts.height or 10)

	return { buf = buf, win = win }
end

return M
