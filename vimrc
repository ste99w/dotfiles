" The structure of this file:
" - General Settings
" - Key-mappings
" - Plugin Settings
" - Auto Commands

" {{{ > General Settings

"> First, source the example vimrc file.
source $VIMRUNTIME/vimrc_example.vim

"> Don't backup files.
"  This will make file system events simplier, watchdog programs will behave
"  like one wants.
"  Since we'll always use a SCM tool like Git when using vim to edit files,
"  chances are we won't need these options very often.
set nobackup
set nowritebackup

"> Set backup, undo file and swap file directory.
"  This will keep the git repository clean.
"  Set backup directory.
set backupdir=~/tmp/vim.d/back.d/,/tmp/
"  Set undo file directory.
set undodir=~/tmp/vim.d/undo.d/,/tmp/
"  Set swap file directory.
set directory=~/tmp/vim.d/swap.d/,/tmp/

"> Set history to a large number.
set history=1000

"> Hide a buffer instead of close it.
"  This can be very useful when switch between buffers.
set hidden

"> Search settings
set ignorecase
"  Override 'ignorecase' when having uppercase characters.
set smartcase

"> Ignore these files when expending file names.
set wildignore=*~,*.bak,*.pyc,*.class,*.o,*.obj

"> Set text width for all files.
"  Filetype plugin should override this.
set textwidth=78

" No menu
set guioptions-=m
" No toolbar
set guioptions-=T
" No right side scrollbar
set guioptions-=r
" Font settings
" set guifont=consolas:h11
set guifont=monoid\ 9
" Increase line height.
set linespace=2
" Always show status line.
set laststatus=2
" Put cursor in the middle always.
set scrolloff=999

" }}} < General Settings

" {{{ > Key-mappings

"> Rebind <Leader> key.
let mapleader=","

"> Use jk to escape from insert mode.
"  Use - to escape from visual mode.
inoremap jk <Esc>
vnoremap - <Esc>

"> Bind :nohl to normal mode '-'(minus) key.
"  Remove the highlight of the last search, 'cause it's really annoying.
nnoremap - :nohl<CR>

"> Map Ctrl-K in command line mode to delete to the end of line.
cnoremap <C-K> <C-\>estrpart(getcmdline(), 0, getcmdpos() - 1)<CR>

"> Quicksave commands.
noremap <Leader>w :update<CR>
noremap <Leader>W :write<CR>
vnoremap <Leader>w <C-C>:update<CR>
inoremap <Leader>w <C-\><C-O>:update<CR><Esc>

"> Quick quit commands.
" Instead of quitting, what I mean is actually close that window
" This also prevents accidentally quitting VIM.
noremap <Leader>q :close<CR>
noremap <Leader>Q :qa<CR>

"> Use Ctrl+Shift+<Movement> keys to move cursor around the windows.
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

"> Go to the previous tab.
"  The default key to go to next tab is 'gt' in normal mode.
nnoremap [t :tabprevious<CR>
nnoremap ]t :tabnext<CR>

"> Move between buffers.
nnoremap ]b :bnext<CR>
nnoremap [b :bprevious<CR>

"> Move around location list.
" nnoremap [l :lprevious<CR>
" nnoremap ]l :lnext<CR>
" nnoremap <Leader>c :lclose<CR>

"> Move around quickfix list.
" nnoremap [p :cprevious<CR>
" nnoremap ]p :cnext<CR>

"> Easier moving of code blocks.
"  Useful when indenting blocks of code.
vnoremap < <gv
vnoremap > >gv

"> Stop using the arrow keys.
map <Up> <Nop>
map <Down> <Nop>
map <Left> <Nop>
map <Right> <Nop>

"> Use Tab key with to move downwards/upwards in normal mode.
nnoremap <Tab> <C-F>
nnoremap <S-Tab> <C-B>
vnoremap <Tab> <C-F>
vnoremap <S-Tab> <C-B>

"> Use <C-P> and <C-N> to do omni completion.
" inoremap <C-P> <C-X><C-P>
" inoremap <C-N> <C-X><C-N>

" }}} < Key-mappings

" {{{ > Plugin Settings (vim-plug)
call plug#begin('~/.vim/plugged')

"> nerdtree
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
if !has('gui_running')
  let g:NERDTreeDirArrowExpandable = '+'
  let g:NERDTreeDirArrowCollapsible='~'
endif
let NERDTreeWinSize=50
let NERDTreeShowBookmarks=1
let NERDTreeRespectWildIgnore=1
let NERDTreeIgnore=['__pycache__$[[dir]]']
" TODO: decide keymaps
nnoremap <Leader>nt :NERDTreeToggle<CR>
nnoremap <Leader>nc :NERDTreeCWD<CR>

"> nerdcommenter
Plug 'scrooloose/nerdcommenter'
" Add a space after the left delimiter and before the right.
let NERDSpaceDelims=1
"  Add alternative delimiters.
let NERDRemoveAltComs=1
nmap <Leader><Space> <Plug>NERDCommenterToggle
vmap <Leader><Space> <Plug>NERDCommenterToggle

"> vim-easymotion
Plug 'easymotion/vim-easymotion'
" Use single <Leader>.
map <Leader> <Plug>(easymotion-prefix)
" Disable default mappings.
let g:EasyMotion_do_mapping=0
"  Singular bi-directional find motion.
map f <Plug>(easymotion-s)
"  Bi-directional two characters find motion.
nmap <Leader>s <Plug>(easymotion-s2)
"  Turn on case sensitive feature.
let g:EasyMotion_smartcase=1
"  Keep cursor column when JK motion.
let g:EasyMotion_startofline=0
"  JK motion: Line motions.
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
"  HL motion: Inline motions.
map <Leader>h <Plug>(easymotion-linebackward)
map <Leader>l <Plug>(easymotion-lineforward)

"> unite.vim
" neomru.vim plugin includes unite.vim MRU sources.
" vimproc.vim is needed by file_rec/async resource.
Plug 'Shougo/unite.vim' | Plug 'Shougo/neomru.vim' | Plug 'Shougo/vimproc.vim', { 'do': 'make' }
" The following settings are from https://youtu.be/fwqhBSxhGU0?t=1271.
nnoremap <C-u> :Unite buffer file_mru file file_rec/async<CR>
nnoremap <C-;> :Unite line<CR>

"> vim-fugitive
Plug 'tpope/vim-fugitive'
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>gs :Gstatus<CR>

"> ultisnips
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
let g:UltiSnipsSnippetDirectories=['ultisnips', 'bundle/vim-snippets/UltiSnips', 'bundle/custom/snips']
let g:UltiSnipsSnippetsDir='~/.vim/bundle/custom/snips/'
let g:UltiSnipExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<c-n>'
let g:UltiSnipsJumpBackwardTrigger='<c-m>'
" Python settings
let g:ultisnips_python_quoting_style = 'single'
" Use for Python doc style
let g:ultisnips_python_style = 'sphinx'

"> syntastic
Plug 'vim-syntastic/syntastic'
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"> clang_complete
Plug 'Rip-Rip/clang_complete'
" This only works if the system is Arch Linux 64bit.
let g:clang_library_path='/usr/lib64/libclang.so'

"> vim-clang-format
Plug 'rhysd/vim-clang-format'

"> vim-autocomplpop
Plug 'othree/vim-autocomplpop'
Plug 'L9' " Needed by vim-autocomplpop, github: vim-scripts/L9

"> vim-airline
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_skip_empty_sections = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.notexists = '#'

"> vim-tomorrow-theme
Plug 'chriskempson/vim-tomorrow-theme'
" Set colorscheme after all plugins are loaded.

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
" Plug 'junegunn/vim-easy-align'

" Any valid git URL is allowed
" Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Group dependencies, vim-snippets depends on ultisnips
" Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
" Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Using a non-master branch
" Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
" Plug 'fatih/vim-go', { 'tag': '*' }

" Plugin options
" Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Unmanaged plugin (manually installed and updated)
" Plug '~/my-prototype-plugin'

" Add plugins to &runtimepath
call plug#end()
" }}} < Plugin Settings (vim-plug)

" {{{ > Post Plugin Settings
colorscheme Tomorrow
" }}} < Post Plugin Settings

" {{{ > Auto Commands

"> Automatic reloading .vimrc after each :write.
autocmd! BufWritePost .vimrc source %

"> Remove trailing whitespaces.
autocmd BufWritePre * :%s/\s\+$//e

" }}} < Auto Commands
