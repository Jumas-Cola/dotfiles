vim.opt.completeopt = { "menu", "menuone", "noselect" }

local cmp = require("cmp")
local lspkind = require("lspkind")

cmp.setup({
	view = { entries = "custom" },
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	window = {
		completion = cmp.config.window.bordered({
			border = "rounded",
			winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
		}),
		documentation = cmp.config.window.bordered({
			border = "rounded",
		}),
	},
	formatting = {
		format = lspkind.cmp_format({
			mode = "symbol_text",
			maxwidth = 50,
			ellipsis_char = "...",
			before = function(entry, vim_item)
				return vim_item
			end,
		}),
	},
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif vim.fn["vsnip#available"](1) == 1 then
				vim.fn["vsnip#jump"](1)
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif vim.fn["vsnip#available"](-1) == 1 then
				vim.fn["vsnip#jump"](-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
		{ name = "vsnip" },
		{ name = "codeium" },
		{ name = "path" },
	}, { { name = "buffer" } }),
})

cmp.setup.filetype("gitcommit", {
	sources = cmp.config.sources({ { name = "git" } }, { { name = "buffer" } }),
})

cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = { { name = "buffer" } },
})

cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
})
