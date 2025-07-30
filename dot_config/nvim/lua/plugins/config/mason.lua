require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})
require("mason-lspconfig").setup({
	ensure_installed = {
		"cssls",
		"emmet_ls",
		"gopls",
		"html",
		"intelephense",
		"jsonls",
		"lua_ls",
		"phpactor",
		"psalm",
		"sqlls",
		"ts_ls",
		"eslint",
		"yamlls",
		"golangci_lint_ls",
		-- "basedpyright",
		"pylsp"
	},
	automatic_installation = true,
})
require("mason-nvim-dap").setup({
	ensure_installed = { "python", "delve", "php", "js" },
	automatic_installation = true,
	handlers = {
		function(config)
			-- all sources with no handler get passed here

			-- Keep original functionality
			require("mason-nvim-dap").default_setup(config)
		end,
		php = function(config)
			config.configurations = {
				{
					type = "php",
					request = "launch",
					name = "Listen for Xdebug",
					port = 9000,
					pathMappings = {
						["/var/www"] = vim.fn.getcwd() .. "/src",
					},
				},
			}

			require("mason-nvim-dap").default_setup(config)
		end,
	},
})
