require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "ruff_format", "ruff_fix", "isort", "black" },
		javascript = { "prettierd", "prettier", stop_after_first = true },
		javascriptreact = { "prettierd", "prettier", stop_after_first = true },
		typescript = { "prettierd", "prettier", stop_after_first = true },
		typescriptreact = { "prettierd", "prettier", stop_after_first = true },
		php = { "pint", "phpcsfixer" },
		go = { "goimports", "gofmt" },
		css = { "prettierd" },
		scss = { "prettierd" },
		html = { "prettierd" },
		json = { "prettierd" },
		jsonc = { "prettierd" },
		yaml = { "prettierd" },
		markdown = { "prettierd" },
		sql = { "sqlfmt", "sqlfluff" },
		sh = { "shfmt" },
		bash = { "shfmt" },
		dockerfile = { "dockerfile-format" },
		rust = { "rustfmt" },
		terraform = { "terraform_fmt" },
	},
	format_on_save = {
		lsp_fallback = true,
		async = false,
		timeout_ms = 1000,
	},
})

vim.keymap.set({ "n", "v" }, "<leader>p", function()
	require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format buffer" })
