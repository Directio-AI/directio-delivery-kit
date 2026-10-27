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

We use AI in three layers, each with different rules:

1. **Our backbone.** Directio's tools, on our accounts, to build and run the kit and our internal work. No client data.
2. **Build.** During discovery and construction we handle real client data. **Preferred:** work inside the client's licenses from day one (they create an account or API key for us). **Fallback:** if we process on our side, only with our approved accounts below, never with personal or consumer accounts.
3. **Production.** The solution runs on the client's licenses (their ChatGPT Enterprise, their Microsoft 365 or Google Workspace, their API keys). Data stays under the client's contract with the vendor; we configure and operate.

Reviewed 2026-10-27 against each provider's published terms. Terms change: review before each new client and every 6 months. "Personal" always means pseudonymized (rule 3); **Sensitive** data goes into no tool without the client's written approval.

### Layer 2: our accounts approved for client data

| Tool | Allowed classes | Why, and conditions |
|---|---|---|
| **OpenAI**: ChatGPT Business or Enterprise, and the API | Public, Business confidential, Personal (pseudonymized) | OpenAI states it does not train on data from these plans by default. Retention is configurable (zero retention on the API for qualifying accounts). |
| **Anthropic Claude**: Team or Enterprise, and the API (includes Claude Code under commercial terms) | Public, Business confidential, Personal (pseudonymized) | Anthropic states it does not train on data under commercial terms. Standard retention is 30 days. |
| **Google Gemini**: Gemini in qualifying Google Workspace editions, and the paid tier of the Gemini API | Public, Business confidential, Personal (pseudonymized) | Google states it does not use this data to train or improve products. **The free API tier and Google AI Studio without billing do use it**: forbidden for client data. |

### Layer 1: internal work only (no client data)

Any layer 2 tool works here too. Consumer plans we pay for (for example Claude Max) are fine for internal work with model training turned off in their privacy settings.

| Tool | Allowed classes | Why, and conditions |
|---|---|---|
| **Cursor** | Public; code from client repos only with Privacy Mode enforced for the whole team | With Privacy Mode, Cursor states it does not train on the code and has zero-retention agreements with its model providers. Without it, Cursor may store and train on the code. Never personal data. |
| **Grok (xAI)** | Public | The consumer version uses what you type for training. Business and API plans exist, but we have not verified their data terms. Re-evaluate if a client asks for it. |
| **Meta's Muse agent** | Public | Launched in 2026; we found no published enterprise data-handling terms, and analysts flag trust concerns. Re-evaluate when they exist. |
| **Hermes Agent (Nous Research)** | Whatever the connected model allows | Open source and runs on our own server; data goes only to the model provider it is configured with. Candidate for clients who don't want data leaving their infrastructure. |

### Layer 3: the client's licenses

The client chooses and pays for the vendor; we don't impose one. Before connecting any process, we check with their admin:

- The plan is a business or API plan, not a consumer one.
- Training on their data is off and retention matches what the client wants.
- Directio has its own user or key, with least access, revocable when the engagement ends.
- Usage costs are billed to the client, with a spending cap set.

What we checked is recorded in the client's repo.

### Never, for client data

Free or personal accounts of any tool (ChatGPT, Claude, Gemini, Grok, Meta AI and the like), even when the tool's business version is listed above.

## For agents

Agents treat this file as binding. If an issue or file implies data above **Public** in this repo, stop and label `needs-human`.
