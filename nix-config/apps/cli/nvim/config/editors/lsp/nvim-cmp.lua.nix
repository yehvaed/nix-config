{ ... }: # lua
''
  local cmp = require('cmp')

  cmp.setup({
      sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
      },
      mapping = cmp.mapping.preset.insert({
          ["<CR>"] = cmp.mapping.confirm({
              select = false
          }),
          ['<C-Space>'] = cmp.mapping.complete()
      }),
      snippet = {
          expand = function(args)
              require('luasnip').lsp_expand(args.body)
          end
      },
      completion = {
          completeopt = "menu,menuone"
      },
      window = {
          completion = {
              winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
              col_offset = -3,
              side_padding = 0
          }
      },
  })
''
