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
set spell
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
set updatetime=300 " Reduce time for highlighting other references
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

" }}}

" Mappings {{{

let mapleader = ","

" Configuration
nmap <leader>ce :edit ~/.config/nvim/init.vim<cr>
nmap <leader>cc :edit ~/.config/nvim/coc-settings.json<cr>
nmap <leader>cr :source ~/.config/nvim/init.vim<cr>

" Save
nnoremap s :w<cr>

" Quit
nnoremap K :q<cr>

" Window tabs
nnoremap <leader>T :tabnew<cr>
nnoremap <leader>> :tabnext<cr>
nnoremap <leader>< :tabprev<cr>

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

" Find
nnoremap <leader>r :Rg<cr>
nnoremap <leader>f :Files<cr>
nnoremap <leader>F :GFiles<cr>

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

" }}}

" Plugins (I) {{{

" ALE (compatability with COC)
let g:ale_disable_lsp = 1

" packadd
packadd termdebug

" vim-plug
call plug#begin('~/.vim/plugged')
    " Colors
    Plug 'chriskempson/base16-vim'
    Plug 'dracula/vim', { 'as': 'dracula' }

    " NERD
    Plug 'scrooloose/nerdcommenter'
    Plug 'scrooloose/nerdtree'

    " Status Lines
    Plug 'itchyny/lightline.vim'
    Plug 'itchyny/vim-gitbranch'

    " Languages
    Plug 'fatih/vim-go'
    Plug 'rust-lang/rust.vim'
    Plug 'zig-lang/zig.vim'

    " Code
    Plug 'airblade/vim-gitgutter'
    Plug 'markonm/traces.vim'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'raimondi/delimitmate'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-eunuch'
    Plug 'w0rp/ale'

    " Projects
    Plug 'airblade/vim-rooter'

    " Files
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() }}
    Plug 'junegunn/fzf.vim'

    " Windows/Buffers/Tabs
    Plug 'qpkorr/vim-bufkill'

    " Icons
    Plug 'ryanoasis/vim-devicons'

call plug#end()

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
"nmap <silent> <C-n> <Plug>(ale_next_wrap)
"nmap <silent> <C-p> <Plug>(ale_previous_wrap)


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
nmap <Leader>R :NERDTreeFocus<cr>R<c-w><c-p>


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


" Markdown
let g:vim_markdown_folding_disabled = 1


" Fugitive
nnoremap <leader>gd :Gdiffsplit!<CR>
nnoremap gdh :diffget //2<CR>
nnoremap gdl :diffget //3<CR>


" vim-go
let g:go_list_type = "quickfix"
let g:go_metalinter_autosave = 1
let g:go_doc_keywordprg_enabled = 0

map <C-n> :cnext<CR>
map <C-p> :cprevious<CR>
nnoremap <leader>a :cclose<CR>

autocmd FileType go nmap <leader>r <Plug>(go-run)
autocmd FileType go nmap <leader>t <Plug>(go-test)
autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
autocmd FileType go nmap <Leader>d <Plug>(go-doc)

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>


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
