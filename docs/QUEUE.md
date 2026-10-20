# Queue

Ordered list of work ready to start. The Orchestrator promotes from here; humans reorder.

| # | Item | Depends on | Data class |
|---|---|---|---|
| 1 | Apply repository settings from ADR 0001 (human) | this PR | Public |
| 2 | Write agent role prompts in `agents/` | this PR | Public |
| 3 | Fill the approved tools list in `policy/data-classification.md` (human, Class C) | | Public |
| 4 | Lawyer review of `policy/confidentiality-agreement-es.md` (human) | | Public |
| 5 | Client-space template and `scripts/new-client` | 2, 3 | Public |
| 6 | Radar: first sources list and weekly job | 2 | Public |
