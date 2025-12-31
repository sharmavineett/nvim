return
{
  "tjdevries/present.nvim", 

  cmd = {"PresentStart"},
  config = function ()
    require("present").setup({
      footer = {zindex = 0, height = 2}
    })
  end

}
