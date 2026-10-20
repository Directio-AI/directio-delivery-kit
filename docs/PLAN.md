# Plan

_Last updated: 2026-10-20_

## Purpose

Build a delivery kit that lets Directio deploy AI into client processes the same way every time: discovery, process map, spec, build, verify, operate. Any coding agent can do the build work because the rules live in the repo and CI.

## Current phase: foundation

Goal: the repo can accept work safely before any client work starts.

- [x] Repo created (private, `Directio-AI` organization)
- [x] Agent instructions, source-of-truth files, artifact and work-unit templates
- [x] CI gates: secret scanning, structure check, fixture guard
- [ ] Repository settings applied (see ADR 0001)
- [ ] Agent role prompts in `agents/`
- [x] Policies: data classification, AI use policy, confidentiality agreement template (drafts; agreement awaits lawyer review)
- [ ] Client-space template and new-client script

## Next phase: first engagement

Use the kit on the first client process (candidate: the furniture group pilot). Discovery only until a confidentiality agreement is signed; no client data enters any cloud tool before then.

## Out of scope for now

- Local or on-premise models (revisit when a client requires data to stay in their building)
- Durable workflow engines (Temporal or similar)
- Anything specific to Sin Demora, Ventara or any single client
