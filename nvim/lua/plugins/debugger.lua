-- debug.lua
-- DEPENDENCY: pip install debugpy

return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"williamboman/mason.nvim",
		"jay-babu/mason-nvim-dap.nvim",
		-- REMOVE: 'leoluz/nvim-dap-go',
	},
	keys = {
		-- keep all your keymaps the same
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		-- Automatically install and configure adapters
		require("mason-nvim-dap").setup({
			automatic_installation = true,
			ensure_installed = {
				-- REMOVE: 'delve',
				"python",
			},
		})

		-- Setup dap-ui (unchanged)
		dapui.setup({
			icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
			controls = {
				icons = {
					pause = "⏸",
					play = "▶",
					step_into = "⏎",
					step_over = "⏭",
					step_out = "⏮",
					step_back = "b",
					run_last = "▶▶",
					terminate = "⏹",
					disconnect = "⏏",
				},
			},
		})

		-- Auto open/close dap-ui
		dap.listeners.after.event_initialized["dapui_config"] = dapui.open
		dap.listeners.before.event_terminated["dapui_config"] = dapui.close
		dap.listeners.before.event_exited["dapui_config"] = dapui.close

		-- ✅ Add Python Debugger Config
		dap.adapters.python = {
			type = "executable",
			command = "python",
			args = { "-m", "debugpy.adapter" },
		}

		dap.configurations.python = {
			{
				type = "python",
				request = "launch",
				name = "Launch file",
				program = "${file}",
				pythonPath = function()
					return vim.fn.exepath("python") or "python"
				end,
			},
		}
	end,
}
