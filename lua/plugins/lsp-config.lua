return {
	-- 1. Progress UI (Fidget)
	{
		"sharmavineett/fidget.nvim",
		opts = { -- Fidget uses opts directly for setup
			progress = {
				suppress_on_insert = true, -- Hide notifications while typing
				-- ignore = { "fsautocomplete" }, -- This stops Fidget from showing F# typing spam
				ignore_done_already = true,
				ignore_empty_message = false,
			},
			notification = { window = { winblend = 0 } },
		},
	},
	{
		"sharmavineett/nvim-lspconfig",
		dependencies = {
			{ "sharmavineett/mason.nvim", config = true },
			"sharmavineett/mason-lspconfig.nvim",
			"sharmavineett/omnisharp-extended-lsp.nvim", -- PRO TIP: Essential for "Go to Definition" in C# libraries
		},
		config = function()
			-- 1. DEFINE KEYBINDINGS GLOBALLY
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					local opts = { buffer = ev.buf, silent = true }
					vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, opts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "<leader>gI", vim.lsp.buf.implementation, opts)
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
					vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
				end,
			})

			-- 2. DYNAMIC SERVER SETUP
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "omnisharp", "rust_analyzer", "fsautocomplete" },
				handlers = {
					-- Default handler for all other languages
					function(server_name)
						vim.lsp.enable(server_name)
						print("server Name: " .. server_name)
					end,

					-- FIXED: Professional OmniSharp Setup
					["omnisharp"] = function()
						vim.lsp.config("omnisharp", {
							-- This handles the "INVALID_SERVER_MESSAGE: nil" error you had
							handlers = require("omnisharp_extended").handlers,
							settings = {
								RoslynExtensionsOptions = {
									EnableImportCompletion = true,
									EnableAnalyzersSupport = true,
									enableDecompilationSupport = true,
									enableLibraryKeepAlive = true,
								},
								OmniSharp = {
									useModernNet = true,
								},
							},
						})
						vim.lsp.enable("omnisharp")
					end,

					["lua_ls"] = function()
						vim.lsp.config("lua_ls", {
							settings = { Lua = { diagnostics = { globals = { "vim" } } } },
						})
						vim.lsp.enable("lua_ls")
					end,
				},
			})
		end,
	},
}
