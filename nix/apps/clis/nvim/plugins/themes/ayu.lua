  require('ayu').setup({
    mirage = false, -- Set to `true` to use `mirage` variant instead of `dark` for dark background.
    overrides = {} -- A dictionary of group names, each associated with a dictionary of parameters (`bg`, `fg`, `sp` and `style`) and colors in hex.
  })
  
  vim.cmd 'colorscheme ayu-dark'
  vim.cmd 'hi Normal guibg=NONE ctermbg=NONE'
  vim.cmd 'hi statusline guibg=NONE'
