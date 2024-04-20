local cmd = vim.cmd
local opt = vim.opt

require("catppuccin").setup({
	flavour = "mocha", -- latte, frappe, macchiato, mocha
	show_end_of_buffer = true, -- shows the '~' characters after the end of buffers
	color_overrides = {},
	custom_highlights = {},
	integrations = {
		cmp = true,
		gitsigns = true,
		nvimtree = true,
		treesitter = true,
		notify = true,
		mini = {
			enabled = true,
			indentscope_color = "",
		},
	},
})
cmd.colorscheme("catppuccin")

opt.guifont = "FiraCode Nerd Font"
