# Client space template

What we use with each client, from the first call to the pilot. Copy it per client with `scripts/new-client.sh`.

**Golden rule:** a client's data and documents never enter this repository. Each client's copy lives outside the repo (in the project's shared folder or in the client's own repo). See `policy/data-classification.en.md`.

## What it contains

| File | Purpose | When |
|---|---|---|
| `ficha-cliente.md` | What we know, where it came from and what is missing. Process map with an AI-fit score. | Before and after each meeting |
| `diagnostico-area.md` | Goals, candidate processes, constraints and dependencies; reused when onboarding champions. | When onboarding or updating an area |
| `diagnostico-champion.md` | Detailed map, AI starting point and conditions for the first practice. | Before training each champion |
| `solicitud-datos.md` | What we ask the client for, including a client-side AI account or API key. | When closing the first meeting |
| `escenario-sintetico.md` | How to build fictitious test data so work can start without waiting for the client. | From day 1 |
| `propuesta-piloto.md` | Pilot with baseline, KPI, autonomy level and what is out of scope. Includes the data register. | When proposing |
| `adopcion.md` | First session script, first wins per role and the "Empieza aquí" (start here) page. | When the pilot starts |
| `capacitacion-champions.md` | Six sessions using the person's process and follow-up through the AI Companion Guide. | After diagnostics and pilot preparation |

## How to use it

1. `scripts/new-client.sh <client> [destination]` copies Spanish templates and creates `escenario-SINTETICO/` outside this repository. Read the scenario guide here; it is not copied. For multiple areas or champions, duplicate their profiles within the client's authorized space and keep references and versions.
2. Fill in the client profile and area diagnostic. Mark each fact **[C] confirmed**, **[I] inferred** or **[P] pending**, with source and date; assign owners to pending items.
3. Complete the champion diagnostic and detailed map. If the area is already diagnosed, verify it is current and reuse it instead of repeating it.
4. Prepare the pilot proposal, synthetic scenario with answer key and first template. Verify the individual diagnostic's starting conditions.
5. Start training and the Companion Guide with that task. Session 3 validates and completes the initial map; it does not replace the prior diagnostic.
6. With compatible authorization for real data, repeat the test in the approved environment and measure against a comparable baseline. The synthetic scenario is never presented as the client's result.

Deliverables for Latin American clients are in Spanish only. The file names stay in Spanish because those are the copies the client sees; the Spanish files are the originals.
