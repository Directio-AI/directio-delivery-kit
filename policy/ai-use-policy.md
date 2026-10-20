# AI use policy

_Status: draft, in force internally. Last updated: 2026-10-20. One page on purpose; it can be shared with clients as is._

## Why we have it

AI makes our work faster. It can also be confidently wrong, and it can leak data if used carelessly. This policy keeps the speed and controls the risk.

## Principles

1. **A person is accountable for every output.** AI drafts, suggests and automates. A named person at Directio or at the client signs off on anything that reaches a customer, moves money, or changes a record of truth.
2. **AI output is a draft until checked.** Numbers, names, dates, legal or technical claims are verified against the source before use.
3. **Data follows its class.** See [data-classification.md](data-classification.md). No client data in tools that are not on the approved list.
4. **Start supervised, earn autonomy.** Every automated process starts at the lowest autonomy level and moves up only with measured results and the client's written agreement:
   - Level 1: AI suggests, a person does.
   - Level 2: AI does, a person approves each action.
   - Level 3: AI does, a person reviews samples and exceptions.
5. **Say when AI was used.** Clients know which deliverables and processes involve AI.
6. **Fail visibly.** A process that cannot complete says so; it never fills gaps with guesses.

## Allowed

- Drafting, summarizing, translating and analysing material at a data class the tool is approved for.
- Writing and reviewing code in Directio repos, under the rules in `AGENTS.md`.
- Prototyping with synthetic or public data.

## Not allowed

- Putting client data in personal or consumer AI accounts.
- Letting an AI make a final decision about a person (hiring, credit, discipline).
- Presenting AI output as verified when it was not checked.
- Using a client's data to improve anything for another client.

## Questions and exceptions

Any founder can approve an exception in writing. Exceptions are recorded in the client repo with the reason and an expiry date.
