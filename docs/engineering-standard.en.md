# Engineering standard (English version)

_English version of [engineering-standard.md](engineering-standard.md). The Spanish original prevails if they differ._

_Last updated: 2026-10-21_

How Directio writes software, with or without coding agents, and how we build the AI systems we deliver to clients. It applies to this repository and to every client repository created from the kit.

It is sized for a two-person team that works with agents. Every practice has to earn its place: if it costs more than it prevents, it stays out. The "What we are not adopting yet" section is as much a part of the standard as the rest.

## 1. Principles

1. **Simple first.** A script before a service, a fixed workflow before an autonomous agent, one model before several. Move up a level only when measurement shows the simple option is not enough. (See Anthropic's "Building effective agents".)
2. **Rules that matter live in CI, not in prompts.** A prompt is a request; a CI check holds for any agent or person. If a rule is broken twice, it becomes a check.
3. **Evidence over opinion.** Nothing is done until a test, an eval or a command proves it, and the result is in the PR.
4. **Readable over clever.** The code will be read by another agent, another person or the client's team. Optimize for whoever reads it next.
5. **The client must be able to maintain it.** If only Directio understands what we built, the client bought a dependency, not a solution. We choose boring, documented technology, and the handoff to the client's team is a deliverable.

## 2. Clean code

The essentials, in any language:

- **Names that say what something is and what it is for.** `overdue_orders`, not `data2`. Use the client's domain names where they exist.
- **Short functions with a single responsibility.** If you need "and" to describe it, it is probably two.
- **No premature abstractions.** Duplicating twice is fine; extract on the third time (rule of three). No interfaces or layers "just in case".
- **Explicit errors.** Never an `except: pass` or an empty `catch {}`. An error is handled, logged with context or allowed to propagate. Fail early with a clear message.
- **Comments explain why, not what.** The code says what. No commented-out or dead code: git already keeps the history.
- **Configuration outside the code.** Paths, URLs, thresholds and model names go in configuration or environment variables; secrets go only in the secrets manager.
- **Types.** Python with type hints checked by a type checker; TypeScript with `strict`.
- **Few dependencies, pinned versions.** Every new dependency is justified in the PR. Lockfile always committed.
- **Automatic formatting and linting, in CI.** Nobody argues about style in a review. Defaults: Python with `ruff` (format and lint) and `mypy` or `pyright`; TypeScript with Biome, or Prettier plus ESLint. They are added to CI in the first PR that introduces code in that language.

## 3. Tests

- **Deterministic code gets deterministic tests.** Parsers, business rules, data transformations and validations get normal unit tests: fast and offline.
- **A fix starts with the failing test.** That test is not edited during the fix (rule 1 of `AGENTS.md`).
- **Anything that depends on a model is measured with evals, not unit tests** (section 6).
- **Only synthetic or anonymized data** in tests and reference fixtures, per [policy/data-classification.en.md](../policy/data-classification.en.md).
- **A slow or flaky test is fixed or deleted**, with an issue. It is never silently skipped to turn CI green.

## 4. Git and pull requests

- **Short-lived branches off `main`.** One branch per issue, living days, not weeks. `main` is always in a working state.
- **Small PRs.** As a guide, under about 400 changed lines excluding generated files. A large PR is split at the issue, not in review.
- **Commits in English, imperative mood, with the why.** "Add retry to ERP export because the API times out at night", not "fix". Always squash merge.
- **The PR tells the story.** What changed, why, and the evidence, following the template. Reviewers read the diff, not just the agent's summary.
- **Generated files and secrets stay out of the repository**, except lockfiles.

## 5. Engineering with coding agents

How we work with Claude, Codex or other agents, whichever one it is.

**Context**

- `AGENTS.md` is short and stable: rules and pointers. Detail lives in linked documents like this one. If `AGENTS.md` grows past about 200 lines, trim it.
- **Every repeated mistake improves the system.** If an agent makes the same mistake twice, add a line to `AGENTS.md` or, better, a CI check. That is the team's learning loop.
- The source-of-truth documents (`PLAN`, `QUEUE`, `BOARD`) are kept current because they are the next agent's context.

**Sessions**

- **One task per session, with a clean context.** A long session that mixes topics produces worse work. New task, new session.
- **Plan before coding.** For anything non-trivial, the agent proposes a plan (the artifact chain in `AGENTS.md`) and a person approves it before code.
- **Isolated work.** Each session works on its own branch (and its own worktree when several run at once). Worktree cleanup rules are in `AGENTS.md`.

**Verification**

- **The agent runs the tests itself** and pastes the result. "It should work" is not evidence.
- **Independent review.** A second agent, with a different prompt and ideally a different model, reviews the PR trying to break it. That reviewer never merges.
- **What an agent never does:** edit or skip tests to make them pass, disable lint rules, add dependencies without saying so in the PR, touch files outside the issue's scope.

**Records**

- The PR is the session record: link the agent session when the tool allows it (for example the `Claude-Session` line in commits).
- For now we do not record full sessions with external tools. If we do (for example Beacon), it will be in local mode, because a session can contain client data.

## 6. AI systems we deliver to clients

This is where most of the risk and the value is. It applies from the first pilot.

**Design**

- **Workflows before agents.** Most client processes are solved with fixed steps and a model at the points that need one. An autonomous agent is justified by an eval showing the fixed workflow is not enough.
- **Structured, validated outputs.** The model returns JSON against a schema; code validates before acting. An invalid output is a visible error, not a default value.
- **A person approves what cannot be undone.** Payments, supplier orders, messages to the client's customers and changes to the core system (ERP) go through human approval until the evals and the client say otherwise, in writing.
- **Provider independence.** Model calls go through our own thin adapter. The model version is pinned in configuration. Switching models means running the evals, not rewriting the system.
- **Prompts are code.** They live in the repository, change by PR, and every change runs the evals.

**Evals**

- **Look first, then measure.** Before writing evals, read 30 to 50 real runs and note how the system fails. Each failure type becomes a criterion.
- **A reference set built from client data.** About 50 to 100 cases labeled by a person who knows the process, with real anonymized data in the real language (usually Spanish). They live in `ci/golden/` in the client repository and change only with human approval.
- **Pass or fail per failure type**, not an overall 1-to-10 score. One judge (another model) per criterion, and the judge itself is validated against the human labels.
- **Thresholds are agreed with the client.** How much precision and how much recall are needed is a business decision. It is set before building and is the pilot's definition of done.
- **Evals run in CI** whenever a prompt, a model or the logic around the model changes.
- **Measure against a baseline**: the client's current process, measured and signed off before starting.

**Observability**

- **Every model call leaves a record:** input and output (with personal data masked according to its class), model and version, prompt version, latency, tokens and cost, and the workflow run id.
- **Open format.** Structured (JSON) logs, OpenTelemetry-compatible, so we do not depend on a platform.
- **Cost and latency have a budget.** Each workflow has an expected cost per run; exceeding it raises an alert.
- **Failures are visible.** An unreadable source or an invalid output raises a warning, never a "nothing new" (rule 2 of `AGENTS.md`).

**Handoff to the client**

- Every delivered system includes an operations runbook: how to run it, how to tell it is failing, how to switch models and whom to call.
- Technology the client's team can operate. If the client has no developers, that changes the design, not just the documentation.

## 7. What we are not adopting yet

Things that sound good but cost more than they are worth today. They are revisited when the condition is met.

| Not adopting | Why not | Revisit when |
|---|---|---|
| Our own agent runtime (like Ramp's Laminar) | Makes sense at millions of sessions, not for a pilot | We run several clients with agents in production |
| Long-running workflow engines (Temporal or similar) | A simple queue and retries are enough | A workflow runs for hours or must resume after a failure |
| Multi-agent orchestration frameworks | Add complexity that is hard to debug and hand off | An eval shows a single workflow is not enough |
| Paid eval or observability platforms | Files, scripts and JSON logs are enough at the start | We have more than one system in production |
| Recording agent sessions in a third party's cloud | Sessions can contain client data | There is an agreement and a security review |
| Microservices, Kubernetes | One service is easier to run and to hand off | A client requires it or load justifies it |
| Beta agent frameworks (for example Vercel's eve) for client production | APIs change and they tie us to a vendor | They leave beta; fine for internal prototypes |

## 8. How this standard changes

- By PR, like any other change, updating both language versions.
- What the Radar marks as adopted comes in here; what stops being useful goes out.
- Full review every quarter or at the close of each pilot, whichever comes first.
