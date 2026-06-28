local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap("n", "<Leader>t", "<cmd>Neotree toggle<cr>", { desc = "Toggle Neotree" })

keymap("n", "<leader>p", function()
	require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format buffer" })

keymap("n", "<C-s>", "<cmd>mksession!<cr>", { desc = "Save vim session" })

keymap("n", "<A-,>", "<cmd>tabprev<cr>", { desc = "Previous tab" })
keymap("n", "<A-.>", "<cmd>tabnext<cr>", { desc = "Next tab" })

keymap("n", "<A-c>", "<cmd>tabc<cr>", { desc = "Close buffer" })

keymap("n", "<A-[>", "<cmd>vertical resize +1<cr>", { desc = "Move splitline +1" })
keymap("n", "<A-]>", "<cmd>vertical resize -1<cr>", { desc = "Move splitline -1" })

keymap("n", "<C-[>", "<cmd>horizontal resize +1<cr>", { desc = "Move splitline +1" })
keymap("n", "<C-]>", "<cmd>horizontal resize -1<cr>", { desc = "Move splitline -1" })

keymap("n", "<A-d>", "<cmd>tab split<cr>", { desc = "Duplicate tab" })

keymap("n", "<A-t>", "<cmd>below split | resize -11 | terminal<cr>", { desc = "Open terminal" })

keymap("n", "<F5>", "<cmd>source ~/.config/nvim/init.lua<cr>", { desc = "Reload nvim config" })

keymap("n", "dc", "<cmd>DapContinue<cr>", { desc = "DAP continue" })
keymap("n", "de", "<cmd>lua require('dapui').close()<cr>", { desc = "DAP exit" })
keymap("n", "db", "<cmd>DapToggleBreakpoint<cr>", { desc = "DAP breakpoint" })

keymap("n", "<Leader>d", "<Plug>(doge-generate)", { desc = "Generate comment" })
