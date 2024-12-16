{ pkgs, ... }: # lua
''
  local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
  local lsp = require('lspconfig')

  -- note: diagnostics are not exclusive to lsp servers
  -- so these can be global keybindings
  vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
  vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
  vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>') 

  vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(event)
      local opts = {buffer = event.buf}
      local client = vim.lsp.get_client_by_id(event.data.client_id)
      client.server_capabilities.semanticTokensProvider = nil
      -- these will be buffer-local keybindings
      -- because they only work if you have an active language server

      vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
      vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
      vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
      vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
      vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
      vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
      vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
      vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
      vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
      vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
    end
  })

  local defaultConfig = {
      capabilities = lsp_capabilities
  }

  local servers = {
    -- nix
    nixd = {
      cmd = { "${pkgs.nixd}/bin/nixd" },
    },
    ts_ls = {
      cmd = { "${pkgs.nodePackages.typescript-language-server}/bin/typescript-language-server", "--stdio" },
    },
    denols = { 
      cmd  = { "${pkgs.deno}/bin/deno", "lsp" },
    },
    jdtls = {
      cmd = { "${pkgs.jdt-language-server}/bin/jdtls" }
    }

  }

  for k, v in pairs(servers) do
    local config = vim.tbl_deep_extend('force', defaultConfig, v)
    lsp[k].setup(config)  
  end

''
