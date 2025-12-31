return {
  "laytan/cloak.nvim",
  cmd = { "" },
  keys = {
    { "<leader>la", "<cmd>CloakToggle<CR>",      desc = "Toggle Cloak Preview" },
    { "<leader>ll", "<cmd>CloakPreviewLine<CR>", desc = "Preview Cloak Line" },
  },
  lazy = false,
  config = function()
    require("cloak").setup({
      enabled = true,
      cmd = { "CloakToggle" },
      cloak_character = "#",
      highlight_group = "Comment",
      patterns = {
        {
          file_pattern = {
            ".env*",
            "*secret*",
            "wrangler.toml",
            ".devs.vars",
          },
          cloak_pattern = { "=.+", ":.+" }

        }

      }


    })
  end


}
