set nocompatible

filetype off

" dein.vim
" http://qiita.com/delphinus/items/00ff2c0ba972c6e41542

let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  let g:rc_dir  = expand('~/.vim/rc')

  call dein#add('Shougo/dein.vim')
  call dein#add('Shougo/vimproc', {'build': 'make'})

  call dein#add('LeafCage/foldCC.vim')

  call dein#add('jceb/vim-hier')
  call dein#add('dannyob/quickfixstatus')
  call dein#add('itchyny/lightline.vim')
  call dein#add('sjl/badwolf')
  call dein#add( 'ctrlpvim/ctrlp.vim')
  call dein#add('nathanaelkane/vim-indent-guides')

  " カーソル位置のコンテキストに合わせてftを切り替える
  call dein#add('osyo-manga/vim-precious', {'depends':'context_filetype.vim'})
  " カーソル位置のコンテキストのftを判定するライブラリ
  call dein#add('Shougo/context_filetype.vim')

  call dein#add('junegunn/vim-easy-align')

  call dein#add('w0rp/ale')

  call dein#add('othree/html5.vim', {'on_ft': ['html','slim','jade', 'pug']})

  call dein#add('pangloss/vim-javascript', {'on_ft': ['javascript']})
  call dein#add('hail2u/vim-css3-syntax', {'on_ft':['css','sass','stylus','scss']})
  call dein#add('cakebaker/scss-syntax.vim', {'on_ft':['scss']})
  call dein#add('slim-template/vim-slim', {'on_ft':['slim']})
  call dein#add('wavded/vim-stylus', {'on_ft':['stylus']})
  call dein#add('kchmck/vim-coffee-script', {'on_ft':['coffee']})
  call dein#add('digitaltoad/vim-pug', {'on_ft':['jade', 'pug']})
  call dein#add('squizlabs/PHP_CodeSniffer', {'build':'make','on_ft':['php']})
  call dein#add('jwalton512/vim-blade', {'on_ft':['php']})
  call dein#add('posva/vim-vue')

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

filetype plugin indent on     " Required!
autocmd BufNewFile,BufRead *.slim setfiletype slim
autocmd BufNewFile,BufRead *.styl setfiletype stylus
au BufRead,BufNewFile,BufReadPre *.jade set filetype=pug
autocmd FileType vue syntax sync fromstart
"autocmd BufRead,BufNewFile *.vue set filetype=html

autocmd Filetype html setlocal ts=2 sw=2 expandtab
autocmd Filetype css setlocal ts=2 sw=2 expandtab
autocmd Filetype javascript setlocal ts=2 sw=2 expandtab
autocmd Filetype stylus setlocal ts=2 sw=2 expandtab
autocmd Filetype php setlocal ts=4 sw=4 expandtab

let g:vimproc_dll_path = '$HOME/.cache/dein/repos/github.com/Shougo/vimproc/lib/vimproc_mac.so'

syntax on

set hlsearch
set ignorecase
set number
set ruler
set incsearch
set nocompatible
set list
set listchars=tab:^\ ,nbsp:%
set showmatch
set smartindent
set autoindent
set title
set cursorline
set backspace=indent,eol,start
"set clipboard=unnamed,autoselect
set smartcase
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set nomore
set foldtext=FoldCCtext()
set nrformats=alpha
set modifiable
command T vert rightb term
"set splitbelow
"set termwinsize=7x0

let mapleader = "\<Space>"

let g:vue_disable_pre_processors=1

set spelllang=en,cjk

fun! s:SpellConf()
  redir! => syntax
  silent syntax
  redir END

  set spell

  if syntax =~? '/<comment\>'
    syntax spell default
    syntax match SpellMaybeCode /\<\h\l*[_A-Z]\h\{-}\>/ contains=@NoSpell transparent containedin=Comment contained
  else
    syntax spell toplevel
    syntax match SpellMaybeCode /\<\h\l*[_A-Z]\h\{-}\>/ contains=@NoSpell transparent
  endif

  syntax cluster Spell add=SpellNotAscii,SpellMaybeCode
endfunc

augroup spell_check
  autocmd!
  autocmd BufReadPost,BufNewFile,Syntax * call s:SpellConf()
augroup END

"====================================
" color settings
"====================================
colorscheme badwolf
let g:badwolf_css_props_highlight = 0

augroup HighlightTrailingSpaces
  autocmd!
  autocmd VimEnter,WinEnter,ColorScheme * highlight TrailingSpaces term=underline guibg=Red ctermbg=Red
  autocmd VimEnter,WinEnter * match TrailingSpaces /\s\+$/
augroup END

" 行を強調表示
set cursorline

" 列を強調表示
set cursorcolumn

" アンダーラインを引く(color terminal)
highlight CursorLine cterm=underline ctermfg=NONE ctermbg=NONE
highlight CursorLine gui=underline guifg=NONE guibg=NONE

highlight CursorColumn ctermbg=black
highlight CursorColumn guibg=black

highlight SpellBad cterm=undercurl,bold
highlight SpellBad gui=undercurl,bold

set colorcolumn=80

"===============================
" key-remap
" ==============================
imap <c-j> <esc>
noremap <CR> o<ESC>

"===============================
"folding settings
"===============================
set foldmethod=indent
set foldlevel=1
set foldnestmax=2
set foldlevelstart=0
set foldminlines=1

augroup foldmethod-syntax
  autocmd!
  autocmd InsertEnter * if &l:foldmethod ==# 'syntax'
  \                   |   setlocal foldmethod=manual
  \                   | endif
  autocmd InsertLeave * if &l:foldmethod ==# 'manual'
  \                   |   setlocal foldmethod=syntax
  \                   | endif
augroup END

"====================================
" copy+paste w/ clipbord
"====================================
if ($OSTYPE!='cygwin') && ($OSTYPE!='msys')
  vmap <silent> sy :!pbcopy; pbpaste<CR>
  map <silent> sp <esc>o<esc>v:!pbpaste<CR>
else
  vmap <silent> sy :!putclip; getclip<CR>
  map <silent> sp <esc>o<esc>v:!getclip<CR>
endif


" IME 無効化
"set imsearch=-1
if ($OSTYPE!='cygwin') && ($OSTYPE!='msys')
    if has("win32")
        inoremap <esc> <esc>:set iminsert=0<cr>  " ESCでIMEを確実にOFF
    endif
endif

" tab switching
" http://qiita.com/tekkoc/items/f5157419be57b17fd24a
"
function! s:toggle_indent()
    if &tabstop == 2
        set expandtab
        set shiftwidth=4
        set tabstop=4
        set softtabstop=4
    else
        set expandtab
        set shiftwidth=2
        set tabstop=2
        set softtabstop=2
    endif
endfunction
nnoremap <silent> <Space>ot :<C-u>call <SID>toggle_indent()<CR>

"let g:lightline = {
"      \ 'colorscheme': 'wombat',
"      \ }
"
set laststatus=2

let g:ale_linters = {
\   'javascript': ['eslint'],
\   'coffee': ['coffee','coffeelint'],
\   'css': ['stylelint'],
\   'styl': ['stylelint'],
\   'jade': ['pug-lint'],
\   'pug': ['pug-lint'],
\   'php': ['phpcs'],
\   'python': ['pylint'],
\   'ts': ['tslint'],
\   'slim': ['slim-lint'],
\   'vue': ['eslint'],
\}

let g:ale_linter_aliases = {'vue': 'css'}
let g:ale_fixers = {
\   'javascript': ['eslint'],
\   'vue': ['eslint'],
\}

let g:ale_fix_on_save = 1
let g:ale_sign_error = 'X('
let g:ale_sign_warning = ':('
let g:ale_linters_explicit = 1
let g:ale_set_signs = 1
let g:ale_set_highlights = 1
let b:ale_linter_aliases = ['javascript', 'vue']

" Indent guide
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * hi IndentGuidesOdd  guibg=black  ctermbg=black
autocmd VimEnter,Colorscheme * hi IndentGuidesEven guibg=gray66 ctermbg=237
