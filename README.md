# vim-simple-sessions
a little plugin to allow easy session management

this was created because in large projects after a computer restart manually opening both files and using session directly is annoying.

# configuration

the defaults are as follows:

```
g:ss_auto_enter 1
g:ss_auto_exit 0
g:ss_auto_alias 1
g:ss_dir = has(nvim) ? stdpath('data') . '/session/' : '~/.vim/session'
g:ss_file = substitute(getcwd(), '/', '_', 'g')
```

- auto enter will load sessions for that directory automatically if they exist
- auto exit will save sessions for that directory automatically on :q or :qa if they exist
- auto alias will create the commands srm, sld, smk, and sss for removing, loading, making, and saving sessions
- dir is the folder to store all the sessions in
- file is how to identify this folder as unique compared to other sessions

# ease of use

i have the following function in my bashrc to allow me to use [fzf](https://github.com/junegunn/fzf) to fuzzy select existing sessions

```
# select a saved session and open it
function nvimp() {
    vcmd=$(command -v nvim &>/dev/null && echo nvim || echo vim)
    if [ $vcmd == "nvim" ]; then
        vfl="$home/.local/share/nvim/session"
    else
        vfl="$home/.vim/session"
    fi
    file=$(find $vfl -type f | fzf +m -1)
    if [ -n "$file" ]; then
        vcd=$(grep -em 1 'cd ' "$file")
        if [ -n "$vcd" ]; then
            ${vcd//\~/$home}
        fi
        $vcmd
    fi
}
```

# todo

- make a help page because some people like those
