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
" Accept the completion suggestion by pressing Enter
" https://superuser.com/questions/1734914/neovim-coc-nvim-enter-key-doesnt-work-to-autocomplete
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
" TextEdit might fail if hidden is not set.
set hidden
" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup
" Give more space for displaying messages.
set cmdheight=3

"" ctrl.vim
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_show_hidden = 1

"" far.vim
" improve scrolling performance when navigating through large results
set lazyredraw

"" Limelight
let g:limelight_conceal_ctermfg = 'gray'

"" NERD Commenter
let g:NERDCreateDefaultMappings = 1

"" NERDTree
let NERDTreeShowHidden = 1
let g:NERDTreeIgnore = ['^\.git$', '^node_modules$', '^zig-cache$']

"" gruvbox
if (has("termguicolors"))
 set termguicolors
endif
colorscheme gruvbox
set background=dark

"" vim-airline
let g:airline#extensions#tabline#enabled = 1

"" vim-floaterm
let g:floaterm_keymap_new = '<Leader>ft'
let g:floaterm_keymap_toggle = '<Leader>t'

"" vim-highlightyank
let g:highlightedyank_highlight_duration = 1000 " in ms

"" vim-move (C means Ctrl => C-k, C-j, C-h, C-l)
let g:move_key_modifier = 'C' 

"" vim-signify
" default updatetime 4000ms is not good for async update
set updatetime=100

"" zig.vim
let g:zig_fmt_autosave = 1

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
