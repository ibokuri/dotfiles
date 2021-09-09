" init.vim

" Preamble {{{

set shell=/bin/bash
let g:is_bash = 1          " For bash syntax highlighting
filetype plugin indent on  " Enable loading plugin and indent files for
                           " specific file types. It will turn on filetype if
                           " it's not already on.
set nocompatible

" }}}

" Plugins (I) {{{

" ALE (compatability with COC)
let g:ale_disable_lsp = 1

" packadd
packadd termdebug

" vim-plug
call plug#begin('~/.vim/plugged')
    " Colors
    Plug 'chriskempson/base16-vim'                   " Base-16
    Plug 'dracula/vim', { 'as': 'dracula' }          " Dracula
    Plug 'sainnhe/forest-night'                      " Forest Night
    Plug 'srcery-colors/srcery-vim'                  " Srcery
    Plug 'mhartington/oceanic-next'                  " Oceanic Next

    " NERD
    Plug 'scrooloose/nerdtree'                       " Tree Explorer
    Plug 'scrooloose/nerdcommenter'                  " Comments

    " Status Lines
    Plug 'itchyny/lightline.vim'                     " Lightline
    Plug 'itchyny/vim-gitbranch'                     " Git for Lightline

    " Languages
    "Plug 'bfrg/vim-cpp-modern'                       " C++
    Plug 'zig-lang/zig.vim'                          " Zig
    "Plug 'rust-lang/rust.vim'                        " Rust
    "Plug 'fatih/vim-go'                              " Golang
    "Plug 'plasticboy/vim-markdown'                   " Markdown

    " Code
    Plug 'tpope/vim-fugitive'                        " Git
    Plug 'airblade/vim-gitgutter'                    " Git gutter
    Plug 'w0rp/ale'                                  " Linter
    Plug 'neoclide/coc.nvim', {'branch': 'release'}  " Code completion
    Plug 'raimondi/delimitmate'                      " Completion for delimiters
    Plug 'markonm/traces.vim'                        " Match/substitute preview
    Plug 'tpope/vim-eunuch'                          " UNIX helpers

    " Projects
    Plug 'airblade/vim-rooter'                       " Project root

    " Files
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() }} " Fuzzy finder
    Plug 'junegunn/fzf.vim'                            " Fuzzy finder

    " Windows/Buffers/Tabs
    Plug 'qpkorr/vim-bufkill'                        " Close buffer w/out changing layout

    " Icons
    Plug 'ryanoasis/vim-devicons'                    " Nerd Icons

call plug#end()

" }}}

" Options {{{

" Basic
set encoding=UTF-8                     " Character encoding.
set mouse=a                            " Enable mouse clicks.
set guicursor+=n-v-c-i:blinkon0        " Disable blinking.
set autochdir                          " Changes directories to that of the edited file's.
set modelines=0                        " Sets number of lines Vim checks for set commands.
set autoindent                         " Automatically indent lines (matching previous indent).
set showcmd                            " Show info about current command in the last line of screen.
set hidden                             " Under default settings, making changes and then opening a new
                                       "  file will display 'No write since last change'.
                                       "  When on, current buffers with unsaved changes will be hidden
                                       "  instead of closed, letting you edit the new file.
set visualbell                         " Flashes the screen when EOF or EOL is hit.
set ttyfast                            " Basically speeds up scrolling.
set ruler                              " Show the line and column number of the cursor position.
set backspace=indent,eol,start         " Allow backspacing over autoindent, line
                                       " breaks, and the start of insert.
set number                             " Show line numbers.
set relativenumber                     " Show line numbers relative to the line you're on.
set laststatus=2                       " Show status line: 0: never, 1: only if there are 2+ windows, 2: always.
set history=1000                       " A history of : commands and search patterns (max: 10000).
set undofile                           " Automatically save undo history when editing a file and restores it when you edit again.
set undoreload=10000                   " Store buffer contents in undo tree if < 10,000 lines.
set lazyredraw                         " The screen won't be redrawn while execing macros/commands
set showbreak=↪                        " Character indicating start of lines that've been wrapped.
set splitbelow                         " When splitting, put new window below current one.
set splitright                         " When splitting, put new window to the right of current one.
set shiftround                         " Tabs will be set to value of 'shiftwidth'.
set title                              " Window title will be set to value of 'titlestring'.
set nolinebreak                        " Wrap long lines at a character in 'breakat'. It will NOT
                                       " affect a file's content, just it's appearance.
set colorcolumn=+1                     " highlight column after 'textwidth'
set backupskip=/tmp/*,/private/tmp/*"  " Make Vim able to edit crontab files
set ff=unix

" Leader key
let mapleader = ","

" GUI
if !has('gui_running')
    set guioptions-=m  " Disable menu bar.
    set guioptions-=T  " Disable tool bar.
endif

" Ensure Vim returns to the same line when reopening files.
augroup line_return
    au!
    au BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \     execute 'normal! g`"zvzz' |
    \ endif
augroup END

" Tabs
set tabstop=4                    " Number of spaces a <TAB> consists of.
set expandtab                    " Insert spaces whenever <TAB> is pressed.
set shiftwidth=4                 " Number of spaces inserted for indentation.

autocmd FileType c setlocal tabstop=8 shiftwidth=8

" Wrapping
set nowrap                       " Disable word wrapping.

" Undos & Backups
set backup                       " Enable backups
set noswapfile                   " Disable swap files.

set undodir=~/.vim/tmp/undo/     " Directory for undo files.
set backupdir=~/.vim/tmp/backup/ " Directory for backup files.

" Make the undo/backup directories if they don't exist.
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif

" YAML
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" }}}}

" Mappings {{{

" Save
nnoremap s :w<cr>

" Sudo Save
nnoremap <leader>w :w !sudo tee "%"<cr>

" Source %
nnoremap <leader>S :source %<cr>

" Manpage for the word you're on
nnoremap <leader>m K

" Find file
nnoremap <leader>f :FZF<cr>

" Kill window
nnoremap K :q<cr>

" Turn tabs to spaces
nnoremap <leader><Tab> :retab<cr>

" Make all windows equal
nnoremap - :wincmd =<cr>

" Splits
nnoremap <leader>wv :vs 
nnoremap <leader>ws :split 

" Switch to previous buffer
nnoremap <leader><leader> :b#<cr>

" Toggle line numbers
nnoremap <leader>n :setlocal number!<cr>

" Tabs (window tabs, not editing tabs)
nnoremap <leader>t :tabnew<cr>
nnoremap <leader>> :tabnext<cr>
nnoremap <leader>< :tabprev<cr>

" Wrap toggle
nnoremap <leader>W :set wrap!<cr>

" Insert blank lines with Enter
nnoremap <cr> o<esc>

" Split lines
nnoremap S i<cr><esc><right>

" Yank to EOL
nnoremap Y y$

" Yank entire file
nnoremap <leader>Y ggvGg_"+y``

" Clean trailing whitespace
nnoremap <leader>ww mz:%s/\s\+$//<cr>:let @/=''<cr>`z

" Select yanked section
nnoremap <leader>V V`]

" Select entire buffer
nnoremap vaa ggvGg_
nnoremap Vaa ggVG

" Uppercase word
    " Usage: type in lowercase, and at the end, press <c-u> to uppercase it.
inoremap <C-u> <esc>mzgUiw`za

" Substitute
nnoremap <leader>s :%s/

" Select contents of current line excluding indentation
nnoremap vv ^vg_

" Typos
command! -bang E e<bang>
command! -bang Q q<bang>
command! -bang W w<bang>
command! -bang QA qa<bang>
command! -bang Qa qa<bang>
command! -bang Wa wa<bang>
command! -bang WA wa<bang>
command! -bang Wq wq<bang>
command! -bang WQ wq<bang>

" Open current directory in Finder
nnoremap <leader>O :!open .<cr>

" Zip Right
" Move character under cursor to EOL. Useful for when you mis-typed print()foo.
nnoremap zl :let@z=@"<cr>x$p:let @"=@z<cr>

" }}}

" Search/Movement {{{

" Ripgrep
nnoremap <leader>g :Rg<cr>

" Use sane regexes
nnoremap / /\v
vnoremap / /\v

set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch
set gdefault

set scrolloff=5
set sidescroll=1
set sidescrolloff=10

" Clear search highlighting
nnoremap <leader><space> :let @/=""<cr>

" Keep search matches in the middle of the window
nnoremap n nzzzv
nnoremap N Nzzzv

" Same when jumping around
nnoremap g; g;zz
nnoremap g, g,zz
nnoremap <c-o> <c-o>zz

" Substitute
nnoremap <leader>s :%s/

" Delete to EOL
nnoremap D d$

" Aliases for start/end of line
noremap H ^
noremap L $
vnoremap L g_

" Move by displayed lines
noremap j gj
noremap k gk
noremap gj j
noremap gk k

" Easy buffer navigation
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

noremap <leader>v <C-w>v

" Matchit uses Tab now to go to the matching paren, brace, etc.
runtime macros/matchit.vim
map <tab> %
silent! unmap [%
silent! unmap ]%

" }}}

" Folding {{{

set foldlevelstart=0

" Fold Markers
set foldmethod=marker
set foldmarker={{{,}}}

" Space to toggle folds.
nnoremap <Space> za
vnoremap <Space> za

" }}}

" Plugins (II) {{{

" Ale

    " Options
let g:ale_lint_delay=0
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚠'

    " Close error buffer when the associated file is closed
autocmd QuitPre * if empty(&bt) | lclose | endif

    " Go to next/prev error/warning
nmap <silent> <C-n> <Plug>(ale_next_wrap)
nmap <silent> <C-p> <Plug>(ale_previous_wrap)


" Coc
    " Mappings
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

    " Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

    " Space for displaying messages
set cmdheight=1

    " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
    " delays and poor user experience.
set updatetime=300

    " Don't pass messages to |ins-completion-menu|.
set shortmess+=c


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
nmap <Leader>r :NERDTreeFocus<cr>R<c-w><c-p>


" FZF
let $FZF_DEFAULT_COMMAND = 'ag -g ""'


" Ripgrep
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)


" Lightline
let g:lightline = {}

let g:lightline.subseparator = { 'left': '', 'right': '' }

let g:lightline = {
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
      \   'filename': 'LightlineFilename',
      \   'gitbranch': 'gitbranch#name',
      \ },
      \
      \ }

function! LightlineFilename()
  let root = fnamemodify(get(b:, 'git_dir'), ':h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:]
  endif
  return expand('%')
endfunction


" Markdown
let g:vim_markdown_folding_disabled = 1

" }}}

" Colors {{{

syntax on
hi clear SignColumn
set background=dark
let base16colorspace=256

if (has("termguicolors"))
    set termguicolors
endif

hi StatusLine ctermbg=NONE cterm=NONE

"colorscheme base16-gruvbox-dark-hard
colorscheme base16-atelier-dune

"let g:oceanic_next_terminal_bold = 1
"let g:oceanic_next_terminal_italic = 1
"colorscheme OceanicNext

" }}}
