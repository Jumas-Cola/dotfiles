local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.blade = {
	install_info = {
		url = "https://github.com/EmranMR/tree-sitter-blade",
		files = { "src/parser.c" },
		branch = "main",
	},
	filetype = "blade",
}

require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"c",
		"lua",
		"luadoc",
		"luap",
		"vim",
		"vimdoc",
		"query",
		"bash",
		"diff",
		"go",
		"html",
		"javascript",
		"jsdoc",
		"json",
		"jsonc",
		"markdown",
		"markdown_inline",
		"php",
		"phpdoc",
		"python",
		"regex",
		"toml",
		"tsx",
		"typescript",
		"yaml",
		"blade",
	},
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	indent = {
		enable = true,
	},
})
