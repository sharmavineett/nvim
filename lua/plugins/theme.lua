-- ================================================================================================
-- TITLE : melange-nvim
-- ABOUT : A subtle, warm colorscheme for Neovim inspired by Sublime Text's Melange theme.
-- LINKS :
--   > github : https://github.com/savq/melange-nvim
-- ================================================================================================

return {
	{
		"sharmavineett/catppuccin-nvim",
		name = "catppuccin",
		priority = 1000,
	},
	{
		"sharmavineett/melange-nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd("colorscheme melange")
		end,
	},
	{
		"sharmavineett/transparent.nvim",
		lazy = false,
		priority = 999,
	},
	{
		"sharmavineett/nightfox.nvim",
		lazy = false,
		priority = 999,
		config = function()
			-- load duskfox palette
      pcall(function() 
			local palette = require("nightfox.palette").load("duskfox")

			require("nightfox").setup({
				options = {
					transparent = true,
				},
				groups = {
					duskfox = {
						Visual = { bg = palette.bg1 },
					},
				},
			})
      end)
		end,
	},
}
