""" GENERIC CONFIG

set autoindent " auto indentation
set expandtab " replace tabs with spaces
set colorcolumn=80 " show ruler at specific column
set cursorline " highlight current line
set noswapfile  
set number " show line numbers
set showcmd " show command in bottom bar
set softtabstop=4 " number of spaces in tab when editing
set tabstop=4 " number of visual spaces per TAB

""" PLUGIN CONFIG

"" CoC
" TextEdit might fail if hidden is not set.
set hidden
" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup
" Give more space for displaying messages.
set cmdheight=3

""" Custom mappings
let mapleader=" "
nmap <leader>g :Goyo<CR>
nmap <leader>l :Limelight!!<CR>
xmap <leader>l :Limelight!!<CR>
nmap <leader>mk :MarkdownPreview<CR>
nmap <leader>q :NERDTreeToggle<CR>
" map ++ to call NERD Commenter in normal mode and visual mode
nmap ++ <plug>NERDCommenterToggle
xmap ++ <plug>NERDCommenterToggle
