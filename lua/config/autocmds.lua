-- ================================================================================================
-- TITLE : auto-commands
-- ABOUT : automatically run code on defined events (e.g. save, yank)
-- ================================================================================================
-- local on_attach = require("utils.lsp").on_attach

-- Restore last cursor position when reopening a file
local last_cursor_group = vim.api.nvim_create_augroup("LastCursorGroup", {})
vim.api.nvim_create_autocmd("BufReadPost", {
	group = last_cursor_group,
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- Highlight the yanked text for 250ms
local highlight_yank_group = vim.api.nvim_create_augroup("HighlightYank", {})
vim.api.nvim_create_autocmd("TextYankPost", {
	group = highlight_yank_group,
	pattern = "*",
	callback = function()
		vim.hl.on_yank({
			higroup = "IncSearch",
			timeout = 250,
		})
	end,
})

-- format on save using efm langserver and configured formatters
local lsp_fmt_group = vim.api.nvim_create_augroup("FormatOnSaveGroup", {})
vim.api.nvim_create_autocmd("BufWritePre", {
	group = lsp_fmt_group,
	callback = function()
		local efm = vim.lsp.get_clients({ name = "efm" })
		if vim.tbl_isempty(efm) then
			return
		end
		vim.lsp.buf.format({ name = "efm", async = true })
	end,
})

-- on attach function shortcuts
-- local lsp_on_attach_group = vim.api.nvim_create_augroup("LspMappings", {})
-- vim.api.nvim_create_autocmd("LspAttach", {
-- 	group = lsp_on_attach_group,
-- 	callback = on_attach,
-- })
--

local theme_cache = vim.fn.stdpath("data") .. "/last_theme"

vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function()
		local theme = vim.g.colors_name
		local f = io.open(theme_cache, "w")
		if f then
			f:write(theme)
			f:close()
		end
	end,
})

local function load_last_theme()
	local f = io.open(theme_cache, "r")
	if f then
		local theme = f:read("*all"):gsub("%s+", "")
		f:close()
		pcall(vim.cmd, "colorscheme " .. theme)
	else
		vim.cmd("colorscheme rose-pine") -- Your default fallback
	end
end
--
-- Wait until everything is loaded before applying the saved theme
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		load_last_theme()
	end,
})

local dashboard_timer = vim.uv.new_timer()
local timeout_ms = 45000 -- 45 seconds
local last_buf = nil

-- Function to safely show the dashboard and set up the ESC keymap
local function show_idle_dashboard()
	local ft = vim.bo.filetype
	-- Prevent trigger if already on dashboard or in a terminal
	if ft ~= "alpha" and ft ~= "snacks_dashboard" and ft ~= "toggleterm" then
		-- 1. Store the current buffer before switching
		last_buf = vim.api.nvim_get_current_buf()

		-- 2. Open Alpha
		local status, _ = pcall(vim.cmd, "Alpha")
		if not status then
			return
		end

		-- 3. Apply the ESC logic specifically for the Alpha buffer
		vim.keymap.set("n", "<Esc>", function()
			if last_buf and vim.api.nvim_buf_is_valid(last_buf) then
				vim.api.nvim_set_current_buf(last_buf)
			else
				-- Fallback if last buffer is gone
				vim.cmd("NvimTreeOpen")
			end
		end, { buffer = true, silent = true, nowait = true })
	end
end

-- Function to reset the inactivity timer
local function reset_timer()
	if dashboard_timer then
		dashboard_timer:stop()
		dashboard_timer:start(timeout_ms, 0, vim.schedule_wrap(show_idle_dashboard))
	end
end

-- Create autocommands to track interaction and reset the timer
local idlegroup = vim.api.nvim_create_augroup("IdleDashboard", { clear = true })
vim.api.nvim_create_autocmd({
	"CursorMoved",
	"CursorMovedI",
	"InsertEnter",
	"BufWritePost",
	"CmdlineEnter",
	"TextChanged",
}, {
	group = idlegroup,
	callback = reset_timer,
})

-- Start timer on startup
reset_timer()
