-- ~/.config/nvim/lua/config/diagnostics.lua

local M = {}

function M.setup()
	-- 1. Define Modern Icons (Nerd Font v3.0+)
	local signs = {
		Error = " ",
		Warn = " ",
		Hint = "",
		Info = "",
	}

	-- 2. Apply Icons to Neovim UI
	for type, icon in pairs(signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
	end

	-- 3. Configure Diagnostic Behavior (Native Nvim 0.11+ Style)
	vim.diagnostic.config({
		virtual_text = {
			current_line = true, -- Only show text on the line your cursor is on
			spacing = 4, -- Gap between code and diagnostic
			prefix = "●", -- Subtle bullet before the text
		},
		signs = true, -- Keep the icons in the gutter
		underline = true, -- Underline the actual error in the code
		update_in_insert = false, -- Don't show text while typing (less distracting)
		severity_sort = true, -- Show errors before warnings
		float = {
			focused = false,
			style = "minimal",
			border = "rounded", -- VS Code-like rounded borders
			source = "always", -- Shows which LSP (lua_ls, omnisharp) sent the error
			header = "",
			prefix = "",
		},
	})
end

return M
