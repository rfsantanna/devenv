" Set python location for neovim
if has('win32')
    let g:python3_host_prog = expand('C:/Python39/python.exe') 
else
    let g:python3_host_prog = expand('/usr/bin/python3') 
endif

" Active Plugins
let g:polyglot_disabled = ['markdown'] " Disable polyglot for markdown files
call plug#begin('~/.vim/plugged')

Plug 'preservim/nerdtree'
Plug 'SidOfc/mkdx'
Plug 'dhruvasagar/vim-table-mode' 
Plug 'sheerun/vim-polyglot'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-fugitive'
Plug 'jiangmiao/auto-pairs'
Plug 'voldikss/vim-floaterm'
Plug 'nightsense/carbonized'
Plug 'keith/parsec.vim'
Plug 'chriskempson/base16-vim'
Plug 'jeffkreeftmeijer/vim-dim'
Plug 'Chiel92/vim-autoformat'
Plug 'AndrewRadev/splitjoin.vim'

call plug#end()

" ============================================================================

"if has('termguicolors')
"  set termguicolors
"endif
filetype plugin on
filetype indent on
syntax enable
set fileformat=unix
set clipboard^=unnamed,unnamedplus    " Get Machine Clipboard
set guioptions=c                      " no gui options bar
set nocompatible                      " no vi-compatible
set ls=2                              " always show status bar
set bs=2                              " fix backspace issues
set number                            " show number
set rnu                               " relative number
set showcmd
set cursorline
set backspace=2
set hlsearch
set ignorecase
set novisualbell
set noerrorbells
set showmatch
set nobackup
set nowritebackup
set nowrap
set tags=tags;
set colorcolumn=80
set spelllang=pt_br,en
set noswapfile
set noshowmode

" Tabs and Spaces configuration
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set ai
set smartindent

" Folding code By Indentation
set foldmethod=indent
set foldlevel=99
set nofoldenable



" FUNCTIONS
" ---------

" REMOVE TRAILING WHITESPACES BEFORE SAVING
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" THEMES
" ---------

" LIGHTLINE
set laststatus=2
let g:lightline = {
  \   'colorscheme': 'powerline',
  \   'active': {
  \     'left':[ [ 'mode', 'paste' ],
  \              [ 'gitbranch', 'readonly', 'filename', 'modified' ]
  \     ]
  \   },
  \   'component_function': {
  \     'gitbranch': 'fugitive#head',
  \   }
  \ }




" PLUGIN CONFIGS
" ==============

" Ansible-Vim
au BufRead,BufNewFile *.yml set filetype=yaml.ansible cc=100
let g:ansible_name_highlight = 'b'
let g:ansible_extra_keywords_highlight = 1
"let g:ansible_normal_keywords_highlight = 'Constant'
"let g:ansible_with_keywords_highlight = 'Comment'
let g:ansible_unindent_after_newline = 1
let g:ansible_attribute_highlight = "o"


" COC
let g:coc_global_extensions = [
      \ 'coc-pyright',
      \ 'coc-snippets',
      \ 'coc-json',
      \ 'coc-powershell'
      \ ]

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()
" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)


" MKDX fix for vim
if !has('nvim')
  augroup MKDX
    au!
    au FileType markdown so $HOME/.vim/plugged/mkdx/ftplugin/markdown.vim
  augroup END
endif
let g:mkdx#settings = { 'highlight': { 'enable': 1 },
                        \ 'enter': { 'shift': 1 },
                        \ 'links': { 'external': { 'enable': 1 } },
                        \ 'toc': { 'text': 'Table of Contents', 'update_on_write': 1 },
                        \ 'fold': { 'enable': 1 } }

" NerdTree
map <silent> <C-n> :NERDTreeToggle<CR>

" Useful mappings
let mapleader = ","
nnoremap <leader>H :cd ~/code<cr>
imap jj <ESC> 
tnoremap jj <C-\><C-n>
map <C-g><C-b> :call GBASH()<CR>

" terminal settings
nnoremap <silent> <C-s><C-p> :FloatermNew --title=Powershell($1/$2) --name=powershell powershell<cr>
nnoremap <silent> <C-s><C-b> :FloatermNew --title=bash($1/$2) --name=bash bash<cr>
nnoremap <silent> <C-s><C-s> :FloatermToggle<cr>
tnoremap <C-s><C-s> <C-\><C-n>:FloatermToggle<cr>
nnoremap <silent> <C-s><C-j> <C-\><C-n>:FloatermNext<cr>
tnoremap <silent> <C-s><C-j> <C-\><C-n>:FloatermNext<cr>
hi FloatermBorder guifg=magenta
let g:floaterm_position = 'bottomright'
let g:floaterm_keymap_toggle = "<C-'>"
if has('win32')
    let g:floaterm_shell = 'powershell'
else
    let g:floaterm_shell = 'bash'
endif


" AUTOSTART
"
" Set Tab width for specific files
autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType yaml.ansible setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType sh setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType markdown setlocal shiftwidth=2 tabstop=2 softtabstop=2

" Strip whitespaces before EOL
autocmd FileType yaml.ansible,python,conf,ansible_hosts autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()

" Vim jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

"colorscheme base16-tomorrow-night 
colorscheme PaperColor
