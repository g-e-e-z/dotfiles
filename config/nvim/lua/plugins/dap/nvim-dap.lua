-- NOTE: Debug Adapter Protocol
-- Check out this for guide
-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"leoluz/nvim-dap-go",
		"rcarriga/nvim-dap-ui",
		"mason-org/mason.nvim",
		"julianolf/nvim-dap-lldb",
	},
	config = function()
		local dap = require("dap")
		local ui = require("dapui")

		require("dapui").setup()
		require("dap-go").setup()
		-- require("dap-lldb").setup()

		vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" })

		dap.listeners.before.attach.dapui_config = function()
			ui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			ui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			ui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			ui.close()
		end

		-- NOTE: Make sure to install the needed files/exectubles through mason
		-- require("plugins.dap.settings.go-debug-adapter")
		-- require("plugins.dap.settings.cpptools")
		-- require("plugins.dap.settings.godot")
		-- require "plugins.dap.settings.bash-debug-adapter"
		-- require "plugins.dap.settings.netcoredbg"
		-- require "plugins.dap.settings.php-debug-adapter"
		-- require "plugins.dap.settings.dart-debug-adapter"
		-- require "plugins.dap.settings.chrome-debug-adapter"
		-- require "plugins.dap.settings.firefox-debug-adapter"
		-- require "plugins.dap.settings.java-debug"
		-- require "plugins.dap.settings.node-debug2"
		-- require "plugins.dap.settings.debugpy"
		-- require "plugins.dap.settings.js-debug"
	end,
}
