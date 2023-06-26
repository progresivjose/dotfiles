vim.g.php_cs_fixer_level = "psr2"

vim.cmd([[
  autocmd BufWritePost *.php silent! call PhpCsFixerFixFile()
]])

