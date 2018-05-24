#!/bin/bash

# outputs all local branches except the current one
function get_local_branches() {
    local current_branch="$(git branch --no-color | grep -E '^\*' | cut -d' ' -f2)"
    git for-each-ref refs/heads | cut -d/ -f3 | grep -v "${current_branch}"
}

get_local_branches | while read -r branch; do
    echo "Latest commit on branch '${branch}' is:"
    git log --oneline --decorate --stat -1 "${branch}"

    echo
    read -rp "Delete branch '${branch}' (y/n)? " ans < /dev/tty
    case "${ans}" in
        y|Y )
            echo "Deleting..."
            git branch -D "${branch}" ;;
        * )
            ;;
    esac
    echo
done

echo Done
