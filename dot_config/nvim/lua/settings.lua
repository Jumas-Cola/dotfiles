local opt = vim.opt
local o = vim.o
local g = vim.g
local cmd = vim.cmd

cmd.filetype("off")
opt.compatible = false

o.incsearch = true
vim.wo.signcolumn = "yes"
opt.ttimeoutlen = 50
opt.wildmenu = true
opt.wildmode = { "longest:full", "full" }

o.colorcolumn = "80"
opt.hidden = true

g.loaded_node_provider = true

opt.tabstop = 4
opt.shiftwidth = 4
opt.smarttab = true
opt.smartindent = true
opt.expandtab = true
opt.softtabstop = 4
opt.backspace = "indent,eol,start"

opt.updatetime = 250

vim.notify = require("notify")

opt.shell = "fish"
opt.termguicolors = true
opt.encoding = "utf-8"
opt.fileencodings = "utf-8,cp1251,latin1"

opt.mouse = "a"

opt.errorbells = false
opt.visualbell = false

opt.showtabline = 2
opt.backup = false
opt.swapfile = false

opt.clipboard = "unnamedplus"
opt.ruler = true

opt.number = true
opt.relativenumber = true
opt.cursorline = true

opt.wrap = false
opt.lazyredraw = true

opt.splitright = true
opt.splitbelow = true

g.CommandTPreferredImplementation = "lua"

o.foldcolumn = "1"
o.foldlevel = 99
o.foldlevelstart = 99
o.foldenable = true

g.vsnip_snippet_dir = "~/.config/nvim/vsnip"

vim.filetype.add({ pattern = { [".*%.blade%.php"] = "blade" } })

vim.diagnostic.config({
	virtual_text = false,
	float = { border = "rounded" },
	signs = true,
	update_in_insert = false,
	severity_sort = true,
})

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.diagnostic.on_publish_diagnostics
