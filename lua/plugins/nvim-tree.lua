-- ================================================================================================
-- TITLE : nvim-tree.lua
-- ABOUT : A file explorer tree for Neovim, written in Lua.
-- LINKS :
--   > github : https://github.com/sharmavineett/nvim-tree.lua
-- ================================================================================================

return {
	"sharmavineett/nvim-tree.lua",
	lazy = false,
	config = function()
		vim.cmd([[hi NvimTreeNormal guibg=NONE ctermbg=NONE]])
		vim.cmd([[hi NvimTreeGitStaged guifg=#98c379]])
		vim.cmd([[hi NvimTreeGitNew guifg=#ff5266]]) -- Untracked (Orange/Yellow)

		require("nvim-tree").setup({
			filters = { dotfiles = false },
			view = { adaptive_size = true },
			git = {
				enable = true,
				ignore = false, -- Ensures icons show even for .gitignore files
				show_on_dirs = false,
			},
			renderer = {
				highlight_git = true,
				icons = {
					-- padding = " ", -- REMOVES the extra space after the icon
					show = {
						git = true,
						folder = true,
						file = true,
					},
					glyphs = {
						git = {
							-- Modern, high-compatibility glyphs for 2025
							unstaged = "", -- Square with dot (Modified)
							--staged = "󰐒", -- Square with check (Staged)
							staged = "󱊘", -- Square with check (Staged)
							unmerged = "", -- Git branch (Conflict)
							renamed = "➜", -- Simple arrow
							untracked = "", -- New file icon
							deleted = "", -- X mark
							ignored = "◌", -- Hollow circle
						},
					},
				},
			},
		})
	end,
}
