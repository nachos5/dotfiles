# general
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias c="clear"
alias ducks="sudo du -hsx * | sort -rh | head -20"
alias echopath="echo $PATH | tr : '\n'"
portarg () {
    sudo lsof -i:"$@"; sudo lsof -tnP -i:"$@" | xargs -n 1 ps -p
}

# apt
alias aptup='sudo apt update && sudo apt upgrade'
alias aptlist="apt list --installed"

# system
alias systemgraphics='inxi -G'

# docker
alias dockerstop='docker stop $(docker ps -a -q)'
alias dockerrm='docker rm $(docker ps -a -q)'
alias dockerprune='docker container prune -f && docker image prune -f && docker system prune -f'
alias composeup='docker-compose -f compose-local.yml up --build'
alias composedown='docker-compose -f compose-local.yml down'

# python/django
alias python='python3'
alias envpy='source ./env/bin/activate'
alias envpy_no_error='source ./env/bin/activate 2>/dev/null || true'
djangodocker () {
 docker-compose -f compose-local.yml run --rm django "$@"
}
alias dshell="djangodocker python manage.py shell_plus"
alias dmigrations="djangodocker python manage.py makemigrations"
alias dmigrate="djangodocker python manage.py migrate"

# tmux
alias tmuxsource='tmux source-file ~/.tmux.conf'
alias ta='tmux a'
alias tk='tmux kill-session'
alias tks='tmux kill-server'

# xplr
alias xcd='cd "$(xplr --print-pwd-as-result)"'

# nvim
alias n="envpy_no_error && nvim"
alias remove_nvim_swaps='rm -rf ~/.local/share/nvim/swap/*.swp'
alias null_ls_log='tail -n 200 -f ~/.cache/nvim/null-ls.log'
alias null_ls_log_clear='> ~/.cache/nvim/null-ls.log'
alias lsp_log='tail -n 200 -f ~/.cache/nvim/lsp.log'
alias lsp_log_clear='> ~/.cache/nvim/lsp.log'

# yarn
alias yi='yarn install'
alias yb='yarn build'
alias yd='yarn dev'
alias ys='yarn start'

# xrandr
alias xrandr_hdmi1='xrandr --auto --output HDMI-1 --mode 1920x1080'
