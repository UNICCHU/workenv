" ****************************************
" *       Enhanced - VIM                 *
" *       Author : Unic Chu              *
" *       Version: 1.0.1020              *
" *        GVIM  : 7.3.46                * 
" *        Date  : 2011/10/20            *
" ****************************************
"
"  **** key Mappings **** 
" F2     : vifm
" F3     : TagbarToggle
" F4     : TlistToggle
" F5     : NERDTreeToggle
" F7     :
" F12    : Create Tags
"
" csa    : add cscope.out to database
" <c-F12>           : Create cscope.out files.
" <c-x> <x-o>       : omni complete function
" tab               : complete function
" <c-s>             : save files
" <c-leasder>, s/d  : cscope find symbol/defination
" <c-n>, <c-p>      : quickfix window up/down
" <c-j>, <c-k>      : Tab left/Righ
" <c-leasder>, vv   : Easygrep for string in QuickFix
"

" *---- plugin: Pathegon ----* "
filetype off
call pathogen#runtime_append_all_bundles() 
filetype plugin indent on
" *----* "

" *---- plugin: NERD Tree ----* "
let NERDTreeChDirMode=1
let NERDTreeMouseMode=2
let NERDTreeQuitOnOpen=1
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
" *----* "

" *---- keyboard ----* "
set nocompatible
set bs=2
" BUGBUG: supertab can't work "set paste
set nobackup
syntax on
" *----* "

" *---- key Tabs defination ----* "
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
" *----* "

" *---- Key Mapping ----* "
nnoremap <silent> <F5> :NERDTreeToggle<CR>
nnoremap <silent> <F4> :TlistToggle<CR>
nnoremap <silent> <F3> :TagbarToggle<CR>
nnoremap <silent> <F2> :EditVifm<CR>
" Tab Usage
map <C-j> :tabnext<CR>
map <C-k> :tabprev<CR>
" Create cscope and tags
map <F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
map <C-F12> :!cscope -Rb <CR> :csadd <CR> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
" Save Usage
map <C-S> :w <CR>
imap <C-S> <ESC> :w <CR>
" QuickFix Windows
map <c-n> :cn<CR>   
map <c-p> :cp<CR>    
" *----* "

" *---- Interface ----* "
"set guifont=Monospace
set number
" *----* "

" *---- Enhanced Python Syntax ----*
let python_highlight_all = 1
" *----* "
set term=xterm

" *---- pydiction----*
let g:pydiction_location = '.vim/bundle/pydiction/complete-dict'


" *---- gundam pop menu color----*
highlight clear Normal
highlight   Pmenu         ctermfg=8 ctermbg=4
highlight   PmenuSel      ctermfg=0 ctermbg=6
highlight   PmenuSbar     ctermfg=0 ctermbg=7
highlight   PmenuThumb    ctermfg=8 ctermbg=7
" *----*

" *---- EasyMotion ----*
let g:EasyMotion_leader_key = '`'
" *----*
