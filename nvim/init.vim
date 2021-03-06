"
" PLUGINS
" ----------------------------------------------------------

let g:polyglot_disabled = ['markdown']

call plug#begin('~/.config/nvim/plugged')

" SYNTAX
Plug 'sheerun/vim-polyglot'
Plug 'neovim/nvim-lspconfig'
Plug 'RishabhRD/popfix'
Plug 'hrsh7th/nvim-compe'
Plug 'hashivim/vim-terraform'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'pearofducks/ansible-vim'

" MARKDOWN
Plug 'SidOfc/mkdx', {'for': 'markdown'}
Plug 'npxbr/glow.nvim', {'do':':GlowInstall','branch':'main','for': 'markdown'}
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

" SEARCH UTILS
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" DEVELOPER IMPROVEMENTS
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'Yggdroot/hiPairs'
Plug 'airblade/vim-rooter'
Plug 'Konfekt/FastFold', {'for': 'python'}
Plug 'tmhedberg/SimpylFold', {'for': 'python'}
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

" UI
Plug 'karb94/neoscroll.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'romgrk/barbar.nvim'
Plug 'hoob3rt/lualine.nvim'
Plug 'voldikss/vim-floaterm' 
Plug 'sunjon/shade.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'camspiers/animate.vim'
Plug 'camspiers/lens.vim'
Plug 'RRethy/vim-illuminate'
Plug 'romainl/vim-cool'
"Plug 'ryanoasis/vim-devicons'

" THEMES
Plug 'rktjmp/lush.nvim'
Plug 'ellisonleao/gruvbox.nvim'
Plug 'navarasu/onedark.nvim'
Plug 'ayu-theme/ayu-vim'
Plug 'bkegley/gloombuddy'
Plug 'projekt0n/github-nvim-theme'
Plug 'marko-cerovac/material.nvim'
Plug 'bluz71/vim-nightfly-guicolors'
Plug 'bluz71/vim-moonfly-colors'
Plug 'Pocco81/Catppuccino.nvim'
Plug 'EdenEast/nightfox.nvim'

call plug#end()


" SET CONFIGS
" ----------------------------------------------------------
" init.vim
"let g:nvy = 1
if has('win32')
    let g:python3_host_prog = expand('C:/Python39/python.exe')
else
    let g:python3_host_prog = expand('/usr/bin/python3')
endif

if has('termguicolors')
  set termguicolors
endif

set completeopt=menuone,noselect
set shortmess+=c
filetype plugin on
filetype indent on
syntax enable
"set fileformat=unix
set clipboard^=unnamed,unnamedplus    " Get Machine Clipboard

set guioptions=c                      " no gui options bar
set mouse=a                           " enable mouse
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
set novisualbell
set noerrorbells
"set showmatch
set nobackup
set nowritebackup
set nowrap
"set tags=tags;
"set colorcolumn=80
"set spelllang=pt_br,en
set noswapfile
set noshowmode
"

"" Tabs and Spaces configuration
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
"set autoindent
"set smartindent
"
" Fold configs
set foldmethod=syntax
set foldlevel=99
set foldenable

" Syntax fixes
au BufNewFile,BufRead *,ps1,*.vim setlocal colorcolumn=
au BufEnter,BufNew *.aclpolicy set ft=yaml

" Vim jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Useful mappings
let maplocalleader = ";"
let mapleader = ","
nnoremap <leader>H :cd ~/code<cr>
imap jj <ESC>
tnoremap JJ <C-\><C-n>
tnoremap <S-space> <space>
cmap <C-v> <C-R>+
"Remove all trailing whitespace by pressing F5
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>
nnoremap <Leader>q :bdelete<CR>

inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>
cnoremap <C-h> <Left>
cnoremap <C-j> <Down>
cnoremap <C-k> <Up>
cnoremap <C-l> <Right>

" FUNCTIONS
" ----------------------------------------------------------

" Check backspace for coc completion with tab
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" ScriptRunner
command! -nargs=1 GitPushAll :!git add -A && git commit -m <q-args> && git push
command! -nargs=1 ScriptRunner :FloatermNew --title=ScriptRunner($1/$2) powershell "echo '<q-args>' | powershell.exe -File //afs/Rotinas/ScriptRunner/SubmitScript.ps1"
command! -nargs=1 ScriptRunnerHom :FloatermNew --title=ScriptRunner($1/$2) powershell "echo '<q-args>' | powershell.exe -File //afs/Rotinas/ScriptRunner/SubmitScriptHom.ps1"


" PLUGIN CONFIGS
" ----------------------------------------------------------

" ANSIBLE-VIM
let g:ansible_extra_keywords_highlight = 1
let g:ansible_name_highlight = 'b'

"  ---- FZF
nnoremap <silent> <leader>fz :FZF<Cr>

"  ---- VIM-ROOTER
"let g:rooter_change_directory_for_non_project_files = 'home'
let g:rooter_patterns = ['.git', 'Makefile', 'secrets.yaml']

"  ---- VIM-COOL
let g:CoolTotalMatches = 1

"  ---- TERRAFORM
let g:terraform_align=1

"  ---- MKDX
let g:mkdx#settings = { 'highlight': { 'enable': 1 },
  \  'enter': { 'shift': 1 },
  \  'links': { 'external': { 'enable': 1 } },
  \  'toc': { 'text': 'Table of Contents', 'update_on_write': 1 },
  \  'fold': { 'enable': 1 } }

"  ---- TELESCOPE
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fe <cmd>lua require('telescope.builtin').file_browser()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

"  ---- TERMINAL (floaterm)
if has('win32')
    let g:floaterm_shell = 'powershell'
else
    let g:floaterm_shell = 'bash'
endif

"hi FloatermBorder guifg=orchid1
"hi Floaterm guibg=gray5 guifg=white
let g:floaterm_position = 'center'
let g:floaterm_height = 0.8
let g:floaterm_width = 0.8
nnoremap <silent> <C-x><C-p> :FloatermNew --title=Powershell($1/$2) --name=ps powershell<cr>
nnoremap <silent> <C-x><C-b> :FloatermNew --title=bash($1/$2) --name=sh bash<cr>
nnoremap <silent> <C-x><C-g> :FloatermNew --title=LazyGit($1/$2) --width=0.8 --height=0.8 --position=center --name=git lazygit<cr>
nnoremap <silent> <C-x><C-x> :FloatermToggle<cr>
tnoremap <silent> <C-x><C-x> <C-\><C-n>:FloatermToggle<cr>
nnoremap <silent> <C-x><C-j> <C-\><C-n>:FloatermNext<cr>
tnoremap <silent> <C-x><C-j> <C-\><C-n>:FloatermNext<cr>


"  ---- LENS / ANIMATE
let g:animate#duration = 60.0
let g:animate#easing_func = 'animate#ease_out_cubic'
let g:lens#height_resize_min = 10
let g:lens#height_resize_max = 30
let g:lens#width_resize_min = 30
let g:lens#width_resize_max = 150
let g:lens#disabled_filetypes = ['nerdtree', 'fzf', 'coc-explorer']
nnoremap <silent> <Up>    :call animate#window_delta_height(10)<CR>
nnoremap <silent> <Down>  :call animate#window_delta_height(-10)<CR>
nnoremap <silent> <Left>  :call animate#window_delta_width(-20)<CR>
nnoremap <silent> <Right> :call animate#window_delta_width(20)<CR>
nnoremap <silent> <C-Right> :call animate#window_percent_width(0.9)<CR>

"  ---- FUGITIVE
nnoremap <Leader>gs :Git<cr><c-w>T
command! GitRepo :execute '!start "" "' . FugitiveRemoteUrl('origin') . '"'



"  ---- NVIM-COMPE
let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:true
let g:compe.debug = v:false
let g:compe.min_length = 1
let g:compe.preselect = 'enable'
let g:compe.throttle_time = 80
let g:compe.source_timeout = 200
let g:compe.incomplete_delay = 400
let g:compe.max_abbr_width = 100
let g:compe.max_kind_width = 100
let g:compe.max_menu_width = 100
let g:compe.documentation = v:true
let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = v:true
let g:compe.source.calc = v:true
let g:compe.source.nvim_lsp = v:true
let g:compe.source.nvim_lua = v:true
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })



"require'lspconfig'.pyright.setup{
"  on_attach = require'compe'.on_attach,
"}
"  ---- LUA MODULES
lua << EOF
require'lspconfig'.powershell_es.setup{
  bundle_path = os.getenv("HOME")..'/PowershellES',
  on_attach = require'compe'.on_attach
} 

require'lspconfig'.terraformls.setup{}
require'shade'.setup({
  overlay_opacity = 50,
  opacity_step = 1,
  keys = {
    brightness_up    = '<C-Up>',
    brightness_down  = '<C-Down>',
    toggle           = '<Leader>s',
  }
})

require'lspconfig'.yamlls.setup{
    cmd = {"yaml-language-server.cmd", "--stdio"}
}

require'lspconfig'.jedi_language_server.setup{}

require("plenary.reload").reload_module("lualine", true)
require('lualine').setup {
    options = {theme = 'onedark'}
}

require('neoscroll').setup({
    -- All these keys will be mapped to their corresponding default scrolling animation
    mappings = {'<C-u>', '<C-d>', '<C-b>', '<C-f>',
                '<C-y>', '<C-e>', 'zt', 'zz', 'zb'},
    hide_cursor = true,          -- Hide cursor while scrolling
    stop_eof = true,             -- Stop at <EOF> when scrolling downwards
    use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
    respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
    cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
    easing_function = nil,       -- Default easing function
    pre_hook = nil,              -- Function to run before the scrolling animation starts
    post_hook = nil,             -- Function to run after the scrolling animation ends
    performance_mode = false,    -- Disable "Performance Mode" on all buffers.
})
EOF

let g:neovide_cursor_vfx_mode = "ripple"

set guifont="Literation NF":h10
set background=dark
let g:material_style = 'lighter'
let g:onedark_config = {
  \ 'style': 'darker',
  \ 'toggle_style_key': '<leader>ts',
  \ 'ending_tildes': v:true,
  \ 'diagnostics': {
    \ 'darker': v:false,
    \ 'background': v:false,
  \ },
\ }
colorscheme onedark
set t_Co=256

