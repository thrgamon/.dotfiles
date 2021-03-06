"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer: 
"       Amir Salihefendic — @amix3k
"
" Awesome_version:
"       Get this config, nice color schemes and lots of plugins!
"
"       Install the awesome version from:
"
"           https://github.com/amix/vimrc
"
" Sections:
"    -> General
"    -> VIM user interface
"    -> Colors and Fonts
"    -> Files and backups
"    -> Text, tab and indent related
"    -> Visual mode related
"    -> Moving around, tabs and buffers
"    -> Status line
"    -> Editing mappings
"    -> vimgrep searching and cope displaying
"    -> Spell checking
"    -> Misc
"    -> Helper functions
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=500

" Copy to system clipboard
set clipboard+=unnamedplus

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" Triger `autoread` when files changes on disk
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
" https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
" Notification after file change
" https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
autocmd FileChangedShellPost *
\ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>
nmap <leader>wq :wq<cr>

" :W sudo saves the file 
" (useful for handling the permission-denied error)
" command W w !sudo tee % > /dev/null


" Set shell to zsh
set shell=zsh

" Remap esc to escape terminal input
tnoremap <expr> <Esc> (&filetype == "fzf") ? "<Esc>" : "<c-\><c-n>"
" " Enter insert mode when you enter a terminal window
" autocmd BufWinEnter,WinEnter term://* startinsert
" " Go to normal mode when you leave a terminal window
" autocmd BufLeave term://* stopinsert

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" enable mouse scrolling with tmux
set mouse=a

" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Avoid garbled characters in Chinese language windows OS
let $LANG='en' 
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" Turn on the Wild menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
  set wildignore+=.git\*,.hg\*,.svn\*
else
  set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

"Always show current position
set ruler

" Height of the command bar
set cmdheight=2

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases 
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch 

" Don't redraw while executing macros (good performance config)
set lazyredraw 

" I don't know what this does but I set it because someone told me to
" Something to do with scrollspeed or something.
set ttyfast

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch 
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Properly disable sound on errors on MacVim
if has("gui_macvim")
  autocmd GUIEnter * set vb t_vb=
endif

" Add a bit extra margin to the left
set foldcolumn=1

" Sets cursor styles
" Block in normal, line in insert, underline in replace
set guicursor=n-v-c-sm:block,i-ci-ve:ver25-Cursor,r-cr-o:hor20

" Set hybrid  line number to appear
set number  
set nu

set cursorline

" Use tree view in :Explore
let g:netrw_liststyle = 3

" Remove the banner from netrw
let g:netrw_banner = 0

" Hide useless files
let g:netrw_list_hide= '.git*,.DS_Store,.byebug_histor,.editor-config,.idea,.vscode'

" Open file to right when using 'v'
let g:netrw_altv=1

" Set visual indicator at 100 chars
set colorcolumn=100

" Neovim only. 
" inccommand shows you in realtime what changes your ex command
" should make. Right now it only supports s, but even that is 
" incredibly useful. If you type :s/regex, it will highlight what
" matches regex. If you then add /change, it will show all matches
" replaced with change
set inccommand=nosplit
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable 

" Allow truecolor
set termguicolors

" Enable 256 colors palette in Gnome Terminal
if $COLORTERM == 'gnome-terminal'
  set t_Co=256
endif

set background=dark

" Set extra options when running in GUI mode
if has("gui_running")
  set guioptions-=T
  set guioptions-=e
  set t_Co=256
  set guitablabel=%M\ %t
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=2
set tabstop=2

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines


""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>
vnoremap <silent> \ :<C-u>call VisualSelection('', '')<CR>:Rg <C-R>=@/<CR><CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
map <c-space> ?

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :Bclose<cr>:tabclose<cr>gT

" Close all the buffers
map <leader>ba :bufdo bd<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 
map <leader>t<leader> :tabnext 

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()


" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers 
try
set switchbuf=useopen,usetab
set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Split panes in a way that feels more natural for me
set splitbelow
set splitright

""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%t%m%r%h\ %w\ \ \%l:%c\ %=%.50F

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
map 0 ^

" Move a line of text using ALT+[jk] or Command+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
nmap <D-j> <M-j>
nmap <D-k> <M-k>
vmap <D-j> <M-j>
vmap <D-k> <M-k>
endif

" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
  let save_cursor = getpos(".")
  let old_query = getreg('/')
  silent! %s/\s\+$//e
  call setpos('.', save_cursor)
  call setreg('/', old_query)
endfun

if has("autocmd")
  autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif

inoremap kj <Esc>

" Don't jump to next match with asterix
nnoremap * *``
nnoremap * :keepjumps normal! mi*`i<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Toggle paste mode on and off
" map <leader>pp :setlocal paste!<cr>

" Persistent undo, even if you close and reopen Vim
set undofile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Returns true if paste mode is enabled
function! HasPaste()
  if &paste
      return 'PASTE MODE  '
  endif
  return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
  let l:currentBufNum = bufnr("%")
  let l:alternateBufNum = bufnr("#")

  if buflisted(l:alternateBufNum)
      buffer #
  else
      bnext
  endif

  if bufnr("%") == l:currentBufNum
      new
  endif

  if buflisted(l:currentBufNum)
      execute("bdelete! ".l:currentBufNum)
  endif
endfunction

function! CmdLine(str)
  call feedkeys(":" . a:str)
endfunction 

function! VisualSelection(direction, extra_filter) range
  let l:saved_reg = @"
  execute "normal! vgvy"

  let l:pattern = escape(@", "\\/.*'$^~[]")
  let l:pattern = substitute(l:pattern, "\n$", "", "")

  if a:direction == 'gv'
      call CmdLine("Ack '" . l:pattern . "' " )
  elseif a:direction == 'replace'
      call CmdLine("%s" . '/'. l:pattern . '/')
  endif

  let @/ = l:pattern
  let @" = l:saved_reg
endfunction

" Allows us to jump between do/end def/end etc. in Ruby
runtime macros/matchit.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Search
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if executable('rg')
" Use rg over grep
set grepprg=rg\ --vimgrep\ --no-heading
endif

" bind \ (backward slash) to grep shortcut
nnoremap \ :Rg<SPACE>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if empty(glob('~/.vim/autoload/plug.vim'))
silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
  \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')
" Theme
Plug 'morhetz/gruvbox'
" Adds rails specific functionality
Plug 'tpope/vim-rails'
" Git commands
Plug 'tpope/vim-fugitive'
" Add and change surrounding characters i.e. (), [], ''
Plug 'tpope/vim-surround'
" Integration with hub - github cli - :Gbrowse
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-unimpaired'
" Select a block and comment it out
Plug 'tpope/vim-commentary'
" Adds the end after do, the end after def etc.
Plug 'tpope/vim-endwise'
" Convert strings and search and replace
Plug 'tpope/vim-abolish'
" Convert strings and search and replace
Plug 'tpope/vim-bundler'
" Syntax highlighting for a bunch of languages
Plug 'sheerun/vim-polyglot'
" File Explorer
Plug 'scrooloose/nerdtree'
" Bring in FZF installed on the system
Plug '/usr/local/opt/fzf'
" Bring FZF into vim
Plug 'junegunn/fzf.vim'
" More generic testing commands for a bunch of languages
Plug 'janko/vim-test'
" Visual interface to the undo tree
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
" Open the buffer in Marked
Plug 'itspriddle/vim-marked'
" Autocompletion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Show git gutter
Plug 'airblade/vim-gitgutter', { 'on':  'GitGutterToggle' }
" Allow shortcuts to use ruby objects
Plug 'kana/vim-textobj-user'
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'skywind3000/asyncrun.vim'
Plug 'rhysd/git-messenger.vim'
call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""
" Vim Test
"""
nnoremap <leader>tn :TestNearest<Cr>
nnoremap <leader>tf :TestFile<Cr>
nnoremap <leader>ts :TestSuite<Cr>
nnoremap <leader>tl :TestLast<Cr>
nnoremap <leader>tv :TestVisit<Cr>

function! AsyncSplit(cmd) abort
  let g:test#strategy#cmd = a:cmd
  call test#strategy#asyncrun_setup_unlet_global_autocmd()
  execute 'AsyncRun -mode=term -pos=bottom -rows=10 -focus=0 -post=echo\ eval("g:asyncrun_code\ ?\"Failure\":\"Success\"").":"'
          \ .'\ substitute(g:test\#strategy\#cmd,\ "\\",\ "",\ "") '.a:cmd
endfunction

let g:test#custom_strategies = {'async_split': function('AsyncSplit')}
let g:test#strategy = 'async_split'

let g:test#ruby#rspec#executable = "bin/rspec" 
let g:test#javascript#jest#executable = "yarn test" 

let docker_repo = $DOCKER_REPO
if docker_repo == 'true'
  let g:test#ruby#rspec#executable = "docker-compose run app bin/rspec" 
endif

"""
"Nerdtree
"""
"Close nerdtree if it is the last window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let NERDTreeMinimalUI=1
let NERDTreeMinimalMenu=1
let NERDTreeAutoDeleteBuffer=1
let NERDTreeQuitOnOpen=1

" Open nerdtree with ctrl+n
map <C-n> :NERDTreeToggle<CR>

nmap - :NERDTreeFind<CR>

"""
" FZF
"""
let $FZF_DEFAULT_COMMAND='rg --files --smart-case'

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

command! -bang -nargs=* Factories call fzf#vim#files('spec/factories')
command! -bang -nargs=* Models call fzf#vim#files('app/models')
command! -bang -nargs=* Specs call fzf#vim#files('spec')
command! -bang EditedFiles call fzf#run(fzf#wrap({ 'source': 'git diff --name-only `git merge-base origin/master HEAD`'}))

nnoremap <leader>p :Files<Cr>
nnoremap <leader>b :Buffers<Cr>
nnoremap <leader>m :Models<Cr>
nnoremap <leader>h :History<Cr>
nnoremap <leader>/ :Helptags<Cr>
nnoremap <leader>ff :Factories<Cr>
nnoremap <leader>s :Specs<Cr>
nnoremap <C-p> :Files<Cr>


"""
" Vim Signify
"""

let g:signify_vcs_list = ['git']

"""
" Fugitive
"""
function! ToggleGstatus()
    if buflisted(bufname('.git/index'))
        bd .git/index
    else
        Gstatus
    endif
endfunction

command! ToggleGstatus :call ToggleGstatus()

nnoremap <leader>gs :ToggleGstatus<Cr>
nnoremap <leader><leader> :ToggleGstatus<Cr>
nnoremap <leader>gp :Gpush<Cr>
nnoremap <leader>gh :0Glog -10<Cr>
nnoremap <leader>ge :Gedit<Cr>

"""
" Git Messenger
"""

nnoremap <leader>gm :GitMessenger<Cr>


"""
" COC
"""
let g:coc_global_extensions = ['coc-solargraph']
let g:coc_disable_startup_warning = 1

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap<tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
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
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <leader>la  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <leader>le  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <leader>lc  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <leader>lo  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <leader>ls  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <leader>lj  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <leader>lk  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <leader>lp  :<C-u>CocListResume<CR> 
"""
" Gruvbox
"""

colorscheme gruvbox
set background=dark

"""
" AsyncRun
"""

" Make it cooperate with vim-fugitive
" https://github.com/skywind3000/asyncrun.vim/wiki/Cooperate-with-famous-plugins#fugitive
command! -bang -nargs=* -complete=file Make AsyncRun -program=make @ <args>

augroup vimrc
    autocmd User AsyncRunStart call asyncrun#quickfix_toggle(8, 1)
augroup END

"""
" AsyncRun
"""

" Make it cooperate with vim-fugitive
" https://github.com/skywind3000/asyncrun.vim/wiki/Cooperate-with-famous-plugins#fugitive
command! -bang -nargs=* -complete=file Make AsyncRun -program=make @ <args>

augroup vimrc
    autocmd User AsyncRunStart call asyncrun#quickfix_toggle(8, 1)
augroup END

"""
" Keymaps
"""

nnoremap <leader>l :Run bundle exec standardrb --fix % <Cr>
nnoremap <leader>c :silent ! echo % \| pbcopy <Cr>
nnoremap <leader>1 :set relativenumber!<Cr>
nnoremap <leader>ev :vsplit ~/.vimrc<Cr>
nnoremap <leader>sv :source ~/.vimrc<Cr>
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

"""
" AutoCommands
""" 
autocmd VimEnter * echom(system("shuf -n 1 ~/.dotfiles/pragprog.txt \| tr -d '\n'"))
autocmd FileType markdown map <buffer> <C-G> ...

vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>
vnoremap <leader>wt 
nnoremap <leader>r :Run 

"""
" Custom Commands
"""
command! -nargs=0 DumpSchema Run bundle exec rails graphql:dump_schema
command! -nargs=0 RunEditedSpecs Run bundle exec bin/rspec $(git diff --name-only --diff-filter=d $(git merge-base origin/master HEAD) | grep -E ".*(spec.rb)$")
command! -nargs=0 LintEditedFiles Run bundle exec standardrb --fix $(git diff --name-only --diff-filter=d $(git merge-base origin/master HEAD) | grep -E "\.rb$" | grep -v "^db")
command! -nargs=* ST split | terminal <args>
command! -nargs=* VT vsplit | terminal <args>
command! -nargs=* Run AsyncRun -mode=term -pos=bottom -rows=10 -focus=0 <args>
command! -bang -nargs=* Run AsyncRun -mode=term -pos=bottom -rows=10 <args>
command! -nargs=0 OOOSpecs Run bundle exec bin/rspec spec/one_on_ones spec/graphql/integration/one_on_ones spec/graphql/integration/one_on_ones_spec.rb spec/graphql/integration/mutations/one_on_ones spec/graphql/integration/subscriptions
command! -nargs=0 PR ! gh pr view --web
