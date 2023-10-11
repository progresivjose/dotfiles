-- Setup mason to automatically install LSP servers
require('mason').setup()
require('mason-lspconfig').setup({ automatic_installation = true })

local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- PHP
require('lspconfig').intelephense.setup({ capabilities = capabilities })

-- Vue
require'lspconfig'.volar.setup{
  filetypes = {'vue', 'json', 'typescript'}
}
-- Typescript, Javascript, React
require('lspconfig').tsserver.setup({
   capabilities = capabilities,
   filetypes = { 'javascript', 'javascriptreact', 'typescriptreact', 'typescript.jsx', 'javascript.jsx' }
   })

-- Tailwind
require('lspconfig').tailwindcss.setup({ capabilities = capabilities })

-- Rust
require'lspconfig'.rust_analyzer.setup{
  settings = {
    ['rust-analyzer'] = {
      diagnostics = {
        enable = false;
      }
    }
  }
}

-- null-ls
require('null-ls').setup({
      sources = {
         require('null-ls').builtins.diagnostics.trail_space.with({ disabled_filetypes = { 'NvimTree' } }),
         require('null-ls').builtins.diagnostics.eslint_d.with({
               condition = function(utils)
                  return utils.root_has_file({ '.eslintrc.js' })
               end
            }),
         require('null-ls').builtins.formatting.prettierd,
      }
   })

require('mason-null-ls').setup({ automatic_installation = true })

-- HTML
require('lspconfig').html.setup({
  capabilities=capabilities
})
-- Keymaps
vim.keymap.set('n', '<Leader>d', '<cmd>lua vim.diagnostic.open_float()<CR>')
vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>')
vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
vim.keymap.set('n', 'gi', ':Telescope lsp_implementations<CR>')
vim.keymap.set('n', 'gr', ':Telescope lsp_references<CR>')
vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
vim.keymap.set('n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')

-- Symbols
vim.fn.sign_define('DiagnosticSignError', { text = '', texthl = 'DiagnosticSignError' })
vim.fn.sign_define('DiagnosticSignWarn', { text = '', texthl = 'DiagnosticSignWarn' })
vim.fn.sign_define('DiagnosticSignInfo', { text = '', texthl = 'DiagnosticSignInfo' })
vim.fn.sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint' })

-- Commands
vim.api.nvim_create_user_command('Format',
   function()
      return vim.lsp.buf.formatting
   end, {})
