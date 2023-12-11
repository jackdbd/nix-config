" make use of terminal colors
set termguicolors

colorscheme NeoSolarized
set background=dark

set hidden

let mapleader=","
let maplocalleader=","

" use X clipboard
set clipboard=unnamed
set clipboard=unnamedplus

" detect file type for plugins and indentation
filetype plugin indent on
syntax enable

" do not display mode line
set nomodeline

" convert tabs to two spaces
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

" text display settings
set wrap
set textwidth=0
set wrapmargin=0
set formatoptions=qrn1
set linebreak
set number
set scrolloff=15

nmap <leader>N :set number!<CR>

" auto-completion for menu commands
set wildmenu
set wildmode=list:longest

" do not use terminal bell, only display visual
set visualbell

" highlight line under cursor
set cursorline

" search settings
set hlsearch
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch

" complete % to current file
nnoremap <tab> %
vnoremap <tab> %

" toggle search highlight
nmap <silent>H :set hls!<CR>

" toggle invisible characters
nmap <silent>L :set list!<CR>
set listchars=tab:▸\ ,eol:¬,space:·

" fix movement on wrapped lines
nnoremap j gj
nnoremap k gk
nnoremap 0 g0
nnoremap $ g$
" TODO: fix movement on wrapped lines also in visual mode

" TODO: simplify split movement

" easy motion
" prefix
map <Leader> <Plug>(easymotion-prefix)

" search
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)

" fuzzy search
function! s:config_easyfuzzymotion(...) abort
  return extend(copy({
  \   'converters': [incsearch#config#fuzzyword#converter()],
  \   'modules': [incsearch#config#easymotion#module({'overwin': 1})],
  \   'keymap': {"\<CR>": '<Over>(easymotion)'},
  \   'is_expr': 0,
  \   'is_stay': 1
  \ }), get(a:, 1, {}))
endfunction

noremap <silent><expr> <Space>/ incsearch#go(<SID>config_easyfuzzymotion())

" move to character
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)

" move to line
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)

" move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

" enhance hjkl
map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>h <Plug>(easymotion-linebackward)

let g:EasyMotion_startofline = 0 " keep cursor column when JK motion
" auto completion
let g:deoplete#enable_at_startup = 1
set completeopt=menu,noselect
let g:UltiSnipsExpandTrigger='<c-space>'
let g:UltiSnipsJumpForwardTrigger='<tab>'
let g:UltiSnipsJumpBackwardTrigger='<s-tab>'

inoremap <expr><tab> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><s-tab> pumvisible() ? "\<C-p>" : "\<TAB>"

" IDE
let g:LanguageClient_serverCommands = {
\  'python': ['pyls'],
\  'go': ['gopls'],
\ }

let g:LanguageClient_diagnosticsList = "Disabled"

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <silent> gh :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent>gt :call LanguageClient#textDocument_typeDefinition()<CR>
nnoremap <silent> gr :call LanguageClient_textDocument_references()<CR>
nnoremap <silent> gs :call LanguageClient_textDocument_documentSymbol()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
nnoremap <silent> gf :call LanguageClient_textDocument_formatting()<CR>

" also run `goimports` when formatting in `vim-go`
let g:go_fmt_command = "goimports"

" format on file save, workaround for
" <https://github.com/fatih/vim-go/issues/2471>
autocmd BufWritePre,FileWritePre *.go :GoFmt
autocmd BufWritePre,FileWritePre *.go :GoMetaLinter

" go back
nnoremap gb <C-o>

augroup autoformat_settings
  autocmd FileType nix AutoFormatBuffer nixpkgs-fmt
  autocmd FileType bzl AutoFormatBuffer buildifier
  autocmd FileType c,cpp AutoFormatBuffer cpplint
  autocmd FileType proto,javascript,arduino AutoFormatBuffer clang-format
  autocmd FileType dart AutoFormatBuffer dartfmt
  autocmd FileType go AutoFormatBuffer gofmt
  autocmd FileType gn AutoFormatBuffer gn
  autocmd FileType html,css,sass,scss,less,json AutoFormatBuffer js-beautify
  autocmd FileType java AutoFormatBuffer google-java-format
  autocmd FileType python AutoFormatBuffer yapf
  " Alternative: autocmd FileType python AutoFormatBuffer autopep8
  autocmd FileType rust AutoFormatBuffer rustfmt
  autocmd FileType vue AutoFormatBuffer prettier
augroup END