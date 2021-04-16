cd $USERPROFILE

set fileformat=unix
set clipboard^=unnamed,unnamedplus  " Get Machine Clipboard

set nocompatible  " no vi-compatible
set ls=2          " always show status bar
set bs=2          " fix backspace issues
set rnu           " relative number
set number
set showcmd
set cursorline
set backspace=2
set hlsearch
set ignorecase
set ttyfast
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
" set termguicolors     " enable true colors support


" Map jj to ESC
imap jj <ESC> 
tnoremap jj <C-\><C-n>


" Folding code By Indentation
set foldmethod=indent
set foldlevel=1
"nnoremap <space> za  " Map space key to fold/unfold


" Allow plugins by file type (required for plugins!)
filetype plugin on
"filetype indent on

" Syntax and Colors
syntax enable

" Tabs and Spaces configuration
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
"set autoindent

autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType yaml.ansible setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType sh setlocal shiftwidth=2 tabstop=2 softtabstop=2

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif


" ============================================================================
" Vim-plug initialization
let vim_plug_just_installed = 0
let vim_plug_path = expand('~/.config/nvim/autoload/plug.vim')
if !filereadable(vim_plug_path)
    echo "Installing Vim-plug..."
    echo ""
    silent !mkdir -p ~/.config/nvim/autoload
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    let vim_plug_just_installed = 1
endif

" manually load vim-plug the first time
if vim_plug_just_installed
    :execute 'source '.fnameescape(vim_plug_path)
endif

" ============================================================================
" Active Plugins
call plug#begin('~/.nvim/plugged')

Plug 'SidOfc/mkdx'
Plug 'preservim/nerdtree'
Plug 'sheerun/vim-polyglot'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'pearofducks/ansible-vim', { 'do': 'cd ./UltiSnips; ./generate.py' }
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-fugitive'
Plug 'sainnhe/gruvbox-material'
Plug 'ayu-theme/ayu-vim'
Plug 'drewtempelmeyer/palenight.vim'

call plug#end()

if vim_plug_just_installed
    echo "Installing Bundles, please ignore key map error messages"
    :PlugInstall
endif

" ============================================================================


" PLUGIN CONFIGS
" ==============

" Disable autocompletion, because I use deoplete for auto-completion
let g:jedi#completions_enabled = 0

" Whether to show function call signature
let g:jedi#show_call_signatures = '0'
" let g:deoplete#enable_at_startup = 1


" LIGHTLINE
set laststatus=2
let g:lightline = {
  \   'colorscheme': 'jellybeans',
  \   'active': {
  \     'left':[ [ 'mode', 'paste' ],
  \              [ 'gitbranch', 'readonly', 'filename', 'modified' ]
  \     ]
  \   },
  \   'component_function': {
  \     'gitbranch': 'fugitive#head',
  \   }
  \ }


" THEMES
" ---------

" AYU
"let ayucolor="light"  " for light version of theme
"let ayucolor="mirage" " for mirage version of theme
"let ayucolor="dark"   " for dark version of theme
"colorscheme ayu

" GRUVBOX_MATERIAL
"set background=dark
"colorscheme gruvbox-material
"let g:lightline.colorscheme = 'gruvbox_material'

" PALENIGHT
set background=dark
colorscheme palenight
let g:lightline.colorscheme = 'palenight'
let g:palenight_terminal_italics=1


" Ansible-Vim
au BufRead,BufNewFile *.yml set filetype=yaml.ansible cc=100
let g:ansible_name_highlight = 'b'
let g:ansible_extra_keywords_highlight = 1
"let g:ansible_normal_keywords_highlight = 'Constant'
"let g:ansible_with_keywords_highlight = 'Comment'
let g:ansible_unindent_after_newline = 1
let g:ansible_attribute_highlight = "o"


let g:python3_host_prog = 'python'

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)


"autocmd VimEnter * NERDTree
"

function! gbash()
  silent !clear
  execute "terminal " . "C:/PROGRA~1/Git/bin/bash.exe --login -i"
endfunction

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'


let g:coc_global_extensions = [
      \ 'coc-pyright',
      \ 'coc-snippets',
      \ 'coc-marketplace',
      \ 'coc-prettier',
      \ 'coc-explorer',
      \ 'coc-highlight',
      \ 'coc-omni',
      \ 'coc-omnisharp',
      \ 'coc-json',
      \ 'coc-fzf-preview'
      \ ]
autocmd BufEnter * if (winnr("$") == 1 && &filetype == 'coc-explorer') | q | endif
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
