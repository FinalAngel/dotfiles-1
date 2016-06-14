set nocompatible
runtime! macros/matchit.vim
" Leader Mappings
let mapleader = ","

" Add bundles
call plug#begin('~/.vim/bundle/')

Plug 'KabbAmine/vCoolor.vim'
let g:vcoolor_map = '<c-b>'

Plug 'gorodinskiy/vim-coloresque'

Plug 'scrooloose/nerdtree'
" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
  exec 'autocmd FileType nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
  exec 'autocmd FileType nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

au VimEnter * call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
au VimEnter * call NERDTreeHighlightFile('html', 'green', 'none', 'green', '#151515')
au VimEnter * call NERDTreeHighlightFile('slim', 'green', 'none', 'green', '#151515')
au VimEnter * call NERDTreeHighlightFile('coffee', '5', 'none', '#ff00ff', '#151515')
au VimEnter * call NERDTreeHighlightFile('styl', '5', 'none', '#ff00ff', '#151515')
au VimEnter * call NERDTreeHighlightFile('less', '5', 'none', '#ff00ff', '#151515')
au VimEnter * call NERDTreeHighlightFile('scss', '5', 'none', '#ff00ff', '#151515')
au VimEnter * call NERDTreeHighlightFile('sass', '5', 'none', '#ff00ff', '#151515')
au VimEnter * call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
au VimEnter * call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
au VimEnter * call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
au VimEnter * call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
au VimEnter * call NERDTreeHighlightFile('rc', 'yellow', 'none', 'yellow', '#151515')
au VimEnter * call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
au VimEnter * call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
au VimEnter * call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
au VimEnter * call NERDTreeHighlightFile('js', 'cyan', 'none', 'cyan', '#151515')
au VimEnter * call NERDTreeHighlightFile('rb', 'Red', 'none', '#ffa500', '#151515')
au VimEnter * call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')

map <Leader>n :NERDTreeToggle<CR>
map <Leader>k :NERDTreeFind<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeWinSize=35
let g:NERDTreeMinimalUI=1

nmap c* cgn

" -------------------
"  Ctrl-P FuzzyFinder
" -------------------
Plug 'ctrlpvim/ctrlp.vim'
Plug 'nixprime/cpsm', {
      \   'do': './install.sh'
      \ }
let g:ctrlp_match_func = {'match': 'cpsm#CtrlPMatch'}
let g:cpsm_query_inverting_delimiter = " "
let g:ctrlp_max_files = 0
let g:ctrlp_line_prefix = ' '
let g:ctrlp_map='<c-p>'
let g:ctrlp_cmd = 'CtrlPMixed'
" let g:ctrlp_dotfiles = 1
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("v")': ['<c-v>', '<RightMouse>', '<c-s>'],
    \ 'AcceptSelection("h")': ['<c-x>', '<c-cr>', '<c-i>'],
\ }
let g:ctrlp_buffer_func = { 'enter': 'BrightHighlightOn', 'exit':  'BrightHighlightOff', }
function BrightHighlightOn()
  highlight  CursorLine ctermbg=238 ctermfg=None
endfunction
function BrightHighlightOff()
  highlight  CursorLine ctermbg=237 ctermfg=None
endfunction
" use ctrl p for searching
nnoremap \ :CtrlPLine<cr>
" Tag fzf
nnoremap <leader>t :CtrlPTag<cr>

" -------------------
" A collection of +70 language packs for Vim
" -------------------
Plug 'sheerun/vim-polyglot'
let g:polyglot_disabled = ['javascript']
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
let g:markdown_fenced_languages = ["ruby", "C=c", "c", "bash=sh",
      \ "sh", "html", "css", "vim", "python"]
Plug 'jelera/vim-javascript-syntax'

" -------------------
" leader m to expand a split
" -------------------
Plug 'blarghmatey/split-expander'

" -------------------
" A Vim plugin which shows a git diff in the numberline
" -------------------
Plug 'airblade/vim-gitgutter'
let g:gitgutter_map_keys = 0

" Insert or delete brackets
Plug 'cohama/lexima.vim'
nmap <leader>p :let b:lexima_disabled=1<CR>

" -------------------
" . command after a plugin map
" -------------------
Plug 'tpope/vim-repeat'

" -------------------
" surround
" -------------------
Plug 'tpope/vim-surround'

" -------------------
" https://languagetool.org/fr/
" -------------------
Plug 'rhysd/vim-grammarous'
let g:grammarous#jar_url = 'https://www.languagetool.org/download/LanguageTool-3.3.zip'
let g:grammarous#hooks = {}
function! g:grammarous#hooks.on_check(errs)
    nmap <buffer><C-n> <Plug>(grammarous-move-to-next-error)
    nmap <buffer><C-p> <Plug>(grammarous-move-to-previous-error)
endfunction

function! g:grammarous#hooks.on_reset(errs)
    nunmap <buffer><C-n>
    nunmap <buffer><C-p>
endfunction

function! GetLang() " return lang
  call inputsave()
  let lang = input('Enter the lang (fr,en) ')
  if(empty(lang)) | return | endif
  call inputrestore()
  return lang
endfunction

function! Comments() " comment or not
  call inputsave()
  let chr = input('Comments Only (y,n) ')
  call inputrestore()
  if chr == 'y'
    return "--comments-only"
  else
    return "--no-comments-only"
  endif
endfunction

nnoremap <leader>R :GrammarousReset<cr>
nnoremap <Leader>S :GrammarousCheck
      \ --lang=<c-r>=GetLang()<cr> <c-r>=Comments()<cr><cr>

vnoremap <Leader>S :'<,'> GrammarousCheck
      \ --lang=<c-r>=GetLang()<cr> <c-r>=Comments()<cr><cr>

" -------------------
" Replace + motion
" -------------------
Plug 'vim-scripts/ReplaceWithRegister'
" gr replace motion

" -------------------
" Aligning text
" -------------------
Plug 'junegunn/vim-easy-align'
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

" -------------------
" Always highlight enclosing tags HTML XML
" -------------------
Plug 'Valloric/MatchTagAlways'

" -------------------
" Commanter
" -------------------
Plug 'scrooloose/nerdcommenter'
let NERDUsePlaceHolders=0
let NERDSpaceDelims=1
let g:NERDCustomDelimiters = {
    \ 'c': { 'left' : '//', 'leftAlt' : '/*', 'rightAlt': '*/' },
\ }

" -------------------
" syntastic
" -------------------
Plug 'scrooloose/syntastic'

" configure syntastic syntax checking to check on save
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_loc_list_height=5

" -------------------
" THEME-SYNTAX
" -------------------
"Plug 'altercation/vim-colors-solarized'
Plug 'morhetz/gruvbox'
let g:gruvbox_contrast_dark="medium"
let g:gruvbox_contrast_light="medium"

let g:gruvbox_sign_column="dark0"
let g:gruvbox_color_column="dark0"
let g:gruvbox_vert_split="dark0"

" tmux-navigator configuration
Plug 'christoomey/vim-tmux-navigator'

" -------------------
"  Powerline status line
" -------------------
Plug 'itchyny/lightline.vim'

let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&filetype=="netrw"?"":&readonly?"":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":""}',
      \ },
      \ 'component_function': {
      \   'filename':     'LightLineFilename',
      \   'fileformat':   'LightlineFileformat',
      \   'filetype':     'LightlineFiletype',
      \   'fileencoding': 'LightlineFileencoding',
      \   'ctrlp':        'LightlineCtrlP',
      \   'ctrlpNbfile':  'LightlineCtrlPNbFile',
      \   'mode':         'LightlineMode',
      \   'percent':      'LightlineFilepercent',
      \ },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste', 'spell', 'readonly' ],
      \             [ 'filename', 'ctrlp', 'ctrlpNbfile', 'modified' ] ],
      \   'right': [ [ 'lineinfo' ], ['percent'],
      \ [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &filetype!="netrw" && &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified))',
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' }
      \ }


function! LightlineMode()
  let fname = expand('%:t')
  return fname == 'ControlP' ? 'CtrlP' :
        \ fname =~ 'NERD_tree' ? 'NERDTree' :
        \ fname == '__Mundo__' ? 'Gundo' :
        \ fname == '__Mundo_Preview__' ? 'Gundo Preview' :
        \ winwidth(0) > 70 ? lightline#mode() : ''
endfunction

function! LightLineFilename()
  let l:basename=expand('%:p:h')
  let l:filename=expand('%:t')
  if l:filename =~'__Mundo\|NERD_tree\|ControlP\|NetrwTree'
    return ''
  endif
  if l:filename == ''
    return '[New File]'
  endif
  " If the Path is too long just print the 2 directory above
  if strlen(l:basename) > 50
    return substitute(l:basename , ".*/\\ze.*/", '../', '').'/'.l:filename
  endif
  " Make sure we show $HOME as ~.
  return substitute(l:basename . '/', '\C^' . $HOME, '~', '').l:filename
endfunction

" CtrlP Status Line Section return ctrlP current state
function! LightlineCtrlP()
  if expand('%:t') =~ 'ControlP'
    if exists('g:lightline.ctrlp_status')
      return g:lightline.ctrlp_status
    else
      if exists('g:lightline.ctrlp_item')
        return g:lightline.ctrlp_item
      endif
    endif
  else
    return ''
  endif
endfunction

function! LightlineCtrlPNbFile()
  if expand('%:t') =~ 'ControlP'
    if exists('g:lightline.ctrlp_item')
      return g:lightline.ctrlp_marked
    endif
  endif
  return ''
endfunction

" Set CtrlP statusline callback functions
let g:ctrlp_status_func = {
\ 'main': 'LightlineCtrlPStatusMain',
\ 'prog': 'LightlineCtrlPStatusProgress',
\ }

function! LightlineCtrlPStatusMain(focus, byfname, regex, prev, item, next, marked)
  let g:lightline.ctrlp_item = a:item
  let g:lightline.ctrlp_marked = a:marked
  silent! unlet g:lightline.ctrlp_status
  return lightline#statusline(0)
endfunction

function! LightlineCtrlPStatusProgress(status)
  let g:lightline.ctrlp_status = a:status
  return lightline#statusline(0)
endfunction

function! LightlineFileformat()
  let l:filename=expand('%:t')
  if l:filename =~'__Mundo\|NERD_tree\|ControlP\|NetrwTree'
    return ''
  endif
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFiletype()
  let l:filename=expand('%:t')
  if l:filename =~'__Mundo\|NERD_tree\|ControlP\|NetrwTree'
    return ''
  endif
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : '?') : ''
endfunction

function! LightlineFileencoding()
  let l:filename=expand('%:t')
  if l:filename =~'__Mundo\|NERD_tree\|ControlP\|NetrwTree'
    if l:filename =~ 'ControlP'
      return 'path :'
    endif
    return ''
  endif
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! LightlineFilepercent()
  let l:filename=expand('%:t')
  if l:filename =~'__Mundo\|NERD_tree\|ControlP\|NetrwTree'
    if l:filename =~ 'ControlP'
      return getcwd()
    endif
    return ''
  endif
  return winwidth(0) > 70 ? (line('.') * 100 / line('$') . '%') : ''
endfunction

" -------------------
" <leader>u for git like undo
" -------------------
Plug 'simnalamburt/vim-mundo'
nnoremap <leader>u :MundoToggle<CR>
let g:mundo_width=70
let g:mundo_playback_delay=40
let g:mundo_verbose_graph=0

" -------------------
" AUTO-complete
" -------------------

" Plug 'ajh17/VimCompletesMe'
" let g:vcm_direction = 'n'
" let b:vcm_tab_complete = 'tags'

" OR
Plug 'Shougo/neocomplete.vim'

let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#auto_completion_start_length = 1
let g:neocomplete#enable_fuzzy_completion = 1
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"
inoremap <expr><leader><leader>  pumvisible() ? "\<C-y>" : "\<esc>:w!\<cr>"
nnoremap <leader><leader> :w!<cr>

"  Snippets
" -------------------
Plug 'SirVer/ultisnips'

" Snippets are separated from the engine.
Plug 'honza/vim-snippets'
let g:UltiSnipsSnippetDirectories=["UltiSnips", $HOME.'/dotfiles/snippets']

" 'SirVer/ultisnips' options.
let g:UltiSnipsExpandTrigger="<leader><tab>"
let g:UltiSnipsJumpForwardTrigger  = "<leader><leader>"

let g:simpledb_show_timing = 0
Plug 'ivalkeen/vim-simpledb'
Plug 'krisajenkins/vim-postgresql-syntax'

" ----------------------------- END -----------------------------
call plug#end()

" Theme
colorscheme gruvbox
set background=dark

"  256 colors
set t_Co=256

" Set cursor to vertical line when in insert mode.
let &t_EI = "\<Esc>[2 q"
if exists('$TMUX')
  let &t_SI="\ePtmux;\e\e[6 q\e\\"
  let &t_EI="\ePtmux;\e\e[2 q\e\\"
endif
set guicursor=a:blinkon0

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

set wildignore+=.hg,.git,.svn                           " Version control
set wildignore+=*.aux,*.out,*.toc                       " LaTeX intermediate files
" set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg          " binary images
set wildignore+=*.luac                                  " Lua byte code
set wildignore+=*.o,*.lo,*.obj,*.exe,*.dll,*.manifest   " compiled object files
set wildignore+=*.pyc                                   " Python byte code
set wildignore+=*.spl                                   " compiled spelling word lists
set wildignore+=*.sw?                                   " Vim swap files
set wildignore+=*~,*.swp,*.tmp                          " Swp and tmp files
set wildignore+=*.DS_Store?                             " OSX bullshit

filetype plugin indent on

" Regenerate tags
noremap <leader>rt :!ctags --extra=+f --exclude=.git --exclude=log -R * <CR><C-M>

" Clipboard
if has('unnamedplus')
  set clipboard=unnamed,unnamedplus
endif

" Show command
set showcmd

" lightline powerline status
set laststatus=2 " Always display the statusline in all windows
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)

" highlight vertical column of cursor
au WinLeave * set nocursorline nocursorcolumn
au WinEnter * set cursorline
set cursorline

" 80 columns
set colorcolumn=80      " highlight the 80 column
set synmaxcol=190

" relativ number
set numberwidth=4
set relativenumber
set number

" -- Beep
set visualbell   " Empeche Vim de beeper
set noerrorbells " Empeche Vim de beeper

" tell it to use an undo file
set undofile
" set a directory to store the undo history
set undodir=~/.vimundo/

set backspace=2  " Backspace deletes like most programs in insert mode
set nobackup     " No *.ext~
set nowritebackup
set noswapfile   " No *.swp
set history=500
set ruler        " show the cursor position all the time
set incsearch    " do incremental searching
set hlsearch     " highlight matches
set autowrite    " Automatically :write before running commands
set showmatch    "  Highlight matching brace

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set expandtab

" Case
set smartcase
set ignorecase

" UTF-8
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set fileformat=unix

" Display extra whitespace
set sidescroll=1
set nowrap
set list listchars=tab:▸\ ,trail:·,extends:›,precedes:‹
highlight SpecialKey ctermbg=none cterm=none

set spellfile=~/dotfiles/spell/ownSpellFile.utf-8.add

set ttyfast    " u got a fast terminal
set lazyredraw
set fillchars=vert:\|

nnoremap <Leader>zz :let &scrolloff=999-&scrolloff<CR>
set so=7

" Enable mouse use in all modes
set mouse=a

" Open vimrc in new tab
map <leader>vim :tabe ~/.vimrc<cr>
" Open vim help on the left of the screen
autocmd FileType help wincmd L

" To make vsplit put the new buffer on the right/below of the current buffer:
set splitbelow
set splitright

" resizing a window split
map <Left> <C-w>10<
map <Down> <C-W>5-
map <Up> <C-W>5+
map <Right> <C-w>10>

" TIME Out len
set timeoutlen=300 ttimeoutlen=0

" ALT keys Mappings
function! Altmap(char)
  if has('gui_running') | return ' <A-'.a:char.'> ' | else | return ' <Esc>'.a:char.' '|endif
endfunction

"Moving lines
execute 'nnoremap'.Altmap('k').":m .-2<CR>=="
execute 'nnoremap'.Altmap('j').":m .+1<CR>=="
execute 'vnoremap'.Altmap('k').":m '<-2<CR>gv=gv"
execute 'vnoremap'.Altmap('j').":m '>+1<CR>gv=gv"

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Quicker navigation
noremap H 0^
noremap L g_
" noremap K 5k
" noremap J 5j
noremap J }
noremap K {

inoremap ;; <esc>A;<esc>

"Easy :noh
map <leader>h :noh<cr>

" Switch CMD to the dir of the open buffer
map <leader>cd :cd %:p:h<cr> :pwd<cr>

" Sudo save
cmap w!! w !sudo tee > /dev/null %

" Insert New line
noremap U o<ESC>

" Përfect tag closer (xml)
inoremap </ </<C-x><C-o>

" searching
function! s:nice_next(cmd)
  let view = winsaveview()
  execute "normal! " . a:cmd
  if view.topline != winsaveview().topline
    normal! zz
  endif
endfunction

nnoremap <silent> n :call <SID>nice_next('n')<cr>
nnoremap <silent> N :call <SID>nice_next('N')<cr>

" Spell-Checking
" zg add word to the spelling dictionary
" zw remove it
nnoremap <silent> <leader>en <Esc>:silent setlocal spell! spelllang=en<CR>
nnoremap <silent> <leader>fr <Esc>:silent setlocal spell! spelllang=fr<CR>
nnoremap <silent> <leader>all <Esc>:silent setlocal spell! spelllang=fr,en<CR>
nnoremap <silent> <leader>a <Esc>zg
nnoremap <silent> <leader>d <Esc>zw
hi clear SpellBad
hi clear SpellRare
hi clear SpellLocal
hi SpellBad   cterm=underline ctermfg=9  ctermbg=0 gui=undercurl
hi SpellCap   cterm=underline ctermfg=14 ctermbg=0 gui=undercurl
hi SpellRare  cterm=underline ctermfg=13 ctermbg=0 gui=undercurl
hi SpellLocal cterm=underline ctermfg=11 ctermbg=0 gui=undercurl

autocmd BufRead,BufNewFile *.md setlocal spell spelllang=fr,en
autocmd FileType gitcommit setlocal spell spelllang=fr,en
execute 'nnoremap'.Altmap('s')."ei<c-x>s"

" no more ex Mode
nnoremap Q <nop>

" use space for moving to the newt word
noremap <space> 2w

noremap <F1> <Nop>

" Pipe output of shell command into vim buffer
function! ShellIntoBuff()
  call inputsave()
  let cmd = input('Enter shell cmd: ')
  call inputrestore()
  execute 'new | r !'.cmd.''
endfunction
cnoreabbrev shell call ShellIntoBuff()

" remapping
cnoreabbrev qwa wqa
cnoreabbrev qw wq
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev aq qa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev qq q
cnoreabbrev push !cat\|push <c-r>=expand('%:t')<cr> > /tmp/up.tmp<cr>u:vs /tmp/up.tmp<cr> :set ft=help

" open file name under cursor create if necessary
nnoremap gf :view <cfile><cr>

" Align blocks of text and keep them selected
nmap < <C-v><
nmap > <C-v>>
vmap < <gv
vmap > >gv

" FileType syntax highlight
au BufNewFile,BufRead *.conf setf ngnix

" Enable omni completion.
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType css setlocal omnifunc=

" --------------------------
" function
" --------------------------
" Go to the last known cursor position in a file
autocmd BufReadPost *
    \ if !(bufname("%") =~ '\(COMMIT_EDITMSG\)') &&
    \   line("'\"") > 1 && line("'\"") < line("$") |
    \   exe "normal! g`\"" |
    \ endif

autocmd FileType gitcommit startinsert

" Remove trailing whitespace on save ignore markdown files
function! s:RemoveTrailingWhitespaces()
  "Save last cursor position
  let l = line(".")
  let c = col(".")
  %s/\s\+$//ge
  call cursor(l,c)
endfunction

let blacklist = ['md', 'markdown', 'mrd', 'markdown.pandoc']
au BufWritePre * if index(blacklist, &ft) < 0 | :call <SID>RemoveTrailingWhitespaces()

" This allows you to visually select a section and then hit @ to run a macro on all lines.
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>
function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction

" Visual search mappings
function! s:VSetSearch()
  let temp = @@
  norm! gvy
  let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
  let @@ = temp
endfunction
vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR>
vnoremap # :<C-u>call <SID>VSetSearch()<CR>??<CR>
