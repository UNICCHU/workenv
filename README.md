workenv
=======

ackeack's work environment
- vim: with several plugins and key binding.
- env: Which contains zsh, screen.
- devel: install devel packages, and pyenv.

How to install:
------
$ sh update_module.sh
$ source install.sh (or $install_vim/env/devel.sh)

vim
-----
Keybinding: 
* F2     : vifm
* F3     : NERDTreeToggle
* F4     : TagbarToggle
* F5     : Compile and execute (c, python, sh)
* F11    : tabprev
* F12    : tabnext
* csa    : add cscope.out to database
* <C-F12>           : Create cscope.out files.
* <C-j>             : snipMate complete e.g: ifmain<C-j>
* <C-x> <x-o>       : omni complete function
* tab               : complete function
* <C-s>             : save files
* <C-leasder>, s/d  : cscope find symbol/defination
* <leasder>, vv   : Easygrep for string in QuickFix

env
-----
* zsh
* screen

devel
-----
* devel packages
* pyenv
