" update.vim
" Author: Isaac Morneau
" Version: 1.0
" defaults:
" g:ss_auto_enter 1
" g:ss_auto_exit 0
" g:ss_auto_alias 1
" g:ss_dir = has(nvim) ? stdpath('data') . '/session/' : '~/.vim/session'
" g:ss_file = substitute(getcwd(), '/', '_', 'g')

if exists('g:loaded_simple_sessions')
    finish
endif
let g:loaded_simple_sessions= 1

if !exists('g:ss_file')
    let g:ss_file = substitute(getcwd(), "/", "_", "g")
endif
if !exists('g:ss_dir')
    let g:ss_dir = has('nvim') ? stdpath('data') . '/session/' : '~/.vim/session/'
endif
if !exists('g:ss_auto_alias')
    let g:ss_auto_alias = 1
endif
if !exists('g:ss_auto_enter')
    let g:ss_auto_enter = 1
endif
if !exists('g:ss_auto_exit')
    let g:ss_auto_exit = 0
endif

if exists("*mkdir")
    if !isdirectory(g:ss_dir)
        call mkdir(g:ss_dir)
    endif
endif
if !isdirectory(g:ss_dir)
    echo "Failed to create directory " . g:ss_dir
endif

"make or update a session for this directory
function! SS_mk()
    let l:path = substitute(g:ss_dir. g:ss_file, " ", "\\\\ ", "g")
    if !empty(glob(l:path, 1))
        echo "Updating existing session"
    else
        echo "Creating new session for " . g:ss_file
    endif
    exec "mksession! " . l:path
endfunction

"only update a session if it exists
function! SS_ss()
    let l:path = substitute(g:ss_dir. g:ss_file, " ", "\\\\ ", "g")
    if !empty(glob(l:path, 1))
        echo "Updating existing session"
        exec "mksession! " . l:path
    endif
endfunction

"load the session for the starting direcory if it exists
function! SS_ld()
    let l:path = substitute(g:ss_dir . g:ss_file, " ", "\\\\ ", "g")
    if !empty(glob(l:path, 1))
        exec "source " . l:path
    endif
endfunction

"remove the session for the starting directory if it exists
function! SS_rm()
    let l:path = substitute(g:ss_dir . g:ss_file, " ", "\\\\ ", "g")
    if !empty(glob(l:path, 1))
        if delete(g:ss_dir . g:ss_file) == -1
            echo "Failed to delete " . l:path
        else
            echo "Deleting session for " . g:ss_file
        endif
    else
        echo "No existing session for " . g:ss_file
    endif
endfunction

"dont know why you wouldnt want this but hey thats up to you
if g:ss_auto_alias
    command! Srm call SS_rm()
    command! Sld call SS_ld()
    command! Smk call SS_mk()
    command! Sss call SS_ss()
endif

"auto load the session for the directory if it exists
if g:ss_auto_enter
    autocmd VimEnter * nested call SS_ld()
endif

if g:ss_auto_exit
    autocmd ExitPre * nested call SS_mk()
endif
