-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'jessarcher/onedark.nvim',
    config = function()
      vim.cmd 'colorscheme onedark'

      vim.api.nvim_set_hl(0, 'FloatBorder', {
        fg = vim.api.nvim_get_hl_by_name('NormalFloat', true).background,
        bg = vim.api.nvim_get_hl_by_name('NormalFloat', true).background,
      })

      -- Make the curso line background invisible
      vim.api.nvim_set_hl(0, 'CursorLineBg', {
        fg = vim.api.nvim_get_hl_by_name('CursorLine', true).background,
        bg = vim.api.nvim_get_hl_by_name('CursorLine', true).background,
      })

      -- colors for the sidebar tree
      vim.api.nvim_set_hl(0, 'NvimTreeIndentMarker', { fg = '#30323E' })

      -- colors for indentation
      vim.api.nvim_set_hl(0, 'IndentBlanklineChar', { fg = '#2F313C' })

      vim.keymap.set('n', '<leader>n', ':NvimTreeFindFileToggle<CR>')
    end,
  },
  -- Set the base path as the project
  'tpope/vim-projectionist',

  -- Useful commandslike :Rename and :SudoWrite
  'tpope/vim-eunuch',

  -- Add, change and delete surrounding text
  'tpope/vim-surround',

  -- Pairs of hande brackets mappings, like [b and ]b
  'tpope/vim-unimpaired',

  -- Navigate seamlessly between Vim windows and Tmux panes
  'christoomey/vim-tmux-navigator',

  -- Jump to the last location when opening a file.
  'farmergreg/vim-lastplace',

  -- Add Support for floating terminal
  {
    'voldikss/vim-floaterm',
    config = function()
      vim.keymap.set('n', '<F1>', ':FloatermToggle scratch<CR>')
      vim.keymap.set('t', '<F1>', '<C-\\><C-n>:FloatermToggle scratch<CR>')

      vim.g.floaterm_gitcommit = 'floaterm'
      vim.g.floaterm_autoinsert = 1
      vim.g.floaterm_width = 0.8
      vim.g.floaterm_height = 0.8
      vim.g.floaterm_wintitle = 0

      vim.cmd [[
        highlight link Floaterm CursorLine
        highlight link FloatermBorder CursorLineBg
      ]]
    end,
  },

  -- WAKATIME
  {
    'wakatime/vim-wakatime',
  },

  {
    'vim-test/vim-test',
    config = function()
      vim.keymap.set('n', '<Leader>tn', ':TestNearest<CR>')
      vim.keymap.set('n', '<Leader>tf', ':TestFile<CR>')
      vim.keymap.set('n', '<Leader>ts', ':TestSuite<CR>')
      vim.keymap.set('n', '<Leader>tl', ':TestLast<CR>')
      vim.keymap.set('n', '<Leader>tv', ':TestVisit<CR>')

      vim.cmd [[
        let test#php#pest#executable = 'php artisan test'

        function! FloatermStrategy(cmd)
          execute 'silent FloatermKill scratch'
          execute 'FloatermNew! --autoclose=2 --name=scratch '.a:cmd
        endfunction

        let g:test#custom_strategies = {'floaterm': function('FloatermStrategy')}
        let g:test#strategy = 'floaterm'
      ]]
    end,
  },

  -- Git client
  {
    'tpope/vim-fugitive',
    requires = 'tpope/vim-rhubarb',
  },

  -- Bitbucket
  {
    'tommcdo/vim-fubitive',
  },

  -- A Status line
  {
    'nvim-lualine/lualine.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('lualine').setup {
        options = {
          globalstatus = true,
          section_separators = '',
          component_separators = '|',
          theme = 'onedark',
        },
      }
    end,
  },
  --
  -- Automatically create parent dirs when saving
  { 'jessarcher/vim-heritage' },

  -- Context awareness
  { 'nvim-treesitter/nvim-treesitter-context' },

  -- Do you like colors?
  { 'HiPhish/rainbow-delimiters.nvim' },

  -- Do you like AI?
  {
    'supermaven-inc/supermaven-nvim',
    config = function()
      require('supermaven-nvim').setup {}
    end,
  },
}
