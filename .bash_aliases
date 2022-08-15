# general
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ducks="sudo du -hsx * | sort -rh | head -20"
alias echopath="echo $PATH | tr : '\n'"
portarg () {
    sudo lsof -i:"$@"; sudo lsof -tnP -i:"$@" | xargs -n 1 ps -p
}

# system
alias systemgraphics='inxi -G'

# python/django
alias python='python3'
alias envpy='source ./env/bin/activate'
djangodocker () {
 docker-compose -f compose-local.yml run --rm django "$@"
}

# docker
alias dockerstop='docker stop $(docker ps -a -q)'
alias dockerrm='docker rm $(docker ps -a -q)'
alias dockerprune='docker container prune -f && docker image prune -f && docker system prune -f'
alias composeup='docker-compose -f compose-local.yml up --build'
alias composedown='docker-compose -f compose-local.yml down'

# tmux
alias tmuxsource='tmux source-file ~/.tmux.conf'

# nvim
alias remove_nvim_swaps='rm -rf ~/.local/share/nvim/swap/*.swp'
alias null_ls_log_clear='> ~/.cache/nvim/null-ls.log'
alias null_ls_log='tail -n 200 -f ~/.cache/nvim/null-ls.log'
alias lsp_log='tail -n 200 -f ~/.cache/nvim/lsp.log'
