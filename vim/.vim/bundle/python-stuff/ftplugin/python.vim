function! Addpyheader()
    if getfsize(@%) <= 0
        execute "norm i# -*- coding: utf-8 -*-\r"
        execute "norm i\r"
        execute "norm idef main():\r    pass\r\r"
        execute "norm iif __name__ == '__main__':\r    main()"
    endif
endfunction

call Addpyheader()
