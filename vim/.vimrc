" ****************************************
" *       Enhanced - VIM                 *
" *       Author : ackeack               *
" ****************************************
"
"  **** key Mappings **** 
" F2     : vifm
" F3     : NERDTreeToggle
" F4     : TagbarToggle
" F5     : Compile and execute (c, python, sh)
" F11    : tabprev
" F12    : tabnext
"
" csa    : add cscope.out to database
" <c-F12>           : Create cscope.out files.
" <c-j>             : snipMate complete e.g: ifmain<C-j>
" <c-x> <x-o>       : omni complete function
" tab               : complete function
" <c-s>             : save files
" <c-leasder>, s/d  : cscope find symbol/defination
" <leasder>, vv   : Easygrep for string in QuickFix
"

" *---- plugin: Pathegon ----* "
execute pathogen#infect()
filetype plugin indent on
" *----* "

" *---- plugin: NERD Tree ----* "
let NERDTreeChDirMode=2
let NERDTreeMouseMode=2
let NERDTreeHighlightCursorline=1
" let NERDTreeWinPos="right"
" *----* "
  
" *---- plugin: Cscope ----* "
set cscopequickfix=c-,d-,e-,f-,g-,i-,s-,t-  "  usequickfix
set cscopetagorder=1   " Search ctags first
abbr csadd cs add cscope.out
" *----* "

" *---- plugin: TagList ----* "
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
" for mac os and change the ctags to ctag
" let Tlist_Ctags_Cmd="/usr/bin/ctag"
" *----* "

" *---- plugin: snipMate ----* "
filetype plugin on
imap <C-J> <Plug>snipMateNextOrTrigger
smap <C-J> <Plug>snipMateNextOrTrigger
" *----* "

" *---- keyboard ----* "
set nocompatible
set bs=2
set nobackup
" *----* "

" *---- key Tabs defination ----* "
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
" *----* "

" *---- Key Mapping ----* "
nnoremap <silent> <F3> :NERDTreeToggle<CR>
nnoremap <silent> <F4> :TagbarToggle<CR>
nnoremap <silent> <F2> :EditVifm<CR>
" Tab Usage
map <F12> :tabn<CR>
map <F11> :tabp<CR>
" Create cscope and tags
map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
" map <C-F12> :!cscope -Rb <CR> :csadd <CR> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
" Save Usage
map <C-S> :w <CR>
imap <C-S> <ESC> :w <CR>
" Compile 
autocmd BufRead *.py nmap <F5> :w !python %<CR>
autocmd FileType c map <F5> :!gcc --o "%:p:r.out" "%:p" && "%:p:r.out" <CR>
autocmd BufRead *.sh nmap <F5> :w !sh %<CR>
" *----* "

" *---- Enhanced Python Syntax ----*
let python_highlight_all = 1
" *----* "

" *---- pydiction----*
let g:pydiction_location = '.vim/bundle/pydiction/complete-dict'
" *----*

" *---- gundam pop menu color----*
highlight clear Normal
highlight   Pmenu         ctermfg=8 ctermbg=4
highlight   PmenuSel      ctermfg=0 ctermbg=6
highlight   PmenuSbar     ctermfg=0 ctermbg=7
highlight   PmenuThumb    ctermfg=8 ctermbg=7
" *----*

" *---- Plugin:xml  ----* "
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags noci
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags noci
" *----* "

" *---- syntastic ----*"
let g:syntastic_python_checkers=['pyflakes', 'python']
let g:syntastic_check_on_open=1
" *----*"

" *---- VIM Interface ----* "
"set guifont=Monospace
set term=xterm
set number
syntax on
set background=dark
" *----* "

