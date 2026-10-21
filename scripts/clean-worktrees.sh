#!/usr/bin/env bash
# Removes git worktrees and local branches whose work is finished: merged into main,
# or whose remote branch was deleted after its PR closed. Lists idle ones it won't touch.
# Dry run by default; pass --apply to remove. Never touches main, the current branch,
# or a worktree with uncommitted changes.
set -euo pipefail
apply=0
[[ "${1:-}" == "--apply" ]] && apply=1
idle_days="${IDLE_DAYS:-7}"

run() { if (( apply )); then "$@"; else echo "would run: $*"; fi; }

git fetch --prune --quiet origin || echo "warning: fetch failed; using local refs"
run git worktree prune

main_wt=$(git rev-parse --path-format=absolute --git-common-dir | xargs dirname)
current=$(git branch --show-current)
now=$(date +%s)

# Finished = its remote branch was deleted (PR merged or closed), or it was pushed and is
# already in main. A branch never pushed doesn't count: it may be work that just started.
finished() {
  local b="$1"
  [[ "$(git for-each-ref --format='%(upstream:track)' "refs/heads/$b")" == "[gone]" ]] && return 0
  [[ -n "$(git for-each-ref --format='%(upstream)' "refs/heads/$b")" ]] &&
    git merge-base --is-ancestor "$b" origin/main 2>/dev/null
}

# Worktrees other than the main checkout.
git worktree list --porcelain | awk '/^worktree /{p=substr($0,10)} /^branch /{print p "\t" substr($2,12)}' |
while IFS=$'\t' read -r path branch; do
  [[ "$path" == "$main_wt" ]] && continue
  if [[ -n "$(git -C "$path" status --porcelain 2>/dev/null)" ]]; then
    echo "skip (uncommitted changes): $path [$branch]"
  elif finished "$branch"; then
    echo "remove worktree: $path [$branch]"
    run git worktree remove "$path"
  else
    age=$(( (now - $(git log -1 --format=%ct "$branch")) / 86400 ))
    (( age >= idle_days )) && echo "idle ${age}d, review by hand: $path [$branch]"
  fi
done

# Local branches, once no worktree holds them.
git for-each-ref --format='%(refname:short)' refs/heads |
while read -r b; do
  [[ "$b" == "main" || "$b" == "$current" ]] && continue
  git worktree list --porcelain | grep -qx "branch refs/heads/$b" && continue
  if finished "$b"; then
    echo "delete branch: $b"
    run git branch -D "$b"
  fi
done
