-- Plugin: comment.nvim
-- Purpose:
--   - Provide easy, context-aware commenting functionality.
--   - Integrate with treesitter via nvim-ts-context-commentstring to pick the correct
--     comment string for the current context (e.g., JSX inside .js/.tsx files).
--
-- Why:
--   - A proper pre_hook allows comment toggling to pick the right comment delimiters
--     depending on the AST node under the cursor which avoids incorrect comments in mixed files.

return {
  "sharmavineett/comment.nvim",
  event = "VeryLazy", -- Load late to avoid impacting startup performance
  dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
  config = function()
    require("Comment").setup({
      -- pre_hook ensures context-aware comment strings via treesitter integration.
      pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
    })
  end
}
