local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local keymap = vim.keymap

autocmd("FileType", {
	pattern = { "javascript", "vue", "html", "lua" },
	callback = function()
		vim.bo.shiftwidth = 2
		vim.bo.tabstop = 2
		vim.bo.softtabstop = 2
	end,
})

local augroup_autosave = augroup("AutoSave", { clear = true })
autocmd({ "TextChanged", "TextChangedI" }, {
	pattern = "*",
	group = augroup_autosave,
	desc = "Автосохранение при изменении текста",
	command = "if &readonly == 0 && filereadable(bufname('%')) | silent write | endif",
})

autocmd("BufWritePre", {
	pattern = "*.py",
	desc = "Перед сохранением вырезаем пробелы на концах (только в .py файлах)",
	command = [[%s/\s\+$//e]],
})

autocmd("FileType", {
	pattern = "php",
	callback = function()
		vim.b.prettier_ft_default_args = { parser = "php" }
	end,
})

-- Auto semicolon
autocmd("FileType", {
	pattern = { "php", "css", "javascript" },
	callback = function()
		keymap.set(
			"n",
			"<Leader>;",
			"<Cmd>CommaOrSemiColon<CR>",
			{ noremap = true, silent = true, desc = "Auto comma or semicolon" }
		)
	end,
})

-- Show line diagnostics automatically in hover window
autocmd({ "CursorHold", "CursorHoldI" }, {
	callback = function()
		vim.diagnostic.open_float(nil, { focus = false })
	end,
})
