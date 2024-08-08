# general
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias c="clear"
alias ducks="sudo du -hsx * | sort -rh | head -20"
alias echopath='echo $PATH | tr : "\n"'
portarg() {
	sudo lsof -i:"$1"
	sudo lsof -tnP -i:"$1" | xargs -n 1 ps -p
}
alias bash_source='source ~/.bashrc'
alias alias_source='source ~/.bash_aliases'
alias file_count_in_dir='ls -al | wc -l'
alias source_env_session='source .env_session 2>/dev/null || true'
alias open_in_gui='xdg-open .'
alias view_trash='ls -alh $HOME/.local/share/Trash/files $HOME/.local/share/Trash/info'

# apt
alias aptup='sudo apt update && sudo apt upgrade'
alias aptlist='apt list --installed'

# system
alias os_info_all='lsb_release -a'
alias os_info_version_codename='lsb_release -cs'
ubuntu_codename() {
	grep "UBUNTU_CODENAME" /etc/os-release | cut -d "=" -f2
}
alias systemgraphics='inxi -G'
alias increase_file_limit='ulimit -n 4096'
alias cpu_power_management='cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor'

# git
alias git_unpushed='git log --oneline origin/main..main'

# docker
alias dockerstop='docker stop $(docker ps -a -q)'
alias dockerrm='docker rm $(docker ps -a -q)'
alias dockerprune='docker container prune -f && docker image prune -f && docker system prune -f'
alias composeup='docker compose -f compose-local.yml up --build'
alias composedown='docker compose -f compose-local.yml down'

# python
function python() {
	if [[ -z "${VIRTUAL_ENV}" ]]; then
		python3.11 "$@"
	else
		"${VIRTUAL_ENV}/bin/python" "$@"
	fi
}

function pip() {
	if [[ -z "${VIRTUAL_ENV}" ]]; then
		pip3.11 "$@"
	else
		"${VIRTUAL_ENV}/bin/pip" "$@"
	fi
}

if [ -z "${VENV_PATH}" ]; then
	export VENV_PATH=.venv
fi

alias envpy='source ./${VENV_PATH}/bin/activate'
alias envpy_no_error='source ./${VENV_PATH}/bin/activate 2>/dev/null || true'
djangodocker() {
	docker compose -f compose-local.yml run --rm django "$@"
}
alias dshell='djangodocker python manage.py shell_plus'
alias dmigrations='djangodocker python manage.py makemigrations'
alias dmigrate='djangodocker python manage.py migrate'
alias py_cache_clear='sudo find . -type d -name "__pycache__" -exec rm -rf {} +'
alias mypy_cache_clear='sudo find . -type d -name ".mypy_cache" -exec rm -rf {} +'
alias ruff_cache_clear='sudo find . -type d -name ".ruff_cache" -exec rm -rf {} +'
alias pytest_cache_clear='sudo find . -type d -name ".pytest_cache" -exec rm -rf {} +'
alias pyglobal='source ~/pyglobal/.venv/bin/activate'
alias pypathpwd='export PYTHONPATH=$(pwd)'

# tmux
alias tmuxsource='tmux source-file ~/.tmux.conf'
alias ta='tmux a'
alias tl='tmux list-session'
alias tk='tmux kill-session'
alias tks='tmux kill-server'

# xplr
alias xcd='cd "$(xplr --print-pwd-as-result)"'

# nvim
alias n='source_env_session && envpy_no_error && nvim'
alias list_nvim_swaps='ls -al ~/.local/state/nvim/swap/*.swp'
alias remove_nvim_swaps='rm -rf ~/.local/share/nvim/swap/*.swp && rm -rf ~/.local/state/nvim/swap/*.swp'
alias null_ls_log='tail -n 200 -f ~/.cache/nvim/null-ls.log'
alias null_ls_log_clear='> ~/.cache/nvim/null-ls.log'
alias lsp_log='tail -n 200 -f ~/.local/state/nvim/lsp.log'
alias lsp_log_clear='> ~/.local/state/nvim/lsp.log'
alias db_conns='cat $HOME/.config/nvim/db_ui/connections.json | jq'
alias nvim_plugins='cd ~/.local/share/nvim'

# yarn
alias yi='yarn install'
alias yb='yarn build'
alias yd='yarn dev'
alias ys='yarn start'
alias yg='yarn generate'

# xrandr
alias xrandr_reset='xrandr -s 0'

# fzf
alias fzfkeys='cat ~/github/sources/fzf/shell/key-bindings.bash'

# flameshot
alias flame='flameshot gui --clipboard --pin --path ~/Pictures'

# paste rs
function pasters() {
	local file=${1:-/dev/stdin}
	curl --data-binary @"${file}" https://paste.rs
}

# terraform
alias tf='terraform'

# utils
alias csvtojson="python -c 'import csv, json, sys; print(json.dumps([dict(r) for r in csv.DictReader(sys.stdin)]))'"

# lazy
alias lzg="lazygit"
alias lzd="lazydocker"

# linux audio
alias qpwgraph='~/utils/scripts/qpwgraph.sh'

# network
alias my_public_ip_info='curl -s https://www.ipinfo.io | jq'
alias ip_leak='curl -s https://ipleak.net/json/ | jq'
function urlencode() {
	local param="$1"
	param=$(echo "$param" | jq -s -R -r @uri)
	echo "$param"
}
function dns_records() {
	domain=$1
	for type in A AAAA CNAME MX NS SOA TXT; do
		echo "Querying for $type:"
		dig +short "$domain" $type
		echo ""
	done
}
