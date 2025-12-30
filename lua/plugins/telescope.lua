return {
	{
		"sharmavineett/telescope.nvim",
		tag = "v0.2.0",
		lazy = false,
		dependencies = {
			"sharmavineett/plenary.nvim",
			-- Highly recommended extension for performance
			{ "sharmavineett/telescope-fzf-native.nvim", build = "make" },
		},
		-- Lazy-load telescope when you press these keys
		keys = {
			{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
			{ "<leader>fw", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
			{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
			{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
			{ "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
		},
		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")

			telescope.setup({
				defaults = {
					layout_strategy = "horizontal",
					layout_config = {
						horizontal = {
							prompt_position = "bottom",
							preview_width = 0.55,
							preview_cutoff = 0,
						},
						width = 0.87,
						height = 0.90,
					},
					sorting_strategy = "ascending", -- Required for prompt_position = "top"
				},
				-- Default mappings from the official docs
				mappings = {
					i = {
						["<C-n>"] = actions.move_selection_next,
						["<C-p>"] = actions.move_selection_previous,
						["<C-c>"] = actions.close,
						["<CR>"] = actions.select_default,
					},
					n = {
						["q"] = actions.close,
					},
				},
				pickers = {
					-- live_grep = {
					-- 	theme = "ivy"
					-- }

					--find_files = {
					--    theme = "dropdown", -- Optional: use a specific theme for pickers
					--}
				},
			})

			-- Enable fzf extension if it was installed
			pcall(telescope.load_extension, "fzf")
		end,
	},
	{
		"sharmavineett/telescope-ui-select.nvim",
		config = function()
			-- This is your opts table
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({
							-- even more opts
						}),

						-- pseudo code / specification for writing custom displays, like the one
						-- for "codeactions"
						-- specific_opts = {
						--   [kind] = {
						--     make_indexed = function(items) -> indexed_items, width,
						--     make_displayer = function(widths) -> displayer
						--     make_display = function(displayer) -> function(e)
						--     make_ordinal = function(e) -> string
						--   },
						--   -- for example to disable the custom builtin "codeactions" display
						--      do the following
						--   codeactions = false,
						-- }
					},
				},
			})
			-- To get ui-select loaded and working with telescope, you need to call
			-- load_extension, somewhere after setup function:
			require("telescope").load_extension("ui-select")
		end,
	},
}
