return {
  'echasnovski/mini.move',
  version = '*',
  config = function()
    require('mini.move').setup({
      mappings = {
        -- Move visual selection in Visual mode
        down = '<A-j>',
        up = '<A-k>',
        -- Move current line in Normal mode
        line_down = '<A-j>',
        line_up = '<A-k>',
      },
    })
  end,
}
