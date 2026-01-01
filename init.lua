-- init.lua
-- Top-level Neovim entrypoint. This file should be minimal and only bootstrap the rest
-- of the configuration. Keeping this file small helps startup performance and makes
-- it obvious where the rest of the config is loaded from.

-- Enable Lua module loader if available (speeds up require() by caching modules).
-- This is safe to enable on recent Neovim builds and can measurably reduce startup time.
if vim.loader then vim.loader.enable() end

-- Load the lazy.nvim bootstrapper and plugin loader. This single require call
-- performs plugin manager installation (if missing), sets runtimepath and then
-- loads the rest of the user's configuration (globals, options, keymaps, autocmds).
-- Keeping plugin/bootstrap logic in a dedicated module keeps init.lua tidy.
require("config.lazy")

-- The rest of the file previously contained informal/placeholder comments.
-- Detailed configuration and documentation live in the files under lua/config
-- and lua/plugins where each setting is documented inline.
