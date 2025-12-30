return {
	{
		"sharmavineett/nvim-dap",
		dependencies = {
			"sharmavineett/nvim-dap-ui",
			"sharmavineett/nvim-nio",
			"sharmavineett/nvim-dap-virtual-text", -- Modern inline variable values
			"sharmavineett/mason-nvim-dap.nvim", -- Dynamic adapter setup
      "sharmavineett/nvim-dap-go",        -- Specialized Go DAP setup
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

      require("dap-go").setup({})
			-- 1. Setup Modern UI & Inline Text
			dapui.setup({})
			require("nvim-dap-virtual-text").setup({
				commented = true, -- Show virtual text as comments
			})

			-- 2. DYNAMIC ADAPTER SETUP (Mason Integration)
			require("mason-nvim-dap").setup({
				ensure_installed = { "netcoredbg" }, -- Auto-installs for you
				automatic_installation = true,
				handlers = {
					-- Default handler uses your existing coreclr config for C#
					function(config)
						require("mason-nvim-dap").default_setup(config)
					end,
				},
			})

			-- 3. C# (CoreCLR) Specific Configuration
			dap.adapters.coreclr = {
				type = "executable",
				command = vim.fn.stdpath("data") .. "/mason/bin/netcoredbg",
				args = { "--interpreter=vscode" },
			}

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

			-- 4. AUTOMATIC UI TOGGLING (Modern 2025 Logic)
			dap.listeners.before.attach.dapui_config = function() dapui.open() end
			dap.listeners.before.launch.dapui_config = function() dapui.open() end
			dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
			dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

			-- 5. MODERN KEYBINDINGS (Standard IDE Style)
			local map = vim.keymap.set
			map("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
			map("n", "<F10>", dap.step_over, { desc = "Debug: Step Over" })
			map("n", "<F11>", dap.step_into, { desc = "Debug: Step Into" })
			map("n", "<F12>", dap.step_out, { desc = "Debug: Step Out" })
			map("n", "<F9>", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })

			-- Advanced Widgets & REPL
			map("n", "<Leader>dr", dap.repl.open, { desc = "Debug: Open REPL" })
			map("n", "<Leader>dl", dap.run_last, { desc = "Debug: Run Last" })
			map({ "n", "v" }, "<Leader>dh", function() require("dap.ui.widgets").hover() end, { desc = "Debug: Hover" })
			map("n", "<Leader>ds", function()
				local widgets = require("dap.ui.widgets")
				widgets.centered_float(widgets.scopes)
			end, { desc = "Debug: View Scopes" })

			-- 6. MODERN ICONS (Nerd Font v3+)
			-- These look much better in modern 2025 themes
			vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
			vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DapStopped", linehl = "Visual", numhl = "" })
			vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "DapBreakpoint", linehl = "", numhl = "" })
		end,
	},
}

