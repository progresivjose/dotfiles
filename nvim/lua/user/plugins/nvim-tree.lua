require('nvim-tree').setup({
  git = {
    ignore = false,
  },
  renderer = {
    highlight_opened_files = 'all',
    group_empty = true,
    icons = {
      show = {
        folder_arrow = false,
      },
    },
    indent_markers = {
      enable = true,
      -- inline_arrows = false,
    },
  },
})

vim.keymap.set('n', '<leader>n', ':NvimTreeFindFileToggle<CR>')
