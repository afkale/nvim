require("mini.git").setup()

local map = require("ale.keys").map
map({ "n", "v" }, "<leader>gb", ":vertical Git blame -- %<CR>", "Git Blame")
