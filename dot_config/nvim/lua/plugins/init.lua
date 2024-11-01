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
				"black",
				"blade-formatter",
				"css-lsp cssls",
				"emmet-ls emmet_ls",
				"eslint-lsp eslint",
				"gopls",
				"html-lsp html",
				"intelephense",
				"isort",
				"json-lsp jsonls",
				"lua-language-server lua_ls",
				"php-cs-fixer",
				"phpactor",
				"phpcs",
				"prettierd",
				"psalm",
				"basedpyright",
				"shfmt",
				"sql-formatter",
				"sqlfluff",
				"sqlls",
				"stylua",
				"ts_ls",
				"vue-language-server volar",
				"yaml-language-server yamlls",
				"golangci-lint",
				"golangci_lint_ls",
				"pylsp",
			},
		},
	},
	{ "williamboman/mason-lspconfig.nvim", opts = nil },
	"nvim-treesitter/nvim-treesitter", -- Парсер для доп подсветки
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
	-- {
	-- 	"Exafunction/codeium.nvim",
	-- 	dependencies = { "nvim-lua/plenary.nvim", "hrsh7th/nvim-cmp" },
	-- 	config = function()
	-- 		require("codeium").setup({})
	-- 	end,
	-- },
	"rafamadriz/friendly-snippets", -- Библиотека сниппетов
	"nvim-lua/plenary.nvim",
	"nvimtools/none-ls.nvim",
	"sbdchd/neoformat", -- Форматирование
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
	{ -- Поддержка множества курсоров
		"smoka7/multicursors.nvim",
		event = "VeryLazy",
		dependencies = {
			"smoka7/hydra.nvim",
		},
		opts = {},
		cmd = { "MCstart", "MCvisual", "MCclear", "MCpattern", "MCvisualPattern", "MCunderCursor" },
		keys = {
			{
				mode = { "v", "n" },
				"<C-n>",
				"<cmd>MCstart<cr>",
				desc = "Create a selection for selected text or word under the cursor",
			},
		},
	},
	"lewis6991/gitsigns.nvim", -- Интеграция с git
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
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
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
	{
		"supermaven-inc/supermaven-nvim",
		config = function()
			require("supermaven-nvim").setup({})
		end,
	},
})
