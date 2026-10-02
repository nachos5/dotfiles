#!/usr/bin/env bash

# Force-remove local worktrees and branches whose tip commit is older than N days.
# 0 ignores age. Dirty/untracked files and unmerged commits can be lost.
# Keep the main/current worktrees and branches checked out in retained worktrees.
# Only local refs/heads are deleted; no remote operations are performed.
main() {
    if [[ $# -ne 1 || ! $1 =~ ^[0-9]+$ ]]; then
        echo "Usage: git_cleanup_local <days> (non-negative integer; 0 means all ages)" >&2
        return 2
    fi

    local cutoff current_worktree main_worktree entry worktree head branch timestamp branches
    local ignore_age=0 remove_worktree status=0
    local -a worktree_records
    local -A kept_branches=()
    [[ $1 =~ ^0+$ ]] && ignore_age=1
    cutoff=$(date -u -d "$1 days ago" +%s) || return 2
    current_worktree=$(git rev-parse --show-toplevel) || return 1
    mapfile -d '' -t worktree_records < <(git worktree list --porcelain -z)
    [[ ${#worktree_records[@]} -gt 0 ]] || return 1
    main_worktree=${worktree_records[0]#worktree }

    for entry in "${worktree_records[@]}"; do
        case "$entry" in
        'worktree '*)
            worktree=${entry#worktree }
            head=
            branch=
            ;;
        'HEAD '*) head=${entry#HEAD } ;;
        'branch '*) branch=${entry#branch } ;;
        '')
            remove_worktree=1
            if [[ $worktree == "$main_worktree" || $worktree == "$current_worktree" ]]; then
                remove_worktree=0
            elif ((!ignore_age)); then
                if ! timestamp=$(git show -s --format=%ct "$head" --) || [[ ! $timestamp =~ ^-?[0-9]+$ ]]; then
                    printf 'Skipping worktree with unknown commit age: %s\n' "$worktree" >&2
                    remove_worktree=0
                    status=1
                elif ((timestamp >= cutoff)); then
                    remove_worktree=0
                fi
            fi

            if ((remove_worktree)); then
                # A second --force also permits removing locked worktrees.
                if git worktree remove --force --force -- "$worktree"; then
                    printf 'Removed worktree: %s\n' "$worktree"
                else
                    remove_worktree=0
                    status=1
                fi
            fi
            if ((!remove_worktree)) && [[ -n $branch ]]; then
                kept_branches["$branch"]=1
            fi
            ;;
        esac
    done

    branches=$(git for-each-ref --format='%(refname) %(committerdate:unix)' refs/heads/) || return 1
    while read -r branch timestamp; do
        [[ -n $branch ]] || continue
        [[ ${kept_branches["$branch"]:-0} == 1 ]] && continue
        if ((!ignore_age)); then
            if [[ ! $timestamp =~ ^-?[0-9]+$ ]]; then
                printf 'Skipping branch with unknown commit age: %s\n' "$branch" >&2
                status=1
                continue
            fi
            ((timestamp < cutoff)) || continue
        fi
        git branch -D -- "${branch#refs/heads/}" || status=1
    done <<< "$branches"

    return "$status"
}

main "$@"
