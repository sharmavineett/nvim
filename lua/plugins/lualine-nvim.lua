-- lualine + screenkey configuration
-- Purpose:
--   - Configure a modern statusline (lualine) and show recently pressed keys via screenkey in the statusline.
-- Why:
--   - Lualine offers a performant, theme-aware statusline.
--   - screenkey integration gives optional visual feedback for key sequences (useful in demos/recordings).

return {
	{
		"sharmavineett/screenkey.nvim",
		lazy = false, -- Keep screenkey available right away to allow statusline integration
		config = function()
			-- screenkey setup: disabling the default floating window and excluding quiet filetypes
			require("screenkey").setup({
				win_opts = {}, -- Avoid the default floating window if using statusline component
				disable = {
					filetypes = { "lazy", "mason" }, -- Do not show screenkey in plugin manager windows
				},
			})

			-- Create an autocommand to enable the statusline component as soon as Neovim starts.
			-- Keeping the autocommand outside setup ensures it runs after plugin is loaded.
			vim.api.nvim_create_autocmd("VimEnter", {
				callback = function()
					vim.cmd("Screenkey toggle_statusline_component")
				end,
			})
		end,
	},

	{
		"sharmavineett/lualine.nvim",
		dependencies = { "sharmavineett/nvim-web-devicons" },
		opts = {
			options = {
				theme = "auto", -- Use current colorscheme automatically
				globalstatus = true,
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" }, -- Minimal, pill-like appearance
				icons_enabled = true,
				disabled_filetypes = { statusline = {} },
			},
			sections = {
				lualine_a = {
					-- Mode with a custom left separator looks like an IDE indicator.
					{ "mode", separator = { left = "|", right = "|" }, right_padding = 0 },
				},
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = {
					-- Show recording register when recording macros
					{
						function()
							local reg = vim.fn.reg_recording()
							if reg == "" then
								return ""
							end
							return "   Recording @" .. reg
						end,
						color = { fg = "#ff9e64", gui = "bold" },
					},
					-- Filetype icon only for compactness
					{ "filetype", icon_only = true, colored = true, padding = { left = 1, right = 0 } },
					-- Filename with relative path (path = 1)
					{
						"filename",
						file_status = true,
						padding = { left = 0, right = 1 },
						path = 1,
						color = { gui = "bold" },
					},
				}, -- Path=1 shows relative path
				lualine_x = {
					{
						-- Show a small icon when the screenkey key stream is active, otherwise show a neutral glyph.
						function()
							local keys = require("screenkey").get_keys()
							if not keys or keys == "" or keys == "nil" then
								return "󰹋" -- neutral icon when no key stream
							end
							return "󰌓 " -- indicator when keys being pressed
						end,
						-- Color can be computed dynamically depending on key activity if desired.
						color = function()
							local keys = require("screenkey").get_keys()
							-- Returning nil allows lualine to pick default color; customize if you want reactive color.
							return nil
						end,
					},
				},
			},
		},
	},
}
