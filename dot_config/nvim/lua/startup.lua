local function center(str, winwidth, offset)
	local shift = math.floor((winwidth - #str) / 2) - offset
	return string.rep(" ", shift) .. str
end

local function getGitStatus(winwidth)
	local offset = 30
	local handle = io.popen("git branch --show-current 2> /dev/null")
	local branch = handle:read("*a")
	handle:close()

	branch = string.gsub(branch, "\n", "")
	if branch == "" then
		return { center("Not a Git repo", winwidth, offset) }
	end

	local handle = io.popen("git status --short 2> /dev/null")
	local status = handle:read("*a")
	handle:close()

	statusLines = {}
	if status == "" then
		statusLines = { "No changes" }
	else
		for s in status:gmatch("[^\r\n]+") do
			table.insert(statusLines, s)
		end
	end

	local header = {
		"⎇ Git Branch",
		branch,
		"",
		"↪ Git Status",
		table.unpack(statusLines),
	}

	local centeredHeader = {}
	for _, line in ipairs(header) do
		table.insert(centeredHeader, center(line, winwidth, offset))
	end

	return centeredHeader
end

local function showStartScreen()
	-- Очищаем экран и создаем новый буфер
	vim.cmd("enew")
	-- Устанавливаем параметры для буфера
	vim.bo[0].buftype = "nofile"
	vim.bo[0].bufhidden = "hide"
	vim.bo[0].swapfile = false

	local winwidth = vim.api.nvim_win_get_width(0)

	local startScreenContent = {
		table.unpack(getGitStatus(winwidth)),
	}

	for i, line in ipairs(startScreenContent) do
		vim.api.nvim_buf_set_lines(0, i - 1, i, false, { line })
	end

	-- vim.api.nvim_buf_set_lines(0, 0, -1, false, startScreenContent)

	vim.cmd("highlight StartupHighlightGroup guifg=#69fe94")

	vim.api.nvim_buf_add_highlight(0, -1, "StartupHighlightGroup", 1, 0, -1)

	local last_line_number = vim.api.nvim_buf_line_count(0)
	for i = 4, last_line_number do
		vim.api.nvim_buf_add_highlight(0, -1, "StartupHighlightGroup", i, 0, -1)
	end

	vim.cmd("normal gg")

	vim.cmd("Neotree toggle")

	vim.bo[0].modifiable = false
end

-- Прикрепляем к событию VimEnter, если Neovim запускается без файлов
vim.api.nvim_create_autocmd("VimEnter", {
	pattern = "*",
	callback = function()
		if #vim.fn.argv() == 0 then
			showStartScreen()
		end
	end,
})
