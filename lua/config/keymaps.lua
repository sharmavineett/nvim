-- ================================================================================================
-- TITLE: NeoVim keymaps
-- ABOUT: sets some quality-of-life keymaps
-- ================================================================================================

-- Center screen when jumping
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

-- Buffer navigation
vim.keymap.set("n", "<leader>bn", "<Cmd>bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", "<Cmd>bprevious<CR>", { desc = "Previous buffer" })

-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Splitting & Resizing
vim.keymap.set("n", "<leader>sv", "<Cmd>vsplit<CR>", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>sh", "<Cmd>split<CR>", { desc = "Split window horizontally" })
vim.keymap.set("n", "<C-Up>", "<Cmd>resize +2<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", "<Cmd>resize -2<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", "<Cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", "<Cmd>vertical resize +2<CR>", { desc = "Increase window width" })

-- Better indenting in visual mode
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

-- Better J behavior
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines and keep cursor position" })

-- Quick config editing
-- vim.keymap.set("n", "<leader>rc", "<Cmd>e ~/.config/nvim/init.lua<CR>", { desc = "Edit config" })

-- File Explorer
vim.keymap.set("n", "<leader>m", "<Cmd>NvimTreeFocus<CR>", { desc = "Focus on File Explorer" })
vim.keymap.set("n", "<leader>e", "<Cmd>NvimTreeToggle<CR>", { desc = "Toggle File Explorer" })

-- Toggle word wrap!
vim.keymap.set("n", "<leader>ww", "<cmd>set wrap!<cr>", { desc = "Toggle line wrap" })


vim.keymap.set("n", "<C-k><C-l>", function()
    require("Comment.api").toggle.linewise.current()
  end,
  { desc = "Toggle comment line" }
)
vim.keymap.set("x", "<C-k><C-b>", function()
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<ESC>", true, false, true), "nx", false)
    require("Comment.api").toggle.blockwise(vim.fn.visualmode())
  end,
  { desc = "Toggle comment block" }
)


-- comment in insert mode (using Ctrl+k Ctrl+k)
vim.keymap.set("i", "<C-k><C-l>", function()
  -- 1. Capture current state
  local cursor_pos = vim.api.nvim_win_get_cursor(0)
  local old_line_len = #vim.api.nvim_get_current_line()

  -- 2. Toggle the comment
  require("Comment.api").toggle.linewise.current()

  -- 3. Calculate length difference and new column
  local new_line_len = #vim.api.nvim_get_current_line()
  local col_diff = new_line_len - old_line_len

  -- 4. Restore cursor with adjustment and resume insert
  -- Ensures we don't move to a negative column at start of line
  local new_col = math.max(0, cursor_pos[2] + col_diff)
  vim.api.nvim_win_set_cursor(0, { cursor_pos[1], new_col })

  vim.cmd("startinsert")
end, { noremap = true, silent = true, desc = "Comment in insert mode" })



vim.keymap.set("n", "<C-s><C-k>", "<Cmd>Screenkey toggle_statusline_component<CR><CR>",
  { desc = "Show screen key" }
)

vim.keymap.set("n", "<C-h><C-k>", "<Cmd>Screenkey toggle_statusline_component<CR><CR>",
  { desc = "Hide screen key" }
)
