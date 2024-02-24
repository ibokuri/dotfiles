" General settings {{{

set autowrite
set expandtab
set shiftwidth=4
set tabstop=4
set hidden
set signcolumn=yes:2
set relativenumber
set number
set termguicolors
set undofile
set nospell
set title
set ignorecase
set smartcase
set wildmode=longest:full,full
set nowrap
set list
set listchars=tab:▸\ ,trail:·
set mouse=a
set scrolloff=8
set sidescrolloff=8
set nojoinspaces
set splitright
set confirm
set exrc
set backup
set backupdir=~/.local/share/nvim/backup/
set updatetime=25 " Reduce time for highlighting other references
set redrawtime=10000 " Allow more time for loading syntax on large files
set foldlevelstart=0
set foldmethod=marker
set foldmarker={{{,}}}

" Ensure Vim returns to the same line when reopening files.
augroup line_return
    au!
    au BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \     execute 'normal! g`"zvzz' |
    \ endif
augroup END

autocmd FileType css,scss,yml,yaml setlocal shiftwidth=2 softtabstop=2 expandtab

" }}}

" Mappings {{{

let mapleader = ","

" Configuration
nmap <leader>ce :edit ~/.config/nvim/init.vim<cr>
nmap <leader>co :edit ~/.config/nvim/coc-settings.json<cr>
nmap <leader>cr :source ~/.config/nvim/init.vim<cr>

" Save
nnoremap s :w<cr>

" Quit
nnoremap K :q<cr>
nnoremap q :q<cr>

" Window tabs
nnoremap tn :tabnew<cr>
nnoremap tl :tabnext<cr>
nnoremap th :tabprev<cr>

" Window splits
nnoremap <leader>wv :vs 
nnoremap <leader>ws :split 

" Buffer navigation
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" Duplicate current buffer
noremap <leader>v <C-w>v

" Switch to previous buffer
nnoremap <leader><leader> :b#<cr>

" Select entire buffer
nnoremap vaa ggVG

" Tabs to spaces
nnoremap <leader><Tab> :retab<cr>

" Move by displayed lines
noremap j gj
noremap k gk
noremap gj j
noremap gk k

" Aliases for start/end of line
noremap H ^
noremap L $
vnoremap L g_

" Insert blank lines
nnoremap <cr> o<esc>

" Split lines
nnoremap S i<cr><esc><right>

" Select current line (excluding indentation)
nnoremap vv ^vg_

" Yank current line
nnoremap Y y$

" Delete current line
nnoremap D d$

" Remove trailing whitespace
nnoremap <leader>ww mz:%s/\s\+$//<cr>:let @/=''<cr>`z

" Substitute
nnoremap <leader>s :%s/

" Sane search regexes
nnoremap / /\v
vnoremap / /\v

" Keep search matches in the middle of the window
nnoremap n nzzzv
nnoremap N Nzzzv

" Clear search highlighting
nnoremap <leader><space> :let @/=""<cr>

" Open current directory in Finder
nnoremap <leader>O :!open .<cr>

" Toggle folds
nnoremap <Space> za
vnoremap <Space> za

" GitHub
nnoremap gh :'<,'>OpenGithubFile
nnoremap gH :OpenGithubFile

" }}}

" Plugins (I) {{{

" vim-plug
call plug#begin('~/.vim/plugged')
    " Sidebar
    Plug 'scrooloose/nerdcommenter'
    Plug 'scrooloose/nerdtree'
    Plug 'ryanoasis/vim-devicons'

    " Status Line
    Plug 'itchyny/lightline.vim'
    Plug 'itchyny/vim-gitbranch'

    " Languages
    Plug 'rust-lang/rust.vim'
    Plug 'simrat39/rust-tools.nvim'
    Plug 'zig-lang/zig.vim'

    " Code
    Plug 'markonm/traces.vim'
    Plug 'raimondi/delimitmate'
    Plug 'tpope/vim-eunuch'
    Plug 'peterrincker/vim-argumentative'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
    Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.2' }
    Plug 'rrethy/vim-illuminate'

    " LSP
    Plug 'VonHeikemen/lsp-zero.nvim', {'branch': 'v2.x'}
    Plug 'neovim/nvim-lspconfig'                           " Required
    Plug 'williamboman/mason.nvim', {'do': ':MasonUpdate'} " Optional
    Plug 'williamboman/mason-lspconfig.nvim'               " Optional

    " Autocompletion
    Plug 'hrsh7th/nvim-cmp'     " Required
    Plug 'hrsh7th/cmp-nvim-lsp' " Required
    Plug 'L3MON4D3/LuaSnip'     " Required

    " Git
    Plug 'airblade/vim-gitgutter'
    Plug 'tpope/vim-fugitive'
    Plug 'tyru/open-browser-github.vim'
    Plug 'tyru/open-browser.vim'
    Plug 'ruanyl/vim-gh-line'

    " Projects
    Plug 'airblade/vim-rooter'

    " Buffers
    Plug 'qpkorr/vim-bufkill'

    " Colors
    Plug 'chriskempson/base16-vim'
    Plug 'dracula/vim', { 'as': 'dracula' }
    Plug 'gko/vim-coloresque'
call plug#end()

" }}}

" Plugins (II) {{{

" LSP

:lua <<EOF
local lsp = require('lsp-zero').preset({})
local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
  mapping = {
    -- Navigate between completion item
    ['<C-k>'] = cmp.mapping.select_prev_item(),
    ['<C-j>'] = cmp.mapping.select_next_item(),

    -- Confirm item
    ['<Tab>'] = cmp.mapping.confirm({select = true}),
  }
})

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr})
end)

lsp.setup_servers({'zls'})

local rust_tools = require('rust-tools')
rust_tools.setup({
  server = {
    on_attach = function(client, bufnr)
      vim.keymap.set('n', '<leader>ca', rust_tools.hover_actions.hover_actions, {buffer = bufnr})
    end
  }
})

lsp.setup()
EOF


" Telescope

nnoremap <leader>f <cmd>Telescope find_files<cr>
nnoremap <leader>G <cmd>Telescope live_grep<cr>
nnoremap <leader>B <cmd>Telescope buffers<cr>

:lua << EOF
local actions = require("telescope.actions")

require("telescope").setup{
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close,

        ['<C-n>'] = false,
        ['<C-p>'] = false,
        ['<C-j>'] = actions.move_selection_next,
        ['<C-k>'] = actions.move_selection_previous,
      },
    },
  }
}

require('telescope').load_extension('fzf')
EOF

" NERDTree
let NERDTreeMinimalUI = 1

    " Close Vim if NERDTree is the only open window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let NERDTreeDirArrowExpandable = "\u25b8"
let NERDTreeDirArrowCollapsible = "\u25be"
let g:NERDTreeNodeDelimiter = "\u00a0"

    " Toggle NERDTree
noremap <leader>N :NERDTreeToggle<cr>

    " Refresh NERDTree
nmap <Leader>t :NERDTreeFocus<cr>R<c-w><c-p>


" Lightline
let g:lightline = {}
let g:lightline.subseparator = { 'left': '', 'right': '' }
let g:lightline = {
    \ 'colorscheme': 'dracula',
    \
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'readonly', 'filename', 'modified' ],
    \             [ 'gitbranch' ] ],
    \
    \   'right': [ [ 'lineinfo' ],
    \              [ 'filetype' ] ]
    \ },
    \
    \ 'component_function': {
    \   'gitbranch': 'gitbranch#name'
    \ },
    \
    \ }


" Git Gutter
nmap ga <Plug>(GitGutterStageHunk) " git add (chunk)
nmap gu <Plug>(GitGutterUndoHunk)  " git undo (chunk)

nmap gn <Plug>(GitGutterNextHunk)  " git next
nmap gp <Plug>(GitGutterPrevHunk)  " git previous


" Fugitive
nnoremap gs :Git<CR>
nnoremap gb :Git branch<CR>
nnoremap gl :Git log<CR>

nnoremap dv :Gvdiffsplit<CR>


" Git Blamer
let g:blamer_enabled = 1

" vim-illuminate
let g:Illuminate_delay = 0
let g:Illuminate_ftblacklist = ['nerdtree']


" }}}

" Color {{{

if !has('gui_running') && &term =~ '^\%(screen\|tmux\)'
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

syntax on
set termguicolors
colorscheme dracula

" }}}
