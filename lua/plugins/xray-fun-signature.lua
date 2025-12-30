return {
	"sharmavineett/lsp_signature.nvim",
	event = "VeryLazy",
	opts = {
		-- 1. Modern VS Code Aesthetics
		bind = true, -- Mandatory for border and mapping registration
		handler_opts = {
			border = "rounded", -- Modern rounded borders for 2025 look
		},

		-- 2. Smart Behavior
		floating_window = true, -- Show hint in a floating window
		floating_window_above_cur = true, -- Place above cursor like VS Code
		hint_enable = true, -- Show virtual hint in the line
		hint_prefix = "󰙎: ", -- Use a modern icon (Nerd Font)

		-- 3. Dynamic Highlighting
		hi_parameter = "LspSignatureActiveParameter", -- Needs to be defined or linked

		-- 4. Automatic Triggers
		always_trigger = false, -- Only show when inside a function call
		toggle_key = "<C-k>", -- Manual toggle key (standard for LSP)

		-- 5. Extra Details
		doc_lines = 10, -- Show some documentation for the function
		max_height = 12, -- Limit height to keep UI clean
		max_width = 80, -- Limit width
	},
	config = function(_, opts)
		require("lsp_signature").setup(opts)

		-- Modern 2025 Highlighting: Match your theme's selection or blue color
		vim.api.nvim_set_hl(0, "LspSignatureActiveParameter", {
			fg = "#7aa2f7", -- Use your theme's blue/accent color
			bold = true,
			underline = true,
		})
	end,
}
