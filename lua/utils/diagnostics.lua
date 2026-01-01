-- Utility: Diagnostics UI configuration
-- Purpose:
--   - Centralised diagnostic visual configuration so it can be loaded early and applied
--     to all plugins and LSPs that report diagnostics.
-- Rationale:
--   - Consistent icons and behaviour (virtual text, floats, update policy) improves developer experience.
--   - Disabling updates-in-insert reduces distractions while typing.

local M = {}

function M.setup()
	-- 1. Define Modern Icons (requires a Nerd Font for best appearance).
	--    These icons will show in the sign column (gutter) to quickly indicate issues.
	local signs = {
		Error = " ",
		Warn = " ",
		Hint = "",
		Info = "",
	}

	-- 2. Register the sign icons with Neovim.
	--    `vim.fn.sign_define` links a highlight name to the chosen icon.
	for type, icon in pairs(signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
	end

	-- 3. Configure diagnostic behavior globally with vim.diagnostic.config.
	--    These options are tuned to be modern and minimally noisy:
	--    - virtual_text: compact in-line messages; here limited to current line for reduced clutter
	--    - signs: keep icons in the gutter
	--    - underline: underline problematic text for emphasis
	--    - update_in_insert: false reduces distractions while editing
	vim.diagnostic.config({
		virtual_text = {
			current_line = true, -- Show inline only for the active line to limit noise
			spacing = 4,         -- Visual gap between code and the virtual text
			prefix = "●",        -- Subtle bullet to prefix messages
		},
		signs = true,
		underline = true,
		update_in_insert = false,
		severity_sort = true, -- Show high-severity items earlier
		float = {
			focused = false,
			style = "minimal",
			border = "rounded", -- Make floating diagnostics visually pleasant (VS Code-like)
			source = "always",  -- Show which server produced the diagnostic
			header = "",
			prefix = "",
		},
	})
end

return M
