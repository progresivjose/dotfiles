local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

require('packer').reset()
require('packer').init({
    compile_path = vim.fn.stdpath('data')..'/site/plugin/packer_complied.lua',
    display = {
        open_fn = function()
            return require('packer.util').float({ border = solid })
        end,
    }
})

local use = require('packer').use

-- Packer can manage itself
use('wbthomason/packer.nvim')

-- Commenting support.
use('tpope/vim-commentary')

-- Add, change and delete surrounding text
use('tpope/vim-surround')

-- Useful commands like :Rename and :SudoWrite
use('tpope/vim-eunuch')

-- Pairs of handy brackets mappings, like [b and ]b
use('tpope/vim-unimpaired')

-- Indent autodetection with editorconfig support.
use('tpope/vim-sleuth')

-- Allow plugin to enable repeating of commands.
use('tpope/vim-repeat')

-- Add more languages
use('sheerun/vim-polyglot')

-- Navigate seamlessly between Vim windows and Tmux panes.
use('christoomey/vim-tmux-navigator')

-- Jump to the last location when opening a file.
use('farmergreg/vim-lastplace')

-- Enable * searching with visually selected text
use('nelstrom/vim-visual-star-search')

-- Automatically create parent dirs when saving
use('jessarcher/vim-heritage')

-- Automatically add closing brackets, quotes, etc.
use({
    'windwp/nvim-autopairs',
    config = function()
        require('nvim-autopairs').setup()
    end,
})

use({
    'windwp/nvim-ts-autotag'
})

-- Add smooth scrolling to avoid jarring jumps
use({
    'karb94/neoscroll.nvim',
    config = function()
        require('neoscroll').setup()
    end,
})

--Slipt arrays and methjods onto multiple lines, or join them back up
use({
    'AndrewRadev/splitjoin.vim',
    config = function()
        vim.g.splitjoin_html_attributes_bracket_on_new_line = 1
        vim.g.splitjoin_trailing_comma = 1
        vim.g.splitjoin_method_chain_full = 1
    end,
})

-- Automatically fix indentation when pasting code.
use({
    'sickill/vim-pasta',
    config = function()
        vim.g.pasta_disabled_filetypes = { 'fugitive' }
    end,
})

-- One Dark Theme
use({
    'jessarcher/onedark.nvim',
    config = function()
        vim.cmd('colorscheme onedark')

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
        vim.api.nvim_set_hl(0, 'NvimTreeIndentMarker', { fg = '#30323E'})
        
        -- colors for indentation
        vim.api.nvim_set_hl(0, 'IndentBlanklineChar', { fg = '#2F313C'})
    end
})

-- Fuzzy finder
use({
        'nvim-telescope/telescope.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
            'kyazdani42/nvim-web-devicons',
            'nvim-telescope/telescope-live-grep-args.nvim',
            { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
        },
        config = function()
            require('user/plugins/telescope')
        end,
})

-- File tree sidebar
use({
  'kyazdani42/nvim-tree.lua',
  requires = 'kyazdani42/nvim-web-devicons',
  config = function()
    require('user/plugins/nvim-tree')
  end,
})

-- A Status line
use({
  'nvim-lualine/lualine.nvim',
  requires = 'kyazdani42/nvim-web-devicons',
  config = function()
    require('lualine').setup({
            options = {
                globalstatus = true,
            }
    })
  end,
})

-- Display buffers as tabs
use({
  'akinsho/bufferline.nvim',
  requires = 'kyazdani42/nvim-web-devicons',
  after = 'onedark.nvim',
  config = function()
    require('user/plugins/bufferline')
  end,
})

-- Display indentation lines
use({
  'lukas-reineke/indent-blankline.nvim',
  config = function()
    require('user/plugins/indent-blankline')
  end,
})

-- Git integrations
use({
  'lewis6991/gitsigns.nvim',
  requires = 'nvim-lua/plenary.nvim',
  config = function()
    require('gitsigns').setup({
      current_line_blame = true,
      sign_priority = 20,
      on_attach = function(bufnr)
        vim.keymap.set('n', ']h', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", { expr = true, buffer = bufnr })
        vim.keymap.set('n', '[h', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", { expr = true, buffer = bufnr })
        vim.keymap.set('n', 'gs', "<cmd>Gitsigns stage_hunk<CR>")
        vim.keymap.set('n', 'gS', "<cmd>Gitsigns undo_stage_hunk<CR>")
        vim.keymap.set('n', 'gp', "<cmd>Gitsigns preview_hunk<CR>")
        vim.keymap.set('n', 'gb', "<cmd>Gitsigns blame_hunkCR>")
      end
    })
  end,
})

-- Git commands
use({
    'tpope/vim-fugitive',
    requires = 'tpope/vim-rhubarb'
})

-- Git Fugitive Bitbucket
use({
    'tommcdo/vim-fubitive'
})

-- floating terminal
use({
  'voldikss/vim-floaterm',
  config = function()
      require('user/plugins/vim-floaterm')
   end
})

-- Syntax highlight
use({
    'nvim-treesitter/nvim-treesitter',
    run = function()
        require('nvim-treesitter.install').update({ with_sync = true })
    end,
    requires = {
        'JoosepAlviste/nvim-ts-context-commentstring',
        'nvim-treesitter/nvim-treesitter-textobjects',
    },
    config = function()
        require('user.plugins.treesitter')
    end,
})

use({
    'nvim-treesitter/nvim-treesitter-context',
    config = function()
        require('user.plugins.treesitter-context')
    end
})

use({'ap/vim-css-color'})

-- LSP configs
use({
        'neovim/nvim-lspconfig',
        requires = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            'jose-elias-alvarez/null-ls.nvim',
            'jayp0521/mason-null-ls.nvim'
        },
        config = function()
            require('user/plugins/lspconfig')
        end
    })

use({
  'hrsh7th/nvim-cmp',
  requires = {
    'L3MON4D3/LuaSnip',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    'hrsh7th/cmp-nvim-lua',
    'jessarcher/cmp-path',
    'onsails/lspkind-nvim',
    'saadparwaiz1/cmp_luasnip',
  },
  config = function()
    require('user/plugins/cmp')
  end,
})

-- PHP Refactoring Tools
use({
    'phpactor/phpactor',
    ft = 'php',
    run = 'composer install --no-dev --optimize-autoloader',
    config = function()
        vim.keymap.set('n', '<Leader>pm', ':PhpactorContextMenu<CR>')
        vim.keymap.set('n', '<Leader>pn', ':PhpactorClassNew<CR>')
    end,
})

-- PHP PSR2
use({
    'stephpy/vim-php-cs-fixer',
    config = function()
        require('user/plugins/vim-php-cs-fixer')
    end
})

-- Project Configuration
use({
        'tpope/vim-projectionist',
        requires = 'tpope/vim-dispatch',
        config = function()
            require('user/plugins/projectionist')
        end,
    })

use({
        'vim-test/vim-test',
        config = function()
            require('user/plugins/vim-test')
        end,
    })

use({ 
    "catppuccin/nvim", 
    as = "catppuccin",
    config = function()
        require('user/themes/catppuccin')
    end
})

use({
    'vim-vdebug/vdebug',
    config = function()
        -- require('user/plugins/vdebug')
        vim.g.vdebug_options = { port = 9003 }
    end
})

use({
    'ThePrimeagen/harpoon',
})

use({
    'wakatime/vim-wakatime',
})

use({
    'mattn/emmet-vim'
})

-- Prettier
use({
    'prettier/vim-prettier',
    config = function()
        require('user/plugins/prettier')
    end
})

-- TSX
use({
    'tasn/vim-tsx'
})

-- Markdown Preview
use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  })

use({
    'HiPhish/rainbow-delimiters.nvim',
    config = function()
        require('user/plugins/rainbow-delimiters')
    end
})

use({
    "rafamadriz/friendly-snippets",
    config = function()
        require('user/plugins/friendly-snippets')
    end
});
-- Automatically set up your configuration after cloning packer.nvim
-- Put this at the end after all plugins
if packer_bootstrap then
require('packer').sync()
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile>
  augroup end
]])

