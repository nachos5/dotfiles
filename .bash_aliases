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
alias increase_file_limit="ulimit -n 4096"

# docker
alias dockerstop='docker stop $(docker ps -a -q)'
alias dockerrm='docker rm $(docker ps -a -q)'
alias dockerprune='docker container prune -f && docker image prune -f && docker system prune -f'
alias composeup='docker-compose -f compose-local.yml up --build'
alias composedown='docker-compose -f compose-local.yml down'

# python/django
alias python='python3'
export VENV_PATH=env
alias envpy='source ./${VENV_PATH}/bin/activate'
alias envpy_no_error='source ./${VENV_PATH}/bin/activate 2>/dev/null || true'
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
alias remove_nvim_swaps='rm -rf ~/.local/share/nvim/swap/*.swp && rm -rf ~/.local/state/nvim/swap/*.swp'
alias null_ls_log='tail -n 200 -f ~/.cache/nvim/null-ls.log'
alias null_ls_log_clear='> ~/.cache/nvim/null-ls.log'
alias lsp_log='tail -n 200 -f ~/.cache/nvim/lsp.log'
alias lsp_log_clear='> ~/.cache/nvim/lsp.log'

# yarn
alias yi='yarn install'
alias yb='yarn build'
alias yd='yarn dev'
alias ys='yarn start'
alias yg='yarn generate'

# xrandr
alias xrandr_reset='xrandr -s 0'

# fzf
alias fzfkeys="cat ~/github/sources/fzf/shell/key-bindings.bash"

# flameshot
alias flame="flameshot gui --clipboard --pin --path ~/Pictures"

# paste rs
function paste() {
  local file=${1:-/dev/stdin}
  curl --data-binary @${file} https://paste.rs
}

# terraform
alias tf="terraform"
