# ADR 0001: Runtime, tracker and enforcement

- Status: accepted
- Date: 2026-10-18

## Context

Directio wants a delivery system any coding agent can work in, cloud-only for now, with the freedom to change model or tool at any moment. Rules written only in prompts depend on the agent obeying them; rules enforced by git and CI hold whichever agent opened the PR.

## Decision

1. **Tracker:** GitHub Issues, with the work-unit template and the label state machine in `AGENTS.md`.
2. **Instructions:** `AGENTS.md` is canonical. Tool-specific files (`CLAUDE.md` and others) are one-line pointers.
3. **Runtime:** cloud coding agents. We start with Claude and will trial one other agent on a real issue, so the portability claim is tested in practice.
4. **Enforcement in CI:** every PR runs secret scanning (gitleaks), a structure check and a fixture guard. These are the checks branch protection should require.
5. **Review:** `CODEOWNERS` names the humans who approve. Agents never approve. Interim exception (decided by Jaime, 2026-10-20): until the first client engagement is signed, Claude may merge its own PRs when CI is green and no Class C item or client data is involved. The exception ends when the organization moves to Team.
6. **Production:** a GitHub environment named `production` with required reviewers. Agents stop before it.

## Repository settings to apply (by an org owner)

- Branch protection or a ruleset on `main`: require a pull request, one approving review from a code owner, the `ci` checks passing, and no force pushes.
- Disable merge commits; allow squash merge only; delete branches after merge.
- Create labels: `ready`, `building`, `verifying`, `needs-human`, `blocked`, `killed`, `done`, `fixture-change-approved`.

**Plan limitation:** on GitHub's Free plan, branch protection and rulesets are not available for private repositories, and neither are environment required reviewers. The checks above still run, but nothing stops a merge when they fail. Check GitHub's current plan page before deciding, since this changes.

## Decisions for a human

1. GitHub plan: **decided 2026-10-20.** Stay on Free until the first client engagement signs, then move to Team before any client work enters a repo.

## Consequences

- Switching agents means changing a pointer file, not the system.
- Until settings are applied, the gates are advisory only.
