" General settings {{{

" Automatically save before certain commands
set autowrite

" Use spaces instead of tabs
set expandtab

" Number of spaces to use for each step of (auto)indent
set shiftwidth=4

" Number of spaces a tab character counts for
set tabstop=4

" Allow switching buffers without saving
set hidden

" Always display the sign column, with a width of 2
set signcolumn=yes:2

" Show relative line numbers
set relativenumber

" Show absolute line numbers
set number

" Enable 24-bit RGB color in the TUI
set termguicolors

" Enable persistent undo
set undofile

" Disable spell-checking by default
set nospell

" Set the window title
set title

" Ignore case in searches
set ignorecase

" Override ignorecase if search includes uppercase letters
set smartcase

" Command-line completion mode
set wildmode=longest:full,full

" Don't automatically wrap text
set nowrap

" Display tabs and trailing spaces visually
set list
set listchars=tab:▸\ ,trail:·

" Enable mouse support in all modes
set mouse=a

" Keep 8 lines visible above and below the cursor while scrolling
set scrolloff=8
set sidescrolloff=8

" Don't add two spaces after a period when joining lines
set nojoinspaces

" Open vertical splits to the right of the current window
set splitright

" Ask for confirmation before closing unsaved files
set confirm

" Allow the use of local vimrc files in directories
set exrc

" Enable backups
set backup

" Set the backup directory
set backupdir=~/.local/share/nvim/backup/

" Reduce time for highlighting other references to 25ms
set updatetime=25

" Allow more time (10 seconds) for loading syntax on large files
set redrawtime=10000

" Start with all folds closed
set foldlevelstart=0

" Use markers for folding
set foldmethod=marker

" Define fold markers
set foldmarker={{{,}}}

" Override tab settings for specific file types
autocmd FileType css,scss,yml,yaml setlocal shiftwidth=2 softtabstop=2 expandtab

" }}}

" Mappings {{{

" Set the leader key to a comma
let mapleader = ","

" Key mappings for editing and reloading configuration files
nmap <leader>ce :edit ~/.config/nvim/init.vim<cr>
nmap <leader>co :edit ~/.config/nvim/coc-settings.json<cr>
nmap <leader>cr :source ~/.config/nvim/init.vim<cr>

" Save the current buffer
nnoremap s :w<cr>

" Quit Neovim
nnoremap K :q<cr>
nnoremap q :q<cr>

" Window tab management
nnoremap tn :tabnew<cr>
nnoremap tl :tabnext<cr>
nnoremap th :tabprev<cr>

" Window split management
nnoremap <leader>wv :vs 
nnoremap <leader>ws :split 

" Navigate between splits using Ctrl + h/j/k/l
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" Duplicate the current buffer into a vertical split
noremap <leader>v <C-w>v

" Switch to the previously used buffer
nnoremap <leader><leader> :b#<cr>

" Select the entire buffer content
nnoremap vaa ggVG

" Convert tabs to spaces according to settings
nnoremap <leader><Tab> :retab<cr>

" Navigate by visual lines
noremap j gj
noremap k gk
noremap gj j
noremap gk k

" Move to the beginning and end of the line
noremap H ^
noremap L $
vnoremap L g_

" Insert a blank line below the current line
nnoremap <cr> o<esc>

" Split the current line at the cursor
nnoremap S i<cr><esc><right>

" Select the current line, excluding indentation
nnoremap vv ^vg_

" Yank (copy) from the cursor to the end of the line
nnoremap Y y$

" Delete from the cursor to the end of the line
nnoremap D d$

" Remove trailing whitespace
nnoremap <leader>ww mz:%s/\s\+$//<cr>:let @/=''<cr>`z

" Start a substitute command over the entire buffer
nnoremap <leader>s :%s/

" Use very magic mode for search expressions
nnoremap / /\v
vnoremap / /\v

" Center the search match in the window and open any folds containing it
nnoremap n nzzzv
nnoremap N Nzzzv

" Clear the search highlight
nnoremap <leader><space> :let @/=""<cr>

" Open the current directory in the Finder (macOS specific)
nnoremap <leader>O :!open .<cr>

" Toggle folding at the cursor
nnoremap <Space> za
vnoremap <Space> za

" Open the current file on GitHub
nnoremap gh :'<,'>OpenGithubFile
nnoremap gH :OpenGithubFile

" }}}

" Plugins (I) {{{

" vim-plug plugin manager, begins a block for declaring plugins
call plug#begin('~/.vim/plugged')

    " Sidebar plugins
    Plug 'scrooloose/nerdcommenter'
    Plug 'scrooloose/nerdtree'
    Plug 'ryanoasis/vim-devicons'

    " Status line plugins
    Plug 'itchyny/lightline.vim'
    Plug 'itchyny/vim-gitbranch'

    " Language-specific plugins
    Plug 'rust-lang/rust.vim'
    Plug 'simrat39/rust-tools.nvim'
    Plug 'zig-lang/zig.vim'
    Plug 'gleam-lang/gleam.vim'

    " Code utilities
    Plug 'markonm/traces.vim'
    Plug 'raimondi/delimitmate'
    Plug 'tpope/vim-eunuch'
    Plug 'peterrincker/vim-argumentative'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
    Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.2' }
    Plug 'rrethy/vim-illuminate'
    Plug 'farmergreg/vim-lastplace'

    " LSP (Language Server Protocol) plugins
    Plug 'VonHeikemen/lsp-zero.nvim', {'branch': 'v2.x'}
    Plug 'neovim/nvim-lspconfig'
    Plug 'williamboman/mason.nvim', {'do': ':MasonUpdate'}
    Plug 'williamboman/mason-lspconfig.nvim'

    " Autocompletion plugins
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'L3MON4D3/LuaSnip'

    " Git plugins
    Plug 'airblade/vim-gitgutter'
    Plug 'tpope/vim-fugitive'
    Plug 'tyru/open-browser-github.vim'
    Plug 'tyru/open-browser.vim'
    Plug 'ruanyl/vim-gh-line'

    " Project-specific plugins
    Plug 'airblade/vim-rooter'

    " Buffer management plugins
    Plug 'qpkorr/vim-bufkill'

    " Colorschemes
    Plug 'chriskempson/base16-vim'
    Plug 'dracula/vim', { 'as': 'dracula' }
    Plug 'gko/vim-coloresque'

" End the block for declaring plugins
call plug#end()

" }}}

" Plugins (II) {{{

" LSP (Language Server Protocol) configuration in Lua
:lua <<EOF
local lsp = require('lsp-zero').preset({})
local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
  mapping = {
    -- Navigate between completion items
    ['<C-k>'] = cmp.mapping.select_prev_item(),
    ['<C-j>'] = cmp.mapping.select_next_item(),

    -- Confirm completion item
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

" Telescope configuration in Lua
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

" NERDTree configuration
let NERDTreeMinimalUI = 1

" Close Vim if NERDTree is the only open window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let NERDTreeDirArrowExpandable = "\u25b8"
let NERDTreeDirArrowCollapsible = "\u25be"
let g:NERDTreeNodeDelimiter = "\u00a0"

" Toggle NERDTree and refresh it
noremap <leader>N :NERDTreeToggle<cr>
nmap <Leader>t :NERDTreeFocus<cr>R<c-w><c-p>

" Lightline statusline configuration
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

" Git Gutter mappings for staging, undoing, and navigating hunks
nmap ga <Plug>(GitGutterStageHunk)
nmap gu <Plug>(GitGutterUndoHunk)
nmap gn <Plug>(GitGutterNextHunk)
nmap gp <Plug>(GitGutterPrevHunk)

" Fugitive mappings for Git commands
nnoremap gs :Git<CR>
nnoremap gb :Git branch<CR>
nnoremap gl :Git log<CR>
nnoremap dv :Gvdiffsplit<CR>

" Enable Git Blamer to show blame information
let g:blamer_enabled = 1

" vim-illuminate configuration
let g:Illuminate_delay = 0
let g:Illuminate_ftblacklist = ['nerdtree']

" }}}

" Color settings {{{

" Enable true color support in terminal and set colorscheme
if !has('gui_running') && &term =~ '^\%(screen\|tmux\)'
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

syntax on
set termguicolors
colorscheme dracula

" }}}
