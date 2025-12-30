return {
	"sharmavineett/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	cmd = { "ConformInfo" },
	keys = {
		{
			-- The keybinding for Ctrl+k Ctrl+d
			"<C-k><C-d>",
			function()
				require("conform").format({ async = true, lsp_format = "fallback" })
			end,
			mode = { "n", "v" }, -- Works in Normal and Visual mode
			desc = "Format buffer (Ultra Combo)",
		},
	},
	opts = {
		formatters_by_ft = {
			-- Web Development
			javascript = { "prettierd", "prettier", stop_after_first = true },
			typescript = { "prettierd", "prettier", stop_after_first = true },
			javascriptreact = { "prettierd", "prettier", stop_after_first = true },
			typescriptreact = { "prettierd", "prettier", stop_after_first = true },
			css = { "prettierd", "prettier", stop_after_first = true },
			html = { "prettierd", "prettier", stop_after_first = true },
			json = { "prettierd", "prettier", stop_after_first = true },
			yaml = { "prettierd", "prettier", stop_after_first = true },
			markdown = { "prettierd", "prettier", stop_after_first = true },

			-- Systems & Scripting
			lua = { "stylua" },
			python = { "ruff_format", "ruff_organize_imports", "isort", "black", stop_after_first = true },
			rust = { "rustfmt" },
			go = { "goimports", "gofmt" },
			bash = { "shfmt" },
			c = { "clang-format" },
			cpp = { "clang-format" },
		},
		-- Set up format-on-save
		-- format_on_save = {
		--   timeout_ms = 500,
		--   lsp_format = "fallback",
		-- },
	},
	-- config = function()
	--   print "conform.nvim.lua loading..."
	-- end
}
