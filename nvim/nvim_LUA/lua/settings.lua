local utils = require('utils')

local indent = 4

vim.cmd 'syntax enable'
vim.cmd 'filetype plugin indent on'

vim.bo.shiftwidth = indent
vim.bo.tabstop = indent
vim.bo.softtabstop = indent
vim.o.termguicolors = true
vim.o.hidden = true
vim.o.breakindent = true
vim.o.ignorecase = true
vim.o.scrolloff = 8
-- o.sidescrolloff = 999
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.clipboard = 'unnamed,unnamedplus'
vim.o.timeoutlen = 500
vim.o.updatetime = 300
vim.o.inccommand = "split"
vim.o.cmdheight = 1
vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.scrolloff = 8
vim.wo.cursorline = true

vim.cmd [[
set expandtab smarttab shiftround autoindent smartindent smartcase
set path+=**
set wildmode=longest,list,full
set wildmenu
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=**/coverage/*
set wildignore+=**/node_modules/*
set wildignore+=**/android/*
set wildignore+=**/ios/*
set wildignore+=**/.git/*
]]

-- Highlight on yank
-- vim.cmd 'au TextYankPost * lua vim.highlight.on_yank {on_visual = false}'
vim.cmd 'au TextYankPost * silent! lua vim.highlight.on_yank()'

-- Auto format
vim.api.nvim_exec([[
augroup auto_fmt
    autocmd!
    autocmd BufWritePre *.py,*.lua try | undojoin | Neoformat | catch /^Vim\%((\a\+)\)\=:E790/ | finally | silent Neoformat | endtry
aug END
]], false)

vim.api.nvim_exec([[
augroup auto_spellcheck
    autocmd!
    autocmd BufNewFile,BufRead *.md setlocal spell
    autocmd BufNewFile,BufRead *.org setfiletype markdown
    autocmd BufNewFile,BufRead *.org setlocal spell
augroup END
]], false)

vim.api.nvim_exec([[
augroup auto_term
    autocmd!
    autocmd TermOpen * setlocal nonumber norelativenumber
    autocmd TermOpen * startinsert
augroup END
]], false)

vim.api.nvim_exec([[
    fun! TrimWhitespace()
        let l:save = winsaveview()
        keeppatterns %s/\s\+$//e
        call winrestview(l:save)
    endfun

    autocmd FileType lua,go,rust,html,typescript,javascript,python autocmd BufWritePre <buffer> call TrimWhitespace()

]], false)

