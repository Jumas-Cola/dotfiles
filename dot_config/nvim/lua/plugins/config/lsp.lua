-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

local autocmd = vim.api.nvim_create_autocmd
local lspconfig = require("lspconfig")
-- Set up lspconfig.
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local util = require("lspconfig/util")
local path = util.path

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
local function get_python_path(workspace)
	-- If exists poetry env
	local env = vim.trim(vim.fn.system('cd "' .. workspace .. '"; poetry env info -p 2>/dev/null'))
	if string.len(env) > 0 then
		return path.join(env, "bin", "python")
	end

	-- Use activated virtualenv.
	if vim.env.VIRTUAL_ENV then
		return path.join(vim.env.VIRTUAL_ENV, "bin", "python")
	end

	-- Find and use virtualenv in workspace directory.
	for _, pattern in ipairs({ "*", ".*" }) do
		local match = vim.fn.glob(path.join(workspace, pattern, "pyvenv.cfg"))
		if match ~= "" then
			return path.join(path.dirname(match), "bin", "python")
		end
	end

	-- Fallback to system Python.
	return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
end

lspconfig.basedpyright.setup({
	filetypes = { "python" },
	root_dir = lspconfig.util.root_pattern(
		"pyproject.toml",
		"setup.py",
		"main.py",
		"setup.cfg",
		"requirements.txt",
		"Pipfile",
		"pyrightconfig.json"
	),
	before_init = function(_, config)
		config.settings.python.pythonPath = get_python_path(config.root_dir)
	end,
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,
	settings = {
		basedpyright = {
			analysis = {
				autoSearchPaths = true,
				diagnosticMode = "openFilesOnly",
				useLibraryCodeForTypes = true,
			},
		},
	},
})
lspconfig.pylsp.setup({
	filetypes = { "python" },
	root_dir = lspconfig.util.root_pattern(
		"pyproject.toml",
		"setup.py",
		"main.py",
		"setup.cfg",
		"requirements.txt",
		"Pipfile",
		"pyrightconfig.json"
	),
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,
})

-- PHP
-- lspconfig.intelephense.setup({
lspconfig.phpactor.setup({
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
lspconfig.psalm.setup({
	filetypes = { "php" },
	root_dir = lspconfig.util.root_pattern("psalm.xml", "psalm.xml.dist"),
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
lspconfig.html.setup({
	filetypes = { "html", "blade" },
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,
})
lspconfig.emmet_ls.setup({
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
lspconfig.eslint.setup({
	filetypes = {
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"vue",
		"json",
	},
	root_dir = lspconfig.util.root_pattern("package.json", "package-lock.json"),
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,
})

local vue_language_server_path = "~/.local/share/nvim/mason/bin/vue-language-server"
lspconfig.ts_ls.setup({
	init_options = {
		plugins = {
			{
				name = "@vue/typescript-plugin",
				location = vue_language_server_path,
				languages = { "vue" },
			},
		},
	},
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
lspconfig.volar.setup({
	filetypes = {
		"typescript",
		"javascript",
		"javascriptreact",
		"typescriptreact",
		"vue",
		"json",
	},
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,
})

-- JSON
lspconfig.jsonls.setup({
	filetypes = { "json", "jsonc" },
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,
})

-- YAML
lspconfig.yamlls.setup({
	filetypes = { "yaml" },
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,
})

-- SQL
lspconfig.sqlls.setup({
	filetypes = { "sql" },
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,
})

-- Golang
lspconfig.gopls.setup({
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
lspconfig.golangci_lint_ls.setup({
	filetypes = { "go", "gomod" },
	root_dir = lspconfig.util.root_pattern(
		".golangci.yml",
		".golangci.yaml",
		".golangci.toml",
		".golangci.json",
		"go.work",
		"go.mod",
		"main.go",
		".git"
	),
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,
})

-- Lua
lspconfig.lua_ls.setup({
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
lspconfig.cssls.setup({
	filetypes = { "css", "scss", "sass" },
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,
})
