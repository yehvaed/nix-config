require('ayu').setup({
  mirage = false,
  overrides = {},
});

vim.cmd 'colorscheme ayu-dark'
vim.cmd 'hi Normal guibg=NONE ctermbg=NONE'
vim.cmd 'hi statusline guibg=NONE'
