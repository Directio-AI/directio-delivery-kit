# Client space template

What we use with each client, from the first call to the pilot. Copy it per client with `scripts/new-client.sh`.

**Golden rule:** a client's data and documents never enter this repository. Each client's copy lives outside the repo (in the project's shared folder or in the client's own repo). See `policy/data-classification.en.md`.

## What it contains

| File | Purpose | When |
|---|---|---|
| `ficha-cliente.md` | What we know, where it came from and what is missing. Process map with an AI-fit score. | Before and after each meeting |
| `solicitud-datos.md` | What we ask the client for, including a client-side AI account or API key. | When closing the first meeting |
| `escenario-sintetico.md` | How to build fictitious test data so work can start without waiting for the client. | From day 1 |
| `propuesta-piloto.md` | Pilot with baseline, KPI, autonomy level and what is out of scope. Includes the data register. | When proposing |
| `adopcion.md` | First session script, first wins per role and the "Empieza aquí" (start here) page. | When the pilot starts |

## How to use it

1. `scripts/new-client.sh <client>` creates the client's folder with the profile, the request, the proposal and the adoption files, plus an empty `escenario-SINTETICO/` folder. The scenario guide is read here, not copied.
2. Fill in the profile with what you already know and mark each fact as **confirmed** (the client said it or we saw it), **inferred** (we deduced it) or **pending**.
3. Build the synthetic scenario for the candidate process and test the pilot with it while real data arrives.
4. When real data arrives, run the same test with it. The synthetic scenario is never presented as the client's result.

Deliverables for Latin American clients are in Spanish only. The file names stay in Spanish because those are the copies the client sees; the Spanish files are the originals.
