# vim-simple-sessions
A little plugin to allow easy session management

This was created because in large projects after a computer restart manually opening both files and using session directly is annoying.

# Configuration

The defaults are as follows:

```
g:ss_auto_enter 1
g:ss_auto_exit 0
g:ss_auto_alias 1
g:ss_dir = has(nvim) ? stdpath('data') . '/session/' : '~/.vim/session'
g:ss_file = substitute(getcwd(), '/', '_', 'g')
```

- auto enter will load sessions for that directory automatically if they exist
- auto exit will save sessions for that directory automatically on :q or :qa if they exist
- auto alias will create the commands Srm, Sld, Smk, and Sss for removing, loading, making, and saving sessions
- dir is the folder to store all the sessions in
- file is how to identify this folder as unique compared to other sessions


# TODO

- make a help page because some people like those
