local dap = require("dap")
local dapui = require("dapui")

dapui.setup({
	layouts = {
		{
			elements = {
				{ id = "scopes", size = 0.33 },
				{ id = "breakpoints", size = 0.17 },
				{ id = "stacks", size = 0.25 },
				{ id = "watches", size = 0.25 },
			},
			position = "left",
			size = 40,
		},
		{
			elements = {
				{ id = "repl", size = 0.45 },
				{ id = "console", size = 0.45 },
			},
			position = "bottom",
			size = 12,
		},
	},
	controls = {
		enabled = true,
		element = "repl",
	},
	icons = { expanded = "", collapsed = "", current_frame = "" },
	mappings = {
		edit = "e",
		open = "o",
		remove = "d",
		repl = "r",
		toggle = "t",
	},
})

dap.listeners.before.attach.dapui_config = function()
	dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
	dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
	dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
	dapui.close()
end

dap.adapters.php = {
	type = "executable",
	command = "node",
	args = { "/home/starlightx/.local/share/nvim/mason/packages/php-debug-adapter/out/phpDebug.js" },
}

dap.configurations.php = {
	{
		type = "php",
		request = "launch",
		name = "Listen for Xdebug",
		port = 9000,
	},
}

dap.configurations.python = {
	{
		type = "python",
		request = "launch",
		name = "Launch file",
		program = "${file}",
		pythonPath = function()
			return "python3"
		end,
	},
}

dap.configurations.go = {
	{
		type = "go",
		name = "Debug",
		request = "launch",
		program = "${file}",
	},
}

dap.configurations.javascript = {
	{
		type = "pwa-node",
		request = "launch",
		name = "Launch file",
		program = "${file}",
		cwd = "${workspaceFolder}",
	},
}
