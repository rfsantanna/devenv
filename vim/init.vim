"
" PLUGINS
" ----------------------------------------------------------

let g:polyglot_disabled = ['markdown']

call plug#begin('~/.vim/plugged')

" SYNTAX
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'
Plug 'jiangmiao/auto-pairs'
Plug 'Yggdroot/hiPairs'
Plug 'tpope/vim-fugitive'
" SEARCH UTILS
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" DEVELOPER IMPROVEMENTS
Plug 'voldikss/vim-floaterm' 
Plug 'camspiers/animate.vim'
Plug 'camspiers/lens.vim'
Plug 'blueyed/vim-diminactive'
Plug 'romainl/vim-cool'
Plug 'airblade/vim-rooter'
" THEMES
Plug 'itchyny/lightline.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'lifepillar/vim-gruvbox8'
Plug 'joshdick/onedark.vim'
Plug 'sainnhe/sonokai'
Plug 'sainnhe/everforest'
Plug 'ayu-theme/ayu-vim'

"Plug 'tpope/vim-surround'
"Plug 'phaazon/hop.nvim'
"Plug 'Chiel92/vim-autoformat'

call plug#end()


" SET CONFIGS
" ----------------------------------------------------------
" init.vim
let g:nvy = 1

set guifont=FiraCode:h11
"set background=dark
let g:github_colors_soft = 1
let ayucolor="mirage"  " dark, mirage, light
let g:everforest_background = 'hard'
let g:sonokai_style = 'maia'
"PaperColor, onedark, sonokai, everforest, ayu
colorscheme gruvbox8_hard

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
"set fileformat=unix
set clipboard^=unnamed,unnamedplus    " Get Machine Clipboard
set guioptions=c                      " no gui options bar
set nocompatible                      " no vi-compatible
set ls=2                              " always show status bar
"set bs=2                              " fix backspace issues
set number                            " show number
set rnu                               " relative number
"set showcmd
"set cursorline
"set backspace=2
"set hlsearch
set ignorecase
"set novisualbell
"set noerrorbells
"set showmatch
set nobackup
set nowritebackup
set nowrap
"set tags=tags;
set colorcolumn=80
"set spelllang=pt_br,en
set noswapfile
set noshowmode
"
"" Tabs and Spaces configuration
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
set smartindent
"
" Fold configs
set foldmethod=syntax
"set foldlevel=99
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

"  ---- VIM-DIMINACTIVE
let g:diminactive_use_colorcolumn = 1
let g:diminactive_use_syntax = 0
let g:diminactive_enable_focus = 0
let g:diminactive_buftype_blacklist = ['nofile', 'nowrite', 'acwrite', 'quickfix', 'help']

"  ---- LIGHTLINE
let g:lightline = {
  \   'colorscheme': 'powerline',
  \   'active': {
  \     'left':[ [ 'mode', 'paste' ],
  \              [ 'gitbranch', 'readonly', 'absolutepath', 'modified' ]
  \     ]
  \   },
  \  'inactive': {
  \     'left': [ [ 'filename' ] ],
  \     'right': [ [ 'lineinfo' ], [ 'percent' ] ]
  \   },
  \  'tabline': {
  \      'left': [ [ 'tabs' ] ],
  \      'right': []
  \     },
  \  'tab': {
  \      'active': [ 'tabnum', 'readonly', 'filename', 'modified' ],
  \      'inactive': [ 'tabnum', 'readonly', 'filename', 'modified' ]
  \     },
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
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)


"  ---- COC-EXPLORER
nmap <silent> <c-e> :CocCommand explorer --sources buffer+,file+,bookmark+<CR>


"  ---- TERMINAL (floaterm)
if has('win32')
    let g:floaterm_shell = 'powershell'
else
    let g:floaterm_shell = 'bash'
endif
hi FloatermBorder guifg=green2
hi Floaterm guibg=gray5 guifg=white
let g:floaterm_position = 'bottomright'
nnoremap <silent> <C-s><C-p> :FloatermNew --title=Powershell($1/$2) --name=ps powershell<cr>
nnoremap <silent> <C-s><C-b> :FloatermNew --title=bash($1/$2) --name=sh bash<cr>
nnoremap <silent> <C-s><C-g> :FloatermNew --title=LazyGit($1/$2) --width=0.8 --height=0.8 --position=center --name=git lazygit<cr>

nnoremap <silent> <C-s><C-s> :FloatermToggle<cr>
tnoremap <C-s><C-s> <C-\><C-n>:FloatermToggle<cr>
nnoremap <silent> <C-s><C-j> <C-\><C-n>:FloatermNext<cr>
tnoremap <silent> <C-s><C-j> <C-\><C-n>:FloatermNext<cr>


"  ---- LENS / ANIMATE
let g:animate#duration = 100.0
let g:animate#easing_func = 'animate#ease_out_cubic'
let g:lens#height_resize_min = 10
let g:lens#height_resize_max = 30
let g:lens#width_resize_min = 30
let g:lens#width_resize_max = 170
let g:lens#disabled_filetypes = ['nerdtree', 'fzf', 'coc-explorer']
nnoremap <silent> <Up>    :call animate#window_delta_height(10)<CR>
nnoremap <silent> <Down>  :call animate#window_delta_height(-10)<CR>
nnoremap <silent> <Left>  :call animate#window_delta_width(-20)<CR>
nnoremap <silent> <Right> :call animate#window_delta_width(20)<CR>
nnoremap <silent> <C-Right> :call animate#window_percent_width(0.9)<CR>

"  ---- FZF
nnoremap <C-0> :Files<Cr>

"  ---- VIM-ROOTER
let g:rooter_change_directory_for_non_project_files = 'home'
let g:rooter_patterns = ['.git', 'Makefile']

" VIM-COOL
let g:CoolTotalMatches = 1
