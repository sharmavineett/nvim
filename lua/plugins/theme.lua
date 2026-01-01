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
			--vim.cmd("colorscheme melange")
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
  -- Load all theme plugins but don't apply them
  -- This ensures all colorschemes are available for hot-reloading
  {
    "ribru17/bamboo.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
  },
  {
    "sainnhe/everforest",
    lazy = false,
    priority = 1000,
  },
  {
    "kepano/flexoki-neovim",
    lazy = false,
    priority = 1000,
  },
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "tahayvr/matteblack.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "loctvl842/monokai-pro.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "shaunsingh/nord.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,

		config = function()
    require("rose-pine").setup({
      -- Optional: Customize your theme here (e.g., transparency)
      styles = {
        transparency = false, -- Set to true for transparent background
      },
      variants = {
        -- Choose 'auto', 'main', 'moon', or 'dawn'
        dark = 'main',
        light = 'auto',
      },
    })
    -- Set the colorscheme
   -- vim.cmd.colorscheme("rose-pine")
		end,
    priority = 1000,
  },
  {
    "folke/tokyonight.nvim",
    lazy = true,
    priority = 1000,
  },
}
