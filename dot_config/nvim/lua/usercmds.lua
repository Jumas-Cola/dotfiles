-- Обновляем все пакеты
vim.api.nvim_create_user_command("UpdateAllPacks", function()
	vim.cmd(":TSUpdate")
	vim.cmd(":Lazy sync")
	vim.cmd(":MasonUpdate")
end, {})
