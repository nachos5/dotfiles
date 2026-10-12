#!/usr/bin/env bash

# Pick a git worktree with fzf and open it in its own tmux window running nvim.
# Typing a name that matches no worktree creates <main worktree>/.worktrees/<name>
# on branch <name> (an existing local or remote branch is reused).
# Opening a worktree other than the main one copies missing ignored files into it.
# A worktree that already has a window in the current session gets that window selected.

# Copy ignored files (env files, local configs) from the main worktree into another worktree.
# With a .worktreeinclude file (gitignore syntax, also read by Claude Code), copy the ignored files that match it.
# Without one, copy ignored files up to 1 MiB that are not inside an ignored directory (skips venvs, node_modules).
# Files that already exist in the target are kept.
copy_ignored_files() {
    local source=$1 target=$2 i
    local path
    local -a paths=()

    if [[ -f $source/.worktreeinclude ]]; then
        mapfile -d '' -t paths < <(
            git -C "$source" ls-files -z --others --ignored --exclude-from="$source/.worktreeinclude" |
                git -C "$source" check-ignore -z --stdin
        )
    else
        while IFS= read -r -d '' path; do
            [[ $path == */ ]] && continue
            (($(stat -c %s -- "$source/$path") <= 1048576)) && paths+=("$path")
        done < <(git -C "$source" ls-files -z --others --ignored --exclude-standard --directory)
    fi
    # Skip files inside nested worktrees (ours and Claude Code's) and files the target already has.
    for i in "${!paths[@]}"; do
        path=${paths[i]}
        if [[ $path == .worktrees/* || $path == .claude/worktrees/* || -e $target/$path || -L $target/$path ]]; then
            unset 'paths[i]'
        fi
    done
    ((${#paths[@]})) || return 0
    (cd "$source" && cp -a --parents -t "$target" -- "${paths[@]}") || return 1
    printf 'Copied %d ignored files into the worktree:\n' "${#paths[@]}"
    printf '  %s\n' "${paths[@]}"
}

# Allow the worktree's .envrc for direnv, but only when it is identical to the main worktree's
# .envrc and that one is already allowed, so a changed .envrc on a branch is never trusted silently.
allow_direnv() {
    local source=$1 target=$2

    command -v direnv > /dev/null || return 0
    [[ -f $target/.envrc ]] && cmp -s "$source/.envrc" "$target/.envrc" || return 0
    # Status 0 means allowed.
    (cd "$source" && direnv status) | grep -qx 'Found RC allowed 0' || return 0
    direnv allow "$target"
}

main() {
    local main_worktree common_dir output query selection worktree name window

    if [[ -z $TMUX ]]; then
        echo "Not inside tmux." >&2
        return 1
    fi
    main_worktree=$(git worktree list --porcelain | sed -n '1s/^worktree //p')
    if [[ -z $main_worktree ]]; then
        echo "Not inside a git repository." >&2
        return 1
    fi

    # One "<branch>\t<path>" line per worktree.
    output=$(
        git worktree list --porcelain | awk '
            /^worktree / { path = substr($0, 10); branch = "(detached)" }
            /^branch / { branch = substr($0, 19) }
            /^$/ { printf "%s\t%s\n", branch, path }
        ' | fzf --print-query --delimiter '\t' --prompt 'worktree> ' \
            --header 'Enter: open selected worktree, or create one named after the query'
    )
    # 130: fzf was cancelled.
    [[ $? -eq 130 ]] && return 0
    query=$(sed -n 1p <<< "$output")
    selection=$(sed -n 2p <<< "$output")

    if [[ -n $selection ]]; then
        worktree=$(cut -f 2 <<< "$selection")
    elif [[ -n $query ]]; then
        name=$query
        worktree="$main_worktree/.worktrees/${name//\//-}"
        # Keep .worktrees/ out of git status without touching the repo's .gitignore.
        if ! git -C "$main_worktree" check-ignore -q .worktrees/; then
            common_dir=$(git rev-parse --path-format=absolute --git-common-dir) || return 1
            mkdir -p "$common_dir/info"
            echo ".worktrees/" >> "$common_dir/info/exclude"
        fi
        if git show-ref --quiet --verify "refs/heads/$name" || [[ -n $(git for-each-ref "refs/remotes/*/$name") ]]; then
            git worktree add "$worktree" "$name" || return 1
        else
            git worktree add -b "$name" "$worktree" || return 1
        fi
    else
        return 0
    fi
    if [[ $worktree != "$main_worktree" ]]; then
        copy_ignored_files "$main_worktree" "$worktree" || return 1
        allow_direnv "$main_worktree" "$worktree"
    fi

    # Name windows after the branch; a detached HEAD falls back to the directory name.
    name=$(git -C "$worktree" branch --show-current)
    [[ -n $name ]] || name=$(basename "$worktree")

    # Windows are tagged with the @worktree option so they can be found again.
    window=$(
        tmux list-windows -F "#{window_id}	#{@worktree}" |
            awk -F '\t' -v path="$worktree" '$2 == path { print $1; exit }'
    )
    if [[ -n $window ]]; then
        # Rename too, the worktree may have switched branch since the window was made.
        tmux rename-window -t "$window" "$name"
        tmux select-window -t "$window"
        return 0
    fi
    window=$(tmux new-window -P -F '#{window_id}' -c "$worktree" -n "$name") || return 1
    tmux set-option -w -t "$window" @worktree "$worktree"
    # Start nvim from a shell so the window stays open after quitting nvim.
    tmux send-keys -t "$window" nvim Enter
}

main "$@"
