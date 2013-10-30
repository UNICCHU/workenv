function! Addpyheader()
    if getfsize(@%) <= 0
        execute "norm i# -*- coding: utf-8 -*-\n"
        execute "norm i\n"
        execute "norm idef main():\n    pass\n\n"
        execute "norm iif __name__ == '__main__':\n    main()"
    endif
endfunction

call Addpyheader()
