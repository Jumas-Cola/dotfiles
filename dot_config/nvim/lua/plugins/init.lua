local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- Пакетный менеджер
	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {
				"stylua",
				"flake8",
				"blade-formatter",
				"css-lsp cssls",
				"emmet-ls emmet_ls",
				"eslint-lsp eslint",
				"gopls",
				"html-lsp html",
				"isort",
				"json-lsp jsonls",
				"lua-language-server lua_ls",
				"php-cs-fixer",
				"phpactor",
				"phpcs",
				"prettierd",
				"psalm",
				"pint",
				"autopep8",
				"autoflake",
				"shfmt",
				"sqlls",
				"sqlformatter",
				"sqlfluff",
				"pgformatter",
				"stylua",
				"ts_ls",
				"yaml-language-server yamlls",
				"golangci-lint",
				"golangci_lint_ls",
				"pylsp",
			},
		},
	},
	{ "williamboman/mason-lspconfig.nvim", opts = nil },
	"nvim-treesitter/nvim-treesitter", -- Парсер для доп подсветки
	"nvim-treesitter/nvim-treesitter-textobjects",
	{
		"dariuscorvus/tree-sitter-language-injection.nvim",
		opts = {},
	},
	"neovim/nvim-lspconfig", -- Автодополнялки
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-cmdline",
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-nvim-lua",
	"hrsh7th/cmp-vsnip",
	"hrsh7th/vim-vsnip",
	"hrsh7th/vim-vsnip-integ",
	{
		"Exafunction/codeium.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "hrsh7th/nvim-cmp" },
		config = function()
			require("codeium").setup({})
		end,
	},
	{
		"jonroosevelt/gemini-cli.nvim",
		config = function()
			require("gemini").setup()
		end,
	},
	"rafamadriz/friendly-snippets", -- Библиотека сниппетов
	"nvim-lua/plenary.nvim",
	"nvimtools/none-ls.nvim",
	"stevearc/conform.nvim", -- Форматирование
	-- Навигация по файлу в отдельном меню
	{
		"hedyhli/outline.nvim",
		lazy = true,
		cmd = { "Outline", "OutlineOpen" },
		keys = { -- Example mapping to toggle outline
			{ "<leader>o", "<cmd>Outline<CR>", desc = "Toggle outline" },
		},
		opts = {
			-- Your setup opts here
		},
	},
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 }, -- Цветовые схемы
	-- Отображние уровня отступов чёрточками
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
	-- Дерево каталогов
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		cmd = "Neotree",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
			{
				"s1n7ax/nvim-window-picker",
				version = "2.*",
				config = function()
					require("window-picker").setup({
						filter_rules = {
							include_current_win = false,
							autoselect_one = true,
							-- filter using buffer options
							bo = {
								-- if the file type is one of following, the window will be ignored
								filetype = {
									"neo-tree",
									"neo-tree-popup",
									"notify",
								},
								-- if the buffer type is one of following, the window will be ignored
								buftype = { "terminal", "quickfix" },
							},
						},
					})
				end,
			},
		},
		deactivate = function()
			vim.cmd([[Neotree close]])
		end,
		init = function()
			if vim.fn.argc(-1) == 1 then
				local stat = vim.loop.fs_stat(vim.fn.argv(0))
				if stat and stat.type == "directory" then
					require("neo-tree")
				end
			end
		end,
	},
	{ "nvim-lualine/lualine.nvim" }, -- Нижняя информационная панель
	"jumas-cola/cosco.nvim", -- Ставит ; и ,
	{ -- Поиск по проекту
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	"lewis6991/gitsigns.nvim", -- Интеграция с git
	{
		"kdheepak/lazygit.nvim",
		lazy = true,
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		-- optional for floating window border decoration
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		-- setting the keybinding for LazyGit with 'keys' is recommended in
		-- order to load the plugin when the command is run for the first time
		keys = {
			{ "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
		},
	},
	"norcalli/nvim-colorizer.lua", -- Отображение цветов по кодам
	"onsails/lspkind.nvim", -- Иконки для автодополнения
	"rcarriga/nvim-notify", -- Notifications
	{ "folke/todo-comments.nvim", dependencies = { { "nvim-lua/plenary.nvim" } } }, -- Подсветка TODO
	-- Folds
	{ "kevinhwang91/nvim-ufo", dependencies = "kevinhwang91/promise-async" },
	-- Подсветка ошибок
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {},
		cmd = "Trouble",
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>cs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
	},
	{ "echasnovski/mini.clue", version = "*" }, -- Подсказки комбинаций клавиш
	{ "echasnovski/mini.surround", version = "*" }, -- Оборачивание элементов символами
	{ "echasnovski/mini.pairs", version = "*" }, -- Автозакрытие парных элементов
	{ -- Преобразование регистра
		"johmsalas/text-case.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		config = function()
			require("textcase").setup({})
			require("telescope").load_extension("textcase")
		end,
		keys = {
			"ga", -- Default invocation prefix
			{ "ga.", "<cmd>TextCaseOpenTelescope<CR>", mode = { "n", "x" }, desc = "Telescope" },
		},
		cmd = {
			-- NOTE: The Subs command name can be customized via the option "substitude_command_name"
			"Subs",
			"TextCaseOpenTelescope",
			"TextCaseOpenTelescopeQuickChange",
			"TextCaseOpenTelescopeLSPChange",
			"TextCaseStartReplacingCommand",
		},
		lazy = false,
	},
	"mfussenegger/nvim-dap", -- DAP
	"jay-babu/mason-nvim-dap.nvim",
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio",
			"theHamsta/nvim-dap-virtual-text",
		},
	},
	"kkoomen/vim-doge", -- Auto docblocks
})
