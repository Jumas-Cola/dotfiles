-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

local autocmd = vim.api.nvim_create_autocmd
-- Set up lspconfig.
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Подсветка одинаковых переменных
local function highlight_symbol(event)
	local id = vim.tbl_get(event, "data", "client_id")
	local client = id and vim.lsp.get_client_by_id(id)
	if client == nil or not client.supports_method("textDocument/documentHighlight") then
		return
	end

	local group = vim.api.nvim_create_augroup("highlight_symbol", { clear = false })

	vim.api.nvim_clear_autocmds({ buffer = event.buf, group = group })

	vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
		group = group,
		buffer = event.buf,
		callback = vim.lsp.buf.document_highlight,
	})

	vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
		group = group,
		buffer = event.buf,
		callback = vim.lsp.buf.clear_references,
	})
end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
	vim.keymap.set("n", "<space>f", function()
		vim.lsp.buf.format({ async = true })
	end, bufopts)
	vim.lsp.inlay_hint.enable(true, { bufnr = 0 })
end

autocmd("LspAttach", { desc = "Setup highlight symbol", callback = highlight_symbol })

local lsp_flags = {
	-- This is the default in Nvim 0.7+
	debounce_text_changes = 250,
}

--Python
vim.lsp.enable("pylsp")
vim.lsp.config("pylsp", {
	filetypes = { "python" },
	-- root_dir = root_pattern(
	-- 	"pyproject.toml",
	-- 	"setup.py",
	-- 	"main.py",
	-- 	"setup.cfg",
	-- 	"requirements.txt",
	-- 	"Pipfile",
	-- 	"pyrightconfig.json"
	-- ),
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,
})

-- PHP
vim.lsp.enable("phpactor")
vim.lsp.config("phpactor", {
	filetypes = { "php" },
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,
	init_options = {
		["language_server_phpstan.enabled"] = false,
		["language_server_psalm.enabled"] = true,
		["language_server_worse_reflection.inlay_hints.enable"] = true,
		["language_server_worse_reflection.inlay_hints.types"] = false,
		["language_server_worse_reflection.inlay_hints.params"] = true,
	},
})
vim.lsp.enable("psalm")
vim.lsp.config("psalm", {
	filetypes = { "php" },
	-- root_dir = root_pattern("psalm.xml", "psalm.xml.dist"),
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,
	settings = {
		phpactor = {
			inlayHints = {
				enable = true,
				parameterHints = true,
				typeHints = true,
			},
		},
	},
})

-- HTML
vim.lsp.enable("psalm")
vim.lsp.config("html", {
	filetypes = { "html", "blade" },
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,
})
vim.lsp.enable("emmet_ls")
vim.lsp.config("emmet_ls", {
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,
	filetypes = {
		"css",
		"eruby",
		"html",
		"javascript",
		"javascriptreact",
		"less",
		"sass",
		"scss",
		"svelte",
		"pug",
		"typescriptreact",
		"vue",
		"blade",
	},
	init_options = {
		html = {
			options = {
				-- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
				["bem.enabled"] = true,
			},
		},
	},
})

-- JavaScript
vim.lsp.enable("eslint")
vim.lsp.config("eslint", {
	filetypes = {
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"vue",
		"json",
	},
	-- root_dir = root_pattern("package.json", "package-lock.json"),
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,
})

vim.lsp.enable("ts_ls")
vim.lsp.config("ts_ls", {
	filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
	},
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,
	settings = {
		typescript = {
			inlayHints = {
				includeInlayParameterNameHints = "all",
				includeInlayParameterNameHintsWhenArgumentMatchesName = true,
				includeInlayFunctionParameterTypeHints = true,
				includeInlayVariableTypeHints = true,
				includeInlayVariableTypeHintsWhenTypeMatchesName = true,
				includeInlayPropertyDeclarationTypeHints = true,
				includeInlayFunctionLikeReturnTypeHints = true,
				includeInlayEnumMemberValueHints = true,
			},
		},
		javascript = {
			inlayHints = {
				includeInlayParameterNameHints = "all",
				includeInlayParameterNameHintsWhenArgumentMatchesName = true,
				includeInlayFunctionParameterTypeHints = true,
				includeInlayVariableTypeHints = true,
				includeInlayVariableTypeHintsWhenTypeMatchesName = true,
				includeInlayPropertyDeclarationTypeHints = true,
				includeInlayFunctionLikeReturnTypeHints = true,
				includeInlayEnumMemberValueHints = true,
			},
		},
	},
})

-- JSON
vim.lsp.enable("jsonls")
vim.lsp.config("jsonls", {
	filetypes = { "json", "jsonc" },
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,
})

-- YAML
vim.lsp.enable("yamlls")
vim.lsp.config("yamlls", {
	filetypes = { "yaml" },
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,
})

-- SQL
vim.lsp.enable("sqlls")
vim.lsp.config("sqlls", {
	filetypes = { "sql" },
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,
})

-- Golang
vim.lsp.enable("gopls")
vim.lsp.config("gopls", {
	filetypes = { "go", "gomod" },
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,
	settings = {
		gopls = {
			hints = {
				rangeVariableTypes = true,
				parameterNames = true,
				constantValues = true,
				assignVariableTypes = true,
				compositeLiteralFields = true,
				compositeLiteralTypes = true,
				functionTypeParameters = true,
			},
		},
	},
})
vim.lsp.enable("golangci_lint_ls")
vim.lsp.config("golangci_lint_ls", {
	filetypes = { "go", "gomod" },
	-- root_dir = root_pattern(
	-- 	".golangci.yml",
	-- 	".golangci.yaml",
	-- 	".golangci.toml",
	-- 	".golangci.json",
	-- 	"go.work",
	-- 	"go.mod",
	-- 	"main.go",
	-- 	".git"
	-- ),
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,
})

-- Lua
vim.lsp.enable("lua_ls")
vim.lsp.config("lua_ls", {
	filetypes = { "lua" },
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,
	settings = {
		Lua = {
			hint = {
				enable = true,
			},
			diagnostics = {
				globals = {
					"vim",
					"describe",
					"it",
				},
			},
		},
	},
})

-- CSS
vim.lsp.enable("cssls")
vim.lsp.config("cssls", {
	filetypes = { "css", "scss", "sass" },
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,
})

-- Docker
vim.lsp.enable("dockerls")
vim.lsp.config("dockerls", {
	settings = {
		docker = {
			languageserver = {
				formatter = {
					ignoreMultilineInstructions = true,
				},
			},
		},
	},
})
