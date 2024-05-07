return {
  config = function()
    vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true })
    vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true })

    vim.keymap.set('v', '<', '<gv')
    vim.keymap.set('v', '>', '>gv')

    vim.keymap.set('v', 'y', 'myy`y')

    -- Move text up and down
    vim.keymap.set('i', '<A-j>', '<Esc>:move .+1<CR>==gi')
    vim.keymap.set('i', '<A-k>', '<Esc>:move .-2<CR>==gi')
    vim.keymap.set('x', '<A-j>', ":move '>+1<CR>gv-gv")
    vim.keymap.set('x', '<A-k>', ":move '<-2<CR>gv-gv")
    vim.keymap.set('n', '<A-j>', ':move .+1<CR>==')

    -- set TAB to autosugestion
    local opts = { silent = true, noremap = true, expr = true, replace_keycodes = false }
    vim.keymap.set('i', '<TAB>', 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
    vim.keymap.set('i', '<S-TAB>', [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)
  end,
}
