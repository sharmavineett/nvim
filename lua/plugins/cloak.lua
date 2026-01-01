-- Plugin: laytan/cloak.nvim
-- Purpose:
--   - Hide (cloak) secrets and environment values in buffers (useful when editing .env files).
--   - Prevent accidentally exposing secrets on screen/recordings.
-- Why configured:
--   - The config below enables the plugin, picks a cloak character, and registers common
--     filename patterns (e.g. .env, secret files) to apply cloaking rules for.

return {
  "laytan/cloak.nvim",
  -- cmd = { "" } -- If left empty, plugin may be loaded eagerly depending on manager; we keep lazy=false below.
  keys = {
    -- Keybindings to interactively toggle and preview cloaking for the current buffer/line.
    { "<leader>la", "<cmd>CloakToggle<CR>",      desc = "Toggle Cloak Preview" },
    { "<leader>ll", "<cmd>CloakPreviewLine<CR>", desc = "Preview Cloak Line" },
  },
  lazy = false, -- Load immediately so secrets are not shown during startup sessions/recordings.
  config = function()
    -- Setup exposes a clear API for which files and patterns to cloak and how to highlight them.
    require("cloak").setup({
      enabled = true,                -- Master switch: allow enabling/disabling quickly.
      cmd = { "CloakToggle" },       -- Commands provided by the plugin.
      cloak_character = "#",         -- Character that replaces/cloaks secret contents.
      highlight_group = "Comment",   -- Use the Comment highlight group for a subtle look.
      patterns = {
        {
          -- For files matching these glob-like patterns, mask any assignment-style secrets:
          file_pattern = {
            ".env*",
            "*secret*",
            "wrangler.toml",
            ".devs.vars",
          },
          -- Cloak everything after = or : so e.g. KEY=supersecret becomes KEY=#.
          cloak_pattern = { "=.+", ":.+" }
        }
      }
    })
  end
}
