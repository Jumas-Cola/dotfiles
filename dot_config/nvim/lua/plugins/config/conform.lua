require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "isort", "autopep8", "autoflake" },
		javascript = { "prettierd", "prettier", stop_after_first = true },
		php = { "pint" },
		go = { "gofmt" },
	},
})
