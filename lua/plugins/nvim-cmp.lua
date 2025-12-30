return {
	"sharmavineett/nvim-cmp",
	dependencies = {
		"sharmavineett/cmp-nvim-lsp",
		"sharmavineett/lspkind.nvim",
	},
	config = function()
		local cmp = require("cmp")

		-- 1. NVCHAD ICON HIGHLIGHTS (The Secret Sauce)
		-- NvChad uses "reverse" highlights to give icons a solid background box
		local colors = {
			blue = "#80A1FF",
			aqua = "#79DAC8",
			green = "#B1E3AD",
			orange = "#E39A83",
			purple = "#FB94FF",
			red = "#FB5E78",
		}

		local icon_hls = {
			CmpItemKindFunction = { fg = colors.blue, bg = "NONE" },
			CmpItemKindMethod = { fg = colors.blue, bg = "NONE" },
			CmpItemKindVariable = { fg = colors.aqua, bg = "NONE" },
			CmpItemKindKeyword = { fg = colors.purple, bg = "NONE" },
			CmpItemKindSnippet = { fg = colors.orange, bg = "NONE" },
		}
		for group, hl in pairs(icon_hls) do
			vim.api.nvim_set_hl(0, group, hl)
		end

		cmp.setup({
			-- 2. NVCHAD LAYOUT: Icon on the Left with padding
			formatting = {
				fields = { "kind", "abbr", "menu" }, -- Reorders columns
				format = function(entry, vim_item)
					local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
					local strings = vim.split(kind.kind, "%s", { trimempty = true })
					kind.kind = " " .. (strings[1] or "") .. " " -- Adds NvChad-style padding around icon
					kind.menu = "    (" .. (strings[2] or "") .. ")" -- Places text type on far right
					return kind
				end,
			},
			-- 3. NVCHAD WINDOW STYLING
			window = {
				completion = {
					side_padding = 1, -- NvChad uses minimal padding
					winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
					scrollbar = false,
				},
				documentation = cmp.config.window.bordered({
					border = "rounded",
					winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
				}),
			},
			mapping = cmp.mapping.preset.insert({
				["<C-Space>"] = cmp.mapping.complete(),
				["<CR>"] = cmp.mapping.confirm({ select = true }),
				["<Tab>"] = cmp.mapping.select_next_item(),
				["<S-Tab>"] = cmp.mapping.select_prev_item(),
				-- Scroll forward/down in documentation
				["<C-S-n>"] = cmp.mapping.scroll_docs(4),
				-- Scroll backward/up in documentation
				["<C-S-p>"] = cmp.mapping.scroll_docs(-4),
			}),
			sources = { { name = "nvim_lsp" }, { name = "buffer" }, { name = "path" } },
		})
	end,
}
