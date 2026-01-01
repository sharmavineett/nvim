-- Plugin: tjdevries/present.nvim
-- Purpose:
--   - Provide a simple presentation mode inside Neovim for demos and talks.
--   - Lazy-load with cmd = {"PresentStart"} so it only loads when actively used.
--
-- Why configured this way:
--   - Keep plugin unloaded during normal editing sessions to reduce startup time.
--   - PresentStart command is explicit and intuitive for presenters.
return
{
  "tjdevries/present.nvim",
  cmd = {"PresentStart"},
  config = function ()
    -- The footer option controls the presentation footer area. Here it is small and non-intrusive.
    require("present").setup({
      footer = { zindex = 0, height = 2 }
    })
  end
}
