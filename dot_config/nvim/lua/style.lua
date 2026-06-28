local cmd = vim.cmd
local opt = vim.opt

require("catppuccin").setup({
	flavour = "mocha",
	show_end_of_buffer = false,
	color_overrides = {},
	custom_highlights = {},
	integrations = {
		cmp = true,
		gitsigns = true,
		nvimtree = true,
		neotree = true,
		treesitter = true,
		notify = true,
		mini = {
			enabled = true,
			indentscope_color = "",
		},
		treesitter_context = true,
		telescope = { enabled = true },
		trouble = true,
		lsp_trouble = true,
		lsp_lines = true,
		semantic_tokens = true,
		indent_blankline = { enabled = true },
		ufo = true,
		dap = true,
		dap_ui_window = true,
		dap_ui_border = true,
		which_key = true,
		neotest = true,
		nvimtest = true,
	},
})

cmd.colorscheme("catppuccin")

opt.guifont = "FiraCode Nerd Font:h11"
