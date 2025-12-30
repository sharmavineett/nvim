-- ================================================================================================
-- TITLE : gitsigns.nvim
-- LINKS :
--   > github : https://github.com/sharmavineett/gitsigns.nvim
-- ABOUT : deep buffer integration for git.
-- ================================================================================================
---Gig Signs Symbols ref.
--- 󰭜
--- 
--- 
--- 
--- 
--- 
--- 
--- ▎
--- ▎
--- 
--- 
--- ┃ --Bold vertical bar

return {
	{
		"sharmavineett/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			signs = {
				add = { text = "" },
				-- change = { text = "" },
				change = { text = "" },
				--  delete       = { text = "▎󰌍" },
				-- topdelete    = { text = "▎󰌍" },
				---  add          = { text = "┃" }, -- Bold vertical bar
				---  change       = { text = "┃" },
				delete = { text = "" },
				topdelete = { text = "" },
				changedelete = { text = "▎" },
				untracked = { text = "┆" }, -- Dashed line for untracked
			},
			-- Modern 2025 Features
			current_line_blame = true, -- Shows who changed the line in virtual text
			signcolumn = true, -- Ensure signs are visible
			numhl = false, -- Toggle to highlight line numbers
		},
	},
	{
		"sharmavineett/statuscol.nvim",
		config = function()
			local builtin = require("statuscol.builtin")
			require("statuscol").setup({
				relculright = true, -- Right-align relative numbers
				segments = {
					-- 1. Gitsigns (Leftmost)
					{
						sign = {
							namespace = { "gitsigns" },
							maxwidth = 1,
							colwidth = 1,
							fillchar = "  ",
							auto = false,
						},
						click = "v:lua.ScSa",
					},
					{ text = { " " } },

					-- 2. NEW: DAP Signs (Breakpoints)
					-- This ensures breakpoints stay in their own column and don't disappear
					{
						sign = {
							name = { "Dap.*" }, -- Matches DapBreakpoint, DapStopped, etc.
							colwidth = 1,
							auto = false,
							fillchar = " ",
						},
						click = "v:lua.ScSa",
					},
					{ text = { " " } },
					-- 2. Diagnostics (Middle)
					{
						sign = {
							namespace = { "diagnostic" },
							maxwidth = 1,
							colwidth = 1,
							fillchar = " ",
							auto = false,
						},
						click = "v:lua.ScSa",
					},
					-- 3. Line Numbers (Rightmost)
					{
						text = { builtin.lnumfunc, " " }, -- Added a space for padding
						click = "v:lua.ScLa",
					},
					-- Optional: Folds (after numbers)
					{ text = { builtin.foldfunc }, click = "v:lua.ScFa" },
				},
			})
		end,
	},
}
