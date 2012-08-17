" ****************************************
" *  Gvim portable Installation batch    *
" *                                      *
" *       Author : Unic Chu              *
" *       Version: 1.0.1020              *
" *        GVIM  : 7.3.46                * 
" *        Date  : 2011/10/20            *
" ****************************************
"
"  **** key Mappings **** 
" F1     :Taglist+NERD Tree
" F3     :BufExplorer
" F4     :TlistToggle
" F5     :NERDTreeToggle
" F7     :miniBufExplorer
" F12    :Create Tags
"
" wm/wmc :Open/Close WinManger(Taglist+NERDTree)
" csa    : add cscope.out to database
" <Alt-left, right> : Tab left/Right
" <c-F12>           : Create cscope.out files.
" <c-x> <x-o>       : omni complete function
" tab               : complete function
" <c-s>             : save files
" <c-leasder>, s/d  : cscope find symbol/defination
" <c-n>, <c-p>      : quickfix window up/down
" <c-leasder>, vv   : Easygrep for string in QuickFix
"

" *---- plugin: Pathegon ----* "
filetype off
call pathogen#runtime_append_all_bundles() 
filetype plugin indent on
" *----* "

" *---- plugin: NERD Tree ----* "
let NERDTreeChDirMode=2 
let NERDTreeMouseMode=2
let NERDTreeWinPos="right"
" *----* "
  
" *---- plugin: Cscope ----* "
set cscopequickfix=c-,d-,e-,f-,g-,i-,s-,t-  "  usequickfix
set cscopetagorder=1   " Search ctags first
abbr csadd cs add cscope.out
" *----* "

" *---- plugin: TagList ----* "
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
" *----* "

" *---- plugin: Win Manager with NERD Tree ----* "
let g:NERDTree_title='[NERD Tree]'
let g:winManagerWindowLayout='NERDTree|TagList'

function! NERDTree_Start()
    exec 'NERDTree'
endfunction

function! NERDTree_IsValid()
    return 1
endfunction

nmap wm :WManager<cr>:q<cr>
nmap wmc :WMClose<cr>
nmap <F1> :WManager<cr>:q<cr>
" *----* "

" *---- plugin: snipMate ----* "
filetype plugin on
" *----* "

" *---- keyboard ----* "
set nocompatible
set bs=2
" BUGBUG: supertab can't work "set paste
set nobackup
" *----* "

" *---- key Tabs defination ----* "
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
" *----* "

" *---- Key Mapping ----* "
nnoremap <silent> <F5> :NERDTreeToggle<CR>
nnoremap <silent> <F4> :TlistToggle<CR>
nnoremap <silent> <F3> :BufExplorer<CR>
" Tab Usage
map <M-Right> :tabnext<CR>
map <M-Left> :tabprev<CR>
" Create cscope and tags
map <F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
map <C-F12> :!cscope -Rb <CR> :csadd <CR>
" Save Usage
map <C-S> :w <CR>
imap <C-S> <ESC> :w <CR>
" QuickFix Windows
map <c-n> :cn<CR>   
map <c-p> :cp<CR>    
" *----* "

" *---- Interface ----* "
colorscheme darkblue
set guifont=Monospace
set number
" *----* "

" *---- FufFinder -----* "
map fff :FufFile <CR>
map ffd :FufDir <CR>
map fft :FufTag <CR>
" *----* "

" *---- MiniBufExplorer -----* "
map <F7> <ESC>:TMiniBufExplorer<CR>
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1 
" *----* "
