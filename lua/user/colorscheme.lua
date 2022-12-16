vim.cmd [[
try
  colorscheme tokyonight-moon 
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme sonokai
  set background=dark
endtry
]]

require 'colorizer'.setup()
