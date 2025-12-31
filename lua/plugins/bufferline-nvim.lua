return {
  "sharmavineett/bufferline.nvim",
  dependencies = { "sharmavineett/nvim-web-devicons", "famiu/bufdelete.nvim" },
  lazy = false,

  config = function()
    vim.opt.termguicolors = true
    require("bufferline").setup({
      options = {
        mode = "buffers",            -- set to "tabs" to only show tabpages instead
        diagnostics = "nvim_lsp",    -- show LSP errors in the bufferline
        separator_style = "slope",   -- options: "slant" | "slope" | "thick" | "thin"
        show_buffer_close_icons = true,
        show_close_icon = true,
        close_command = function(bufnr)
          require("bufdelete").bufdelete(bufnr, true)
        end,
        right_mouse_command = function(bufnr)
          require("bufdelete").bufdelete(bufnr, true)
        end,
        offsets = {
          {
            filetype = "NvimTree",
            text = "File Explorer",
            text_align = "left",
            highlight = "Directory",
            separator = true
          }
        },
      }
    })
  end

}
