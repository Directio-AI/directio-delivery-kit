#!/usr/bin/env bash
# Fails if any file the agents rely on is missing.
set -euo pipefail
required=(
  AGENTS.md
  CLAUDE.md
  docs/PLAN.md
  docs/QUEUE.md
  docs/BOARD.md
  artifacts/intent/TEMPLATE.md
  artifacts/spec/TEMPLATE.md
  artifacts/plan/TEMPLATE.md
  .github/PULL_REQUEST_TEMPLATE.md
  .github/CODEOWNERS
)
missing=0
for f in "${required[@]}"; do
  if [[ ! -f "$f" ]]; then
    echo "missing: $f"
    missing=1
  fi
done
exit $missing
