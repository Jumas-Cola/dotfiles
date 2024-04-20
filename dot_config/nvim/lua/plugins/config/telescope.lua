local keymap = vim.keymap
local map = vim.api.nvim_set_keymap
local telescope = require("telescope")
local builtin = require("telescope.builtin")

keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find in buffers" })
keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find in help" })
keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Find in keymaps" })
map("n", "<leader>ft", ":TodoTelescope keywords=TODO,FIX<CR>", {})

telescope.setup({ pickers = { find_files = { hidden = true } } })
