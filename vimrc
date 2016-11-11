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

"> Highlight the column boundary.
" set colorcolumn=80
" highlight ColorColumn ctermbg=black
"  Set this after the Airline Plugin Settings to behave correctly.

"> Set window height.
" set lines=27

"> Tabs or spaces? Neither, it's a war.
"  Tab settings are in the plugin folder containing specific settings for
"  different filetypes.

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

" {{{ > Plugin Settings
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

"> nerdtree
Plugin 'scrooloose/nerdtree'
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

"> nerdtree-git-plugin
" Plugin 'Xuyuanp/nerdtree-git-plugin'

"> nerdcommenter
Plugin 'scrooloose/nerdcommenter'
" Add a space after the left delimiter and before the right.
let NERDSpaceDelims=1
"  Add alternative delimiters.
let NERDRemoveAltComs=1
nmap <Leader><Space> <Plug>NERDCommenterToggle
vmap <Leader><Space> <Plug>NERDCommenterToggle

"> vim-easymotion
Plugin 'easymotion/vim-easymotion'
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
Plugin 'Shougo/unite.vim'
Plugin 'Shougo/neomru.vim' " MRU plugin includes unite.vim MRU sources
" The following settings are from https://youtu.be/fwqhBSxhGU0?t=1271.
nnoremap <C-u> :Unite file file_rec/async buffer file_mru<CR>
nnoremap <C-;> :Unite line<CR>

"> vim-fugitive
Plugin 'tpope/vim-fugitive'
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>gs :Gstatus<CR>

"> ultisnips
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
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
Plugin 'vim-syntastic/syntastic'
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"> clang_complete
Plugin 'Rip-Rip/clang_complete'
" This only works if the system is Arch Linux 64bit.
let g:clang_library_path='/usr/lib64/libclang.so'

"> vim-clang-format
Plugin 'rhysd/vim-clang-format'

"> vim-autocomplpop
Plugin 'othree/vim-autocomplpop'
Plugin 'L9' " Needed by vim-autocomplpop, github: vim-scripts/L9

"> vim-airline
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_skip_empty_sections = 1

"> vim-tomorrow-theme
Plugin 'chriskempson/vim-tomorrow-theme'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
" Install Plugins:
" Launch vim and run :PluginInstall
" To install from command line: vim +PluginInstall +qall

" }}} < Plugin Settings

" {{{ > Post Plugin Settings
colorscheme Tomorrow
" }}} < Post Plugin Settings

" {{{ > Auto Commands

"> Automatic reloading .vimrc after each :write.
autocmd! BufWritePost .vimrc source %

"> Remove trailing whitespaces.
autocmd BufWritePre * :%s/\s\+$//e

" }}} < Auto Commands
