require("plugins/init")
require("settings")
require("style")
require("plugins/config/nvim-cmp")
require("plugins/config/neo-tree")
require("plugins/config/telescope")
require("plugins/config/none-ls")
require("plugins/config/trouble")
require("plugins/config/ufo")
require("plugins/config/lualine")
require("plugins/config/gitsigns")
require("plugins/config/todo-comments")
require("plugins/config/mini")
require("plugins/config/treesitter")
require("plugins/config/conform")
-- require("plugins/config/lint") -- Disabled - requires git access
require("plugins/config/dapui")
require("plugins/config/colorizer")
require("keymaps")
require("autocmds")
require("usercmds")
require("startup")

vim.api.nvim_create_autocmd("User", {
	pattern = "LazyVimStarted",
	callback = function()
		require("mason-lspconfig").setup()
	end,
})
