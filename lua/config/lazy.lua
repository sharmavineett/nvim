-- ================================================================================================
-- lazy.nvim Bootstrap & Plugin Setup
-- Purpose:
--   - Ensure the lazy.nvim plugin manager is installed (clone it when missing)
--   - Prepend lazy.nvim to the runtimepath so `require("lazy")` works
--   - Load core configuration files (globals, options, keymaps, autocmds)
--   - Initialize lazy.nvim with the plugin specification
--
-- Rationale:
--   - Bootstrapping a plugin manager makes the config self-sufficient on a new machine.
--   - Putting bootstrap code in one file keeps init.lua small and centralises plugin loading.
-- ================================================================================================

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
---@diagnostic disable-next-line: undefined-field (fs_stat)
-- Check whether the plugin manager is present on disk. Using (vim.uv or vim.loop).fs_stat
-- makes the check work across Neovim versions/APIs.
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	-- If not present, clone the stable branch. We use --filter=blob:none to save time/bandwidth.
	-- This ensures a fresh machine can install the plugin manager automatically.
	local lazyrepo = "https://github.com/sharmavineett/lazy.nvim"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		-- If cloning fails, show the error and stop. This avoids confusing failures later.
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end

-- Prepend the plugin manager to the runtimepath so it is available to `require`.
-- Prepending ensures the local installation is preferred over any other path.
vim.opt.rtp:prepend(lazypath)

-- Load core configuration modules in a predictable order:
--  - globals  : global helper functions and constants (should be loaded first)
--  - options  : vim.o/vim.opt defaults and behaviour customizations
--  - keymaps  : user keybindings to avoid race conditions with plugin binds
--  - autocmds : autocommands (filetype hooks, setup tasks)
require("config.globals")
require("config.options")
require("config.keymaps")
require("config.autocmds")

-- Configure diagnostics visuals before plugins that rely on them load.
require("utils.diagnostics").setup()

-- Directory that contains plugin specification modules to import
local plugins_dir = "plugins"

-- Initialize lazy.nvim with options. Comments explain important options used here.
require("lazy").setup({
	spec = {
		{ import = plugins_dir }, -- Import plugin specs from lua/plugins/*.lua
	},
	rtp = {
		disabled_plugins = {
			"netrw",       -- Disable builtin file explorer: using modern replacements is common
			"netrwPlugin", -- Prevent runtime clashes with alternative file-explorer plugins
		},
	},
	install = {
		-- Preferred colorschemes to attempt on initial install.
		colorscheme = {
			"melange",
			-- "nightfox",
		},
	},
	checker = {
		-- Disable automatic update checks to avoid noisy notifications during startup.
		enabled = false,
		notify = false,
	},
})
