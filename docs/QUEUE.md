# Queue

Ordered list of work ready to start. The Orchestrator promotes from here; humans reorder.

| # | Item | Depends on | Data class |
|---|---|---|---|
| 1 | Apply repository settings from ADR 0001 (human) | this PR | Public |
| 2 | Write agent role prompts in `agents/` | this PR | Public |
| 3 | Data classification policy and AI use policy in `policy/` | this PR | Public |
| 4 | Confidentiality agreement template for prospects | 3 | Public |
| 5 | Client-space template and `scripts/new-client` | 2, 3 | Public |
| 6 | Radar: first sources list and weekly job | 2 | Public |
