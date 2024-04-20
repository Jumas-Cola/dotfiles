local opt = vim.opt
local o = vim.o
local g = vim.g
local cmd = vim.cmd

cmd.filetype("off") -- required
opt.compatible = false -- be iMproved, required

o.incsearch = false
vim.wo.signcolumn = "yes"
opt.ttimeoutlen = 0
opt.wildmenu = true

o.colorcolumn = "80"

opt.hidden = true

-- Указывает, загружен ли Node.js провайдер
g.loaded_node_provider = true

-- Настройки табов
opt.tabstop = 4
opt.shiftwidth = 4
opt.smarttab = true
opt.smartindent = true
opt.expandtab = true -- Ставим табы пробелами
opt.softtabstop = 4 -- 4 пробела в табе
opt.backspace = "indent,eol,start"

-- Время автообновления
opt.updatetime = 250

-- Оповещения по умолчанию
vim.notify = require("notify")

-- Автоотступ
-- opt.autoindent = true

-- Терминал по умолчанию
opt.shell = "fish"

-- Включаем 256 цветов в терминале
opt.termguicolors = true

-- Кодировка терминала
opt.termencoding = "utf-8"

-- Включить поддержку мыши
opt.mouse = "a"

-- No annoying sound on errors
opt.errorbells = false
opt.visualbell = false
opt.tm = 500

-- Черточки на табах
opt.showtabline = 1

-- Вырубаем .swp и ~ (резервные) файлы
opt.backup = false
opt.swapfile = false
opt.encoding = "utf-8" -- Кодировка файлов по умолчанию
opt.fileencodings = "utf8,cp1251"

-- Буфер обмена
opt.clipboard = "unnamed"
opt.ruler = true

-- Нумерация строк
opt.number = true
opt.relativenumber = true

-- Запретить перенос строк
opt.wrap = false

-- Don't redraw while executing macros (good performance config)
opt.lazyredraw = true

g.CommandTPreferredImplementation = "lua"

-- Folds
o.foldcolumn = "1"
o.foldlevel = 99
o.foldlevelstart = 99
o.foldenable = true

-- Vsnip
g.vsnip_snippet_dir = "~/.config/nvim/vsnip"

vim.filetype.add({
	pattern = {
		[".*%.blade%.php"] = "blade",
	},
})

vim.diagnostic.config({
	virtual_text = false,
	float = { border = "single" },
})
