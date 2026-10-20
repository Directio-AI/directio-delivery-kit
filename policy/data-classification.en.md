# Data classification and handling

_English version of [data-classification.md](data-classification.md); the Spanish original prevails. Status: draft, in force internally. Last updated: 2026-10-20._

Guatemala has no comprehensive personal data protection law in force as of this writing (verify the status of the pending bill before each new client). We follow this policy anyway: serious clients expect these controls whether or not the law requires them, and foreign law (GDPR, US state laws) can apply when a client's customers or partners are abroad.

## The four classes

| Class | Examples | May reach a cloud AI tool? | May live in a repo? |
|---|---|---|---|
| **Public** | Published price lists, catalogues, website text | Yes | Yes |
| **Business confidential** | Costs, margins, supplier terms, production volumes, internal processes, unpublished designs | Only after a signed confidentiality agreement and only through tools on the approved list | Only in that client's own private repo |
| **Personal** | Names, ID numbers (DPI, NIT), phone numbers, emails, addresses, plates, payroll rows tied to a person | Only redacted or pseudonymized, after a signed agreement | Never in raw form; redacted samples only |
| **Sensitive** | Health, bank account or card numbers, biometric data, salary of a named person, legal disputes | No, unless the client approves the specific tool and purpose in writing | Never |

When in doubt, classify one level higher.

## Rules

1. **Classify at intake.** Every file a client sends gets a class before anyone opens it in an AI tool. Record it in the client repo's data register (`docs/data-register.md`): file, source, class, owner, date received, retention date.
2. **Minimize.** Ask for only the columns and periods the process needs. Drop the rest before any processing.
3. **Redact before the model.** Personal identifiers are replaced with stable pseudonyms (for example `EMP-0042`) before any model sees the data. The mapping table stays with the client or in the client's encrypted storage, never in a prompt.
4. **Approved tools only.** Client data goes only into tools on the approved list below, on business or API tiers whose terms exclude training on our data. Consumer accounts are never used for client data.
5. **Client owns the data.** We process it only for the engagement and return or delete it at the end.
6. **Retention.** Default: raw client files deleted 30 days after the engagement ends; derived artifacts (process maps, specs) kept unless the client asks otherwise. Logs and traces follow the same retention as the data they contain.
7. **Traces are data too.** Prompt logs, agent traces and chat histories that contain client data are classified like that data.
8. **Access.** Least privilege. One private repo and one secrets store per client. No shared passwords. Access removed when the engagement ends.
9. **Incidents.** Any suspected leak (wrong recipient, data pasted into an unapproved tool, lost device) is reported to the founders the same day and to the client within 72 hours of confirmation, with what happened and what we did.

## Approved tools

Kept short on purpose. Adding a tool is a Class C decision (needs a founder).

| Tool | Allowed classes | Notes |
|---|---|---|
| _(to fill before the first client)_ | | Confirm current terms: no training on inputs, retention period, data region |

## For agents

Agents treat this file as binding. If an issue or file implies data above **Public** in this repo, stop and label `needs-human`.
