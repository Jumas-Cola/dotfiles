local map = vim.api.nvim_set_keymap
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Neotree
map("n", "<Leader>t", ":Neotree toggle<CR>", { table.unpack(opts), desc = "Toggle Neotree" })

-- Neoformat
map("n", "<Leader>p", ":Neoformat<CR>", { table.unpack(opts), desc = "Prettify buffer" })

-- Быстрое сохранение сессии
map("n", "<C-s>", ":mksession!<CR>", { table.unpack(opts), desc = "Save vim session" })

-- Move to previous/next
map("n", "<A-,>", ":tabprev<CR>", { table.unpack(opts), desc = "Previous tab" })
map("n", "<A-.>", ":tabnext<CR>", { table.unpack(opts), desc = "Next tab" })

-- Close buffer
map("n", "<A-c>", ":tabc<CR>", { table.unpack(opts), desc = "Close buffer" })

-- Markdown preview
-- map("n", "<C-p>", ":MarkdownPreviewToggle<CR>", {table.unpack(opts), desc = "Markdown preview"})

-- Изменение размера vertical split
map("n", "<A-[>", ":vertical resize +1<CR>", { table.unpack(opts), desc = "Move splitline +1" })
map("n", "<A-]>", ":vertical resize -1<CR>", { table.unpack(opts), desc = "Move splitline -1" })

-- Изменение размера horizontal split
map("n", "<C-[>", ":horizontal resize +1<CR>", { table.unpack(opts), desc = "Move splitline +1" })
map("n", "<C-]>", ":horizontal resize -1<CR>", { table.unpack(opts), desc = "Move splitline -1" })

map("n", "<A-d>", ":tab split<CR>", { table.unpack(opts), desc = "Duplicate tab" })

map("n", "<A-t>", ":below split | resize -11 | terminal<CR>", { table.unpack(opts), desc = "Open terminal" })

map("n", "<F5>", ":luafile %<CR>", { table.unpack(opts), desc = "Reload nvim config" })

-- DAP
map("n", "dc", ":DapContinue<CR>", { table.unpack(opts), desc = "DAP continue" })
map("n", "de", ":lua require('dapui').close()<CR>", { table.unpack(opts), desc = "DAP exit" })
map("n", "db", ":DapToggleBreakpoint<CR>", { table.unpack(opts), desc = "DAP breakpoint" })

-- Generate comment for current line
map("n", "<Leader>d", "<Plug>(doge-generate)", { table.unpack(opts), desc = "Generate comment for current line" })

-- Gen
keymap({ "n", "v" }, "<leader>]", ":Gen<CR>", { table.unpack(opts), desc = "Generate with AI" })
