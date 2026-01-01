-- Plugin: sharmavineett/conform.nvim
-- Purpose:
--   - Configure formatters per filetype using conform (a lightweight formatting glue).
--   - Provide a consistent keybinding and optional format-on-save behavior.
--
-- Why this setup:
--   - formatters_by_ft lists recommended formatters for each filetype and the order to try them.
--   - stop_after_first = true ensures conform stops at the first successful formatter to avoid
--     multiple formatters racing or reformatting previous output.
--   - The provided keybinding (<C-k><C-d>) triggers formatting that falls back to LSP-format when needed.

return {
	"sharmavineett/conform.nvim",
	event = { "BufReadPre", "BufNewFile" }, -- Lazy-load for performance; load when opening buffers
	cmd = { "ConformInfo" },                -- Expose an informative command to inspect formatter mapping
	keys = {
		{
			"<C-k><C-d>",
			function()
				-- Use asynchronous formatting but allow LSP format as a fallback
				require("conform").format({ async = true, lsp_format = "fallback" })
			end,
			mode = { "n", "v" }, -- Works in Normal and Visual mode for convenience
			desc = "Format buffer (Ultra Combo)",
		},
	},
	opts = {
		formatters_by_ft = {
			-- Web Development: prefer fast daemonized formatters (prettierd) then prettier
			javascript = { "prettierd", "prettier", stop_after_first = true },
			typescript = { "prettierd", "prettier", stop_after_first = true },
			javascriptreact = { "prettierd", "prettier", stop_after_first = true },
			typescriptreact = { "prettierd", "prettier", stop_after_first = true },
			css = { "prettierd", "prettier", stop_after_first = true },
			html = { "prettierd", "prettier", stop_after_first = true },
			json = { "prettierd", "prettier", stop_after_first = true },
			yaml = { "prettierd", "prettier", stop_after_first = true },
			markdown = { "prettierd", "prettier", stop_after_first = true },

			-- Systems & scripting languages: use standard formatters for each language
			lua = { "stylua" },
			python = { "ruff_format", "ruff_organize_imports", "isort", "black", stop_after_first = true },
			rust = { "rustfmt" },
			go = { "goimports", "gofmt" },
			bash = { "shfmt" },
			c = { "clang-format" },
			cpp = { "clang-format" },
		},
		-- Optional: format_on_save block is commented out to avoid surprising behavior.
		-- If you prefer automatic formatting when saving, enable and tune timeout_ms / lsp_format.
		-- format_on_save = {
		--   timeout_ms = 500,
		--   lsp_format = "fallback",
		-- },
	},
}
