---
name: blast-radius-lite
description: Estimate what breaks if this change ships. Use before an ADR, a merge, or a rename — evidence-based reach, no invented graph scores.
---

# Blast Radius Lite

Answer "what breaks if I change this?" with evidence. Lite means you walk callers, contracts, deploy units, tests, and ADRs you can point at — not a fake percentage of the repo, not a security scanner, not an exploit map.

Gold Hat: measure reach *before* the merge so the person who owns the system stays in control. A vibe ("should be fine") extracts; a named list of dependents and unverified hops teaches the next change.

## When to use

- Before accepting an ADR that will move a contract, schema, port, or public API
- Before renaming a type, event, column, or shared helper
- When a PR looks local but sits on a shared kernel
- When someone asks "is this safe to ship?" and you have a path or symbol, not a feeling

Do not use this skill to design attacks, bypass access, or map secrets. If the change is "how do I get into X," stop.

Hand the *decision* to `adr-write` (melted). Hand dependency *direction* to `hexagonal-ports` (melted). Traffic-shift and rollback *plans* stay with `migration-strangler` (still a stub). Compensation paths stay with `saga-compensation` (stub). Call the stubs; do not invent their depth.

## Operating steps

1. **Name the change.** One sentence: symbol or file, old contract, new contract. If you cannot name the contract, you are not ready to estimate reach.
2. **Collect direct evidence.** Imports, type refs, HTTP/event consumers, SQL/migration touch, feature flags, config keys, ADR ids. Quote paths. Do not invent a call graph.
3. **Walk one hop out.** For each direct dependent, say whether you *checked* the next hop or marked it **unverified**.
4. **Classify reach** (table below). Pick the highest tier that has evidence. If unsure, take the higher tier and say why.
5. **Name rollback and proof.** What test or check would fail if a dependent was missed? What is the revert story?
6. **Teach one sentence.** The rule the next engineer should reuse ("shared ports are cross-service until proven otherwise").

Stop if you have no path and no symbol. Ask. Guessing a global blast radius is extraction.

## Reach tiers

| Tier | Meaning | Evidence you must have |
|------|---------|------------------------|
| Local | Same module / same package | Callers you opened; no public export |
| Service | Same deployable, several packages | In-repo importers, same binary / service dir |
| Cross-service | Another process, repo, or team | Event name, HTTP path, shared lib, proto, OpenAPI |
| Global | Platform, auth, schema, or client-visible contract | Migration, public API, cookie/token shape, shared kernel |

Lite forbids numeric "12% of the repo" scores unless you ran a real indexer and can name it. If you did not run one, do not fake one.

## High-reach signals (raise the tier)

Treat these as **at least service**, usually **cross-service** or **global**, until evidence says otherwise:

| Signal | Why it spreads |
|--------|----------------|
| Auth / session / identity shape | Every caller that trusts the token |
| Public HTTP / RPC / webhook path | Unknown external consumers |
| Domain events / queue payloads | Consumers you do not compile with |
| Schema / migration / shared table | Readers in other services |
| Shared kernel / published package | Downstream version lag |
| Feature flag default or kill-switch | Runtime behavior without a deploy |
| ADR-tagged seam | A recorded decision is in force |

If you did not search for a signal, write **unverified** next to it. Absence of evidence is not evidence of local.

## Measurable checks

| Check | Pass | Fail |
|-------|------|------|
| Contract named | Old → new in one line | "refactor the helper" |
| Direct dependents | Paths or API names you opened | "probably just this file" |
| Hops | Checked vs **unverified** labeled | Silent assumption of isolation |
| Tier | Matches the strongest signal | Local despite a public route |
| Proof | Test, contract test, or grep you ran | "we would notice" |
| Rollback | Concrete revert or dual-publish | "deploy forward" |
| Secrets | None in the report | Tokens pasted as "example" |

## Worked example — rename an outbound port method

Job: rename `OrdersPort.loadById` to `OrdersPort.get` inside a hexagonal service. Primary risk: every adapter and every test double that implements the port.

Evidence (you actually grepped):

```
skills are not the repo — imagine the service tree:

src/application/ports/orders-port.ts     # the change
src/application/place-order.ts           # calls loadById
src/adapters/http/get-order-handler.ts   # inbound; calls use case, not the port
src/adapters/postgres/pg-orders-adapter.ts
src/adapters/memory/memory-orders-adapter.ts
test/place-order.test.ts
```

Blast card (abridged):

```markdown
## Change
`OrdersPort.loadById(id) → OrdersPort.get(id)` in `src/application/ports/orders-port.ts`.
Return type unchanged. No HTTP or event payload change.

## Direct dependents (checked)
- `place-order.ts` — application caller
- `pg-orders-adapter.ts` — outbound adapter
- `memory-orders-adapter.ts` — test double
- `place-order.test.ts` — constructs the double

## Next hops
- HTTP handler: **checked** — talks to the use case, not the port. No public contract change.
- Other services: **unverified** — no event or proto in this rename; did not search other repos.

## Tier
Service. Strongest signal is a port implemented in two adapters. No schema, no public route.

## Proof
`rg 'loadById' src test` is empty after the rename. Unit tests for `place-order` still compile against the memory adapter.

## Rollback
Revert the PR. No dual-publish needed; method is not a released package.

## Teach
A port rename is service-tier until an adapter is a published client. Do not call it local because the file is one line.
```

If the same rename leaked into an OpenAPI path or a versioned event, the tier would jump to **cross-service** or **global**. That jump is the whole point of this skill.

## Anti-patterns

| Anti-pattern | Why it fails | Fix |
|--------------|--------------|-----|
| Fake score | "Low risk, 3% of repo" with no indexer | Drop the number; keep the list |
| Local-by-default | Shared files hide behind "small diff" | Start from the contract, not the line count |
| Silent hops | You assumed no other consumers | Label **unverified** |
| Security theater | Mapping attack surface as "architecture" | Stop; this skill is change-reach |
| Skipping ADRs | The seam already has a recorded rule | Open `docs/decisions/` and cite |

## Output shape

```markdown
## Change
[symbol or file] [old contract] → [new contract]

## Direct dependents
- [path or API] — [how it uses the contract]

## Next hops
- [name] — [checked | unverified] — [note]

## Tier
[local | service | cross-service | global] — [strongest signal]

## Proof
[command or test you ran, or "not run — unverified"]

## Rollback
[revert / dual-publish / flag]

## ADR
[existing ADR id, or "none — consider adr-write"]

## Teach
[one reusable sentence]

## Leftovers
- [stub skill] — [what you did not pretend to finish]
```

Empty dependent lists are allowed when you grepped and found none. Invented dependents are not. Invented safety is not.

## Quality bar

A pass is done when every hop is checked or labeled unverified, the tier matches the strongest signal, and a stranger knows how to prove they missed a caller. Refuse "LGTM, small diff."

## Suite

Doctrine: [grok-build-reality-os](https://github.com/HermeticOrmus/grok-build-reality-os). Gold Hat: [GOLD_HAT.md](https://github.com/HermeticOrmus/LibreArch-Grok-Build/blob/main/GOLD_HAT.md). Sibling Libre*-Grok-Build packs: [README suite footer](https://github.com/HermeticOrmus/LibreArch-Grok-Build/blob/main/README.md).
