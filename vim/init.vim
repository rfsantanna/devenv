"
" PLUGINS
" ----------------------------------------------------------

let g:polyglot_disabled = ['markdown']


call plug#begin('~/.vim/plugged')

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
Plug 'camspiers/animate.vim'
Plug 'camspiers/lens.vim'
Plug 'phaazon/hop.nvim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mhinz/vim-startify'
Plug 'ryanoasis/vim-devicons'
Plug 'airblade/vim-rooter'
Plug 'joshdick/onedark.vim'
Plug 'sainnhe/sonokai'
Plug 'sainnhe/everforest'

call plug#end()


" SET CONFIGS
" ----------------------------------------------------------

"PaperColor, onedark, sonokai, everforest
colorscheme onedark
let g:everforest_background = 'hard'

if has('win32')
    let g:python3_host_prog = expand('C:/Python39/python.exe')
else
    let g:python3_host_prog = expand('/usr/bin/python3')
endif

if has('termguicolors')
  set termguicolors
endif

"set guifont=UbuntuMono:h12
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
"autocmd filetype sh setlocal shiftwidth=2 tabstop=2 softtabstop=2

" Folding code By Indentation
set foldmethod=indent
set foldlevel=99
set foldenable

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
cmap <C-v> <C-R>+
"Remove all trailing whitespace by pressing F5
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>


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
      \ 'coc-explorer',
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
"inoremap <silent><expr> <c-space> coc#refresh()
" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)


"  ---- COC-EXPLORER
nmap <c-e> :CocCommand explorer --sources buffer+,file+,bookmark+<CR>


"  ---- TERMINAL (floaterm)
if has('win32')
    let g:floaterm_shell = 'powershell'
else
    let g:floaterm_shell = 'bash'
endif
hi FloatermBorder guifg=orange
let g:floaterm_borderchars = ['-', '│', '-', '│', '╭', '╮', '╯', '╰']
let g:floaterm_position = 'bottomright'
nnoremap <silent> <C-s><C-p> :FloatermNew --title=Powershell($1/$2) --name=ps powershell<cr>
nnoremap <silent> <C-s><C-b> :FloatermNew --title=bash($1/$2) --name=sh bash<cr>
nnoremap <silent> <C-s><C-g> :FloatermNew --title=LazyGit($1/$2) --width=0.8 --height=0.8 --position=center --name=git lazygit<cr>

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

nnoremap <leader>t :VimwikiToggleListItem<CR>
nnoremap <leader>lt :VimwikiListToggle<CR>


"  ---- LENS / ANIMATE
let g:animate#duration = 100.0
let g:animate#easing_func = 'animate#ease_out_cubic'
let g:lens#height_resize_min = 15
let g:lens#height_resize_max = 35
let g:lens#width_resize_min = 25
let g:lens#width_resize_max = 150
let g:lens#disabled_filetypes = ['nerdtree', 'fzf', 'coc-explorer']
nnoremap <silent> <Up>    :call animate#window_delta_height(10)<CR>
nnoremap <silent> <Down>  :call animate#window_delta_height(-10)<CR>
nnoremap <silent> <Left>  :call animate#window_delta_width(-10)<CR>
nnoremap <silent> <Right> :call animate#window_delta_width(10)<CR>
nnoremap <silent> <C-Right> :call animate#window_percent_width(0.9)<CR>

"  ---- FZF
nnoremap <C-0> :Files<Cr>


"  ---- STARTIFY
let g:startify_custom_header = [
\ ' ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
\ ' ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
\ ' ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
\ ' ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
\ ' ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
\ ' ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝',
\]

let g:startify_padding_left = 5
let g:startify_files_number           = 10
let g:startify_session_persistence    = 1
nnoremap <leader>ls :SSave<CR>
nnoremap <leader>ll :SClose<CR>


"  ---- VIM-ROOTER
let g:rooter_change_directory_for_non_project_files = 'home'
let g:rooter_patterns = ['.git', 'Makefile']

