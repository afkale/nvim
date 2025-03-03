return {
	"ThePrimeagen/harpoon",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local set = vim.api.nvim_set_keymap
		local opts = { noremap = true, silent = true }

		-- Add a mark to the current file
		set('n', '<leader>ma', ':lua require("harpoon.mark").add_file()<CR>', opts)
		set('n', '<leader>mm', ':lua require("harpoon.ui").toggle_quick_menu()<CR>', opts)
		set('n', '<leader>mp', ':lua require("harpoon.ui").nav_prev()<CR>', opts)
		set('n', '<leader>mn', ':lua require("harpoon.ui").nav_next()<CR>', opts)

		-- Move between marks
		set('n', '<leader>m1', ':lua require("harpoon.ui").nav_file(1)<CR>', opts)
		set('n', '<leader>m2', ':lua require("harpoon.ui").nav_file(2)<CR>', opts)
		set('n', '<leader>m3', ':lua require("harpoon.ui").nav_file(3)<CR>', opts)
		set('n', '<leader>m4', ':lua require("harpoon.ui").nav_file(4)<CR>', opts)
		set('n', '<leader>m5', ':lua require("harpoon.ui").nav_file(5)<CR>', opts)
		set('n', '<leader>m6', ':lua require("harpoon.ui").nav_file(6)<CR>', opts)
		set('n', '<leader>m7', ':lua require("harpoon.ui").nav_file(7)<CR>', opts)
		set('n', '<leader>m8', ':lua require("harpoon.ui").nav_file(8)<CR>', opts)
		set('n', '<leader>m9', ':lua require("harpoon.ui").nav_file(9)<CR>', opts)
	end
}
