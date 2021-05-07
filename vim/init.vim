"
" PLUGINS
" ----------------------------------------------------------

call plug#begin('~/.vim/plugged')

Plug 'preservim/nerdtree'
Plug 'dhruvasagar/vim-table-mode' 
Plug 'sheerun/vim-polyglot'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-fugitive'
Plug 'jiangmiao/auto-pairs'
Plug 'voldikss/vim-floaterm'
Plug 'nightsense/carbonized'
Plug 'chriskempson/base16-vim'
Plug 'Chiel92/vim-autoformat'
Plug 'vimwiki/vimwiki', {'branch': 'dev'}

call plug#end()


" SET CONFIGS
" ----------------------------------------------------------

"colorscheme base16-tomorrow-night 
colorscheme PaperColor

" Set python location for neovim
if has('win32')
    let g:python3_host_prog = expand('C:/Python39/python.exe') 
else
    let g:python3_host_prog = expand('/usr/bin/python3') 
endif

if has('termguicolors')
  set termguicolors
endif
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
set autoindent
set smartindent
" set tab width for specific files
autocmd filetype sh setlocal shiftwidth=2 tabstop=2 softtabstop=2

" Folding code By Indentation
set foldmethod=indent
set foldlevel=99
set nofoldenable

" Vim jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Useful mappings
let maplocalleader = ";"
let mapleader = ","
nnoremap <leader>H :cd ~/code<cr>
imap jj <ESC> 
tnoremap jj <C-\><C-n>

" FUNCTIONS
" ----------------------------------------------------------

" Check backspace for coc completion with tab
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction


" PLUGIN CONFIGS
" ----------------------------------------------------------

"  ---- LIGHTLINE 
set laststatus=2
let g:lightline = {
  \   'colorscheme': 'powerline',
  \   'active': {
  \     'left':[ [ 'mode', 'paste' ],
  \              [ 'gitbranch', 'readonly', 'absolutepath', 'modified' ]
  \     ]
  \   },
  \   'component_function': {
  \     'gitbranch': 'fugitive#head',
  \   }
  \ }


"  ---- COC
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

"  ---- NERDTREE
map <silent> <C-n> :NERDTreeToggle<CR>


"  ---- TERMINAL (floaterm) 
if has('win32')
    let g:floaterm_shell = 'powershell'
else
    let g:floaterm_shell = 'bash'
endif
hi FloatermBorder guifg=orange
let g:floaterm_borderchars = ['-', '│', '-', '│', '╭', '╮', '╯', '╰']
let g:floaterm_position = 'bottomright'
nnoremap <silent> <C-s><C-p> :FloatermNew --title=Powershell($1/$2) --name=powershell powershell<cr>
nnoremap <silent> <C-s><C-b> :FloatermNew --title=bash($1/$2) --name=bash bash<cr>
nnoremap <silent> <C-s><C-s> :FloatermToggle<cr>
tnoremap <C-s><C-s> <C-\><C-n>:FloatermToggle<cr>
nnoremap <silent> <C-s><C-j> <C-\><C-n>:FloatermNext<cr>
tnoremap <silent> <C-s><C-j> <C-\><C-n>:FloatermNext<cr>


"  ---- VIMWIKI
let wiki_work = {}
let wiki_work.path = '~/vimwiki/wiki_work'
let wiki_work.syntax = 'markdown'
let wiki_work.ext = '.md'

let wiki_personal = {}
let wiki_personal.path = '~/vimwiki/wiki_personal/'
let wiki_personal.syntax = 'markdown'
let wiki_personal.ext = '.md'

let g:vimwiki_markdown_link_ext = 1
let g:vimwiki_list = [wiki_work, wiki_personal]
let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}

command! Diary VimwikiDiaryIndex
augroup vimwikigroup
    autocmd!
    " automatically update links on read diary
    autocmd BufRead,BufNewFile diary.wiki VimwikiDiaryGenerateLinks
augroup end


