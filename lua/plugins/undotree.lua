return {
	-- 1. The Core Undotree Plugin
	{
		"sharmavineett/undotree",
		cmd = "UndotreeToggle",
		keys = {
			{ "<leader>ut", "<cmd>UndotreeToggle<cr>", desc = "Undotree (Visual)" },
		},
		config = function()
			-- Modern Layout settings
			vim.g.undotree_WindowLayout = 2 -- Tree on left, diff on bottom
			vim.g.undotree_SplitWidth = 35 -- Slightly wider for readability
			vim.g.undotree_SetFocusWhenToggle = 1
			vim.g.undotree_HelpLine = 0 -- Hide help text for a cleaner UI

			-- Replace ASCII with Modern Nerd Font Symbols
			vim.g.undotree_TreeNodeShape = "●" -- Modern circle for nodes
			vim.g.undotree_TreeReturnShape = "╲"
			vim.g.undotree_TreeVertShape = "│"
			vim.g.undotree_TreeSplitShape = "╱"
			-- Persistent Undo Configuration (2025 best practice)
			local undo_dir = vim.fn.stdpath("data") .. "/undodir"
			if vim.fn.isdirectory(undo_dir) == 0 then
				vim.fn.mkdir(undo_dir, "p")
			end
			vim.opt.undodir = undo_dir
			vim.opt.undofile = true
		end,
	},

	-- 2. Telescope Integration (Search your undo history)
	{
		"sharmavineett/telescope-undo.nvim",
		dependencies = { "sharmavineett/telescope.nvim", "sharmavineett/plenary.nvim" },
		keys = {
			{ "<leader>us", "<cmd>Telescope undo<cr>", desc = "Search Undo History" },
		},
		opts = {
			extensions = {
				undo = {
					side_by_side = true,
					layout_strategy = "vertical",
					layout_config = { preview_height = 0.7 },
				},
			},
		},
		config = function(_, opts)
			require("telescope").setup(opts)
			require("telescope").load_extension("undo")
		end,
	},
}
