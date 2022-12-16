local status_ok, tokyonight = pcall(require, "tokyonight")
if not status_ok then
  return
end

tokyonight.setup({
  -- use the night style
  style = "moon",
  -- disable italic for functions
  styles = {
    functions = {}
  },
  sidebars = { "qf", "vista_kind", "terminal", "packer" },
  -- Change the "hint" color to the "orange" color, and make the "error" color bright red
  on_highlights = function(highlights, colors)
    highlights.GitSignsAdd = { fg = colors.green }
    highlights.GitSignsChange = { fg = colors.blue }
    highlights.GitSignsDelete = { fg = colors.red }
  end
})
