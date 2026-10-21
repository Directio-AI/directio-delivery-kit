#!/usr/bin/env bash
# Fails if any file the agents rely on is missing, or if a Spanish document's English twin is missing.
set -euo pipefail
required=(
  scripts/clean-worktrees.sh
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
  policy/data-classification.md
  policy/ai-use-policy.md
  docs/engineering-standard.md
)
missing=0
for f in "${required[@]}"; do
  if [[ ! -f "$f" ]]; then
    echo "missing: $f"
    missing=1
  fi
done
# Stable bilingual documents: every Spanish original needs its .en.md version.
bilingual=(README.md AGENTS.md policy/README.md policy/data-classification.md policy/ai-use-policy.md policy/confidentiality-agreement.md docs/engineering-standard.md)
for f in "${bilingual[@]}"; do
  en="${f%.md}.en.md"
  if [[ -f "$f" && ! -f "$en" ]]; then
    echo "missing English version: $en"
    missing=1
  fi
done
exit $missing
