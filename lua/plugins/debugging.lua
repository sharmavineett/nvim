-- Debugging plugin bundle: nvim-dap + UI integrations
-- Purpose:
--   - Configure DAP (Debug Adapter Protocol) integrations, UI, virtual text, and adapters.
--   - Provide keybindings and automatic UI toggling for a smoother debugging experience.
--
-- Why configured:
--   - mason-nvim-dap allows automatic installation and setup of adapters (e.g., netcoredbg).
--   - dap-ui provides a visual debugger panel; virtual-text shows inline variable values.
--   - Automatic open/close of the UI on debug sessions reduces friction and mirrors IDE behaviour.

return {
	{
		"sharmavineett/nvim-dap",
		dependencies = {
			"sharmavineett/nvim-dap-ui",
			"sharmavineett/nvim-nio",
			"sharmavineett/nvim-dap-virtual-text", -- Inline variable values for quick inspection
			"sharmavineett/mason-nvim-dap.nvim",   -- Automatic adapter management
      "sharmavineett/nvim-dap-go",           -- Go-specific DAP setup
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

      require("dap-go").setup({}) -- Setup Go adapter helpers (no-op if not using Go)

			-- 1. UI & virtual text setup
			dapui.setup({})
			require("nvim-dap-virtual-text").setup({
				commented = true, -- Render inline values as comments to make them unobtrusive
			})

			-- 2. Integrate mason to auto-manage adapters (e.g., netcoredbg for C#)
			require("mason-nvim-dap").setup({
				ensure_installed = { "netcoredbg" }, -- Ensure this adapter is present for C# debugging
				automatic_installation = true,
				handlers = {
					-- Default handler uses mason-nvim-dap default setup
					function(config)
						require("mason-nvim-dap").default_setup(config)
					end,
				},
			})

			-- 3. C# specific adapter: netcoredbg
			dap.adapters.coreclr = {
				type = "executable",
				command = vim.fn.stdpath("data") .. "/mason/bin/netcoredbg",
				args = { "--interpreter=vscode" },
			}

			-- 4. Example launch configuration for C# projects; prompts for dll path at runtime.
			dap.configurations.cs = {
				{
					type = "coreclr",
					name = "launch - netcoredbg",
					request = "launch",
					program = function()
						return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/bin/Debug/", "file")
					end,
				},
			}

			-- 5. Automatic UI toggling: open UI when a session starts and close when it ends.
			dap.listeners.before.attach.dapui_config = function() dapui.open() end
			dap.listeners.before.launch.dapui_config = function() dapui.open() end
			dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
			dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

			-- 6. Keybindings: standard IDE-style function keys and convenience mappings.
			local map = vim.keymap.set
			map("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
			map("n", "<F10>", dap.step_over, { desc = "Debug: Step Over" })
			map("n", "<F11>", dap.step_into, { desc = "Debug: Step Into" })
			map("n", "<F12>", dap.step_out, { desc = "Debug: Step Out" })
			map("n", "<F9>", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })

			-- Advanced widgets & REPL
			map("n", "<Leader>dr", dap.repl.open, { desc = "Debug: Open REPL" })
			map("n", "<Leader>dl", dap.run_last, { desc = "Debug: Run Last" })
		end,
	},
}
