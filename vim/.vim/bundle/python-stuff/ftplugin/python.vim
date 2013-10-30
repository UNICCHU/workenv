function! Addpyheader()
    if getfsize(@%) <= 0
        execute "norm i#!/usr/bin/env python\n# -*- coding: utf-8 -*-\n"
        execute "norm i\n"
        execute "norm idef main():\n    pass\n\n"
        execute "norm iif __name__ == '__main__':\nmain()"
    endif
endfunction

call Addpyheader()
