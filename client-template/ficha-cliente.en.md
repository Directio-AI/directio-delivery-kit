# Client profile: <client>

- Last updated: <date>
- Directio owner: <person>
- Client's main contact: <name, role>
- Who decides and who signs off the spend: <name(s)>
- Stage: prospect | diagnostic | pilot | program
- Highest data class we will touch: Public | Business confidential | Personal | Sensitive

Every fact carries a mark: **[C]** confirmed (the client said it or we saw it), **[I]** inferred (we deduced it), **[P]** pending.

## 1. The business in five lines

What they sell, to whom, size (people, countries, revenue if given), which systems they use and which AI they use today, officially or on their own.

## 2. What they asked for, in their words

Short quotes, attributed to an area or role rather than a person if the document will circulate.

## 3. Sources

| Date | Source | Who was there | What it contributed |
|---|---|---|---|
| | Meeting, transcript, document, website | | |

## 4. Process inventory and AI fit

One row per candidate process. Score each column from 1 to 3; the total ranks candidates with comparable information. If a fact is missing, mark [P] and leave the total pending. Complete the detailed map in [diagnostico-champion.md](diagnostico-champion.en.md), within the [area diagnostic](diagnostico-area.en.md).

Before prioritizing, confirm that a permitted, reviewable trial is possible. Data availability does not equal authorization. A high score does not replace permissions or the risk decision.

| Process | Pain (what it costs today) | Data available | Repetitive and document-based | Risk if the AI is wrong (3 = low) | Measurable in weeks | Total |
|---|---|---|---|---|---|---|
| | | | | | | |

How to score:
- **Pain:** 3 if the client named it unprompted and it has a visible cost (hours, money, lost customers).
- **Data available:** 3 if historical examples exist and they can give them to us soon; 1 if they have to be created.
- **Repetitive and document-based:** 3 if it is reading, comparing, extracting or drafting over similar documents.
- **Risk:** 3 only with bounded consequences and verifiable controls that detect errors before the output is used; 1 if an error could reach the customer or an authority. Human review alone does not establish low risk; document consequences and controls.
- **Measurable:** 3 if a baseline can be taken within a week.

## 5. Process chosen for the first pilot

Which one, why (with the score), and which synthetic scenario represents it (`escenario-SINTETICO/`).

Reference to the [visual map](mapa-proceso.en.md) included in the area and champion diagnostics: <version and figure>. It must show as is, intervention points, human review and [C]/[I]/[P] marks; the fit matrix does not replace it.

## 6. Client constraints

Allowed and forbidden tools, systems not to be touched, human-oversight rules, data rules.

## 7. Open questions

What is missing to move a fact from inferred to confirmed. Each question with who it is for.

## 8. Next step

One line: what, who, when.
