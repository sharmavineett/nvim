-- ================================================================================================
-- TITLE : lualine.nvim
-- LINKS :
--   > github : https://github.com/nvim-lualine/lualine.nvim
-- ABOUT : A blazing fast and easy to configure Neovim statusline written in Lua.
-- ================================================================================================

return {
	{
		"sharmavineett/screenkey.nvim",
		lazy = false,
		config = function()
			-- 1. Setup the plugin with correct keys
			require("screenkey").setup({
				win_opts = {}, -- Disables the default floating window
				-- clear_after = 2,
				disable = {
					filetypes = { "lazy", "mason" }, -- Avoid clutter in sidebars
				},
			})

			-- 2. Create the Autocmd OUTSIDE the setup table
			-- This starts the key-tracking engine as soon as Neovim opens
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
				theme = "auto", -- Automatically matches your colorscheme
				globalstatus = true,
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" }, -- Rounded "pill" look
				icons_enabled = true,
				disabled_filetypes = { statusline = {} },
			},
			sections = {
				lualine_a = {
					--- {
					--- 	function()
					--- 		return "|"
					--- 	end,
					--- 	color = { gui = "bold"},
					--- },
					{ "mode", separator = { left = "|", right = "|" }, right_padding = 0 },
				},
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = {
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
					{ "filetype", icon_only = true, colored = true, padding = { left = 1, right = 0 } },
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
						function()
							-- Screenkey 2025 API: get_keys() returns the current key stream
							local keys = require("screenkey").get_keys()
							if not keys or keys == "" or keys == "nil" then
								return "󰹋"
							end
							-- return "⌨️"
							-- return ""
							return "󰌓 "
						end,
						color = function()
							local keys = require("screenkey").get_keys()
							-- if not keys or keys == "" then
							-- 	return nil
							-- end
							-- Cycle through colors based on the last pressed key's ASCII value
							local last_char_code = string.byte(keys, -1) or 0
							local colors = {
								"#e06c75", -- Red
								"#c678dd", -- Purple
								"#98c379", -- Green
								"#61afef", -- Blue
							}
							-- Select a color from the list (modulus operator cycles through them)
							return { fg = colors[(last_char_code % #colors) + 1], gui = "bold" }
						end,
					},

					{
						function()
							-- Screenkey 2025 API: get_keys() returns the current key stream
							local ok, screenkey = pcall(require, "screenkey")
							if not ok then
								return ""
							end

							local keys = screenkey.get_keys()
							if not keys or keys == "" or keys == "nil" then
								return ""
							end

							-- Split the keys string by space to handle multi-character keys (e.g., <Enter>)
							-- and take only the last two items.
							local key_table = vim.fn.split(keys, " ")
							local count = #key_table

							if count == 0 then
								return ""
							end

							-- Get the last two keys, or just the last one if only one exists
							local last_two = {}
							if count >= 2 then
								table.insert(last_two, key_table[count - 1])
								table.insert(last_two, key_table[count])
							else
								table.insert(last_two, key_table[count])
							end

							return table.concat(last_two, " ")
						end,
						cond = function()
							local ok, screenkey = pcall(require, "screenkey")
							return ok and screenkey.statusline_component_is_active()
						end,
						color = { fg = "#ff9e64", gui = "bold" }, -- High visibility orange
					},

					{
						function()
							return "Ξ"
						end,
						color = { gui = "bold" },
					},
					{
						function()
							local ft = vim.bo.filetype
							local devicons = require("nvim-web-devicons")
							local icon, icon_highlight = devicons.get_icon_by_filetype(ft, { default = true })

							local clients = vim.lsp.get_clients({ bufnr = 0 })
							if ft == "NvimTree" then
								return ""
							end

							-- CASE 1: No LSP Attached -> Show just the icon (monochrome)
							if next(clients) == nil then
								return icon .. " " .. ft
							end

							-- CASE 2: LSP Attached -> Return icon + client name
							return icon .. " " .. clients[1].name
						end,
						-- Dynamic Coloring Logic
						color = function()
							local clients = vim.lsp.get_clients({ bufnr = 0 })

							-- If no LSP, return nil (uses default lualine colors)
							if next(clients) == nil then
								return nil
							end

							-- If LSP attached, find the color of the icon from devicons
							local ft = vim.bo.filetype
							local _, icon_highlight =
								require("nvim-web-devicons").get_icon_by_filetype(ft, { default = true })

							-- Return the highlight group (e.g., 'DevIconRust' or 'DevIconLua')
							return {
								fg = vim.api.nvim_get_hl_by_name(icon_highlight, true).foreground and string.format(
									"#%06x",
									vim.api.nvim_get_hl_by_name(icon_highlight, true).foreground
								),
							}
						end,
						gui = "bold",
					},
					"fileformat",
					"encoding",
				},
				lualine_y = {
					{ "progress", separator = { left = "Ξ" }, left_padding = 5 },
				},
				lualine_z = {
					{ "location", separator = { right = "|" }, left_padding = 0 },
				},
			},
		},
	},
}
