# LibreArch-Grok-Build

**Architecture / DDD skills for Grok Build** — ported and melted from [LibreArch-Claude-Code](https://github.com/HermeticOrmus/LibreArch-Claude-Code), not a dumb copy.

> Status: **v0 public scaffold** — honest stubs. Melt depth next.

## Why this exists

Architecture decisions compound. LibreArch owns ADRs, DDD, system design, hexagonal, sagas, resilience — melted for Grok Build from LibreArch-Claude-Code.

## Install (<5 min)

See [QUICK_START.md](./QUICK_START.md).

```bash
mkdir -p .grok/skills
cp -R skills/* .grok/skills/
```

Doctrine: install [grok-build-reality-os](https://github.com/HermeticOrmus/grok-build-reality-os) `AGENTS.md` on the machine first.

## Depth matrix (honest)

| Artifact | v0 scaffold | Upstream Claude (proof) |
|----------|-------------|-------------------------|
| Skills (melted bodies) | 8 stubs → fill next | see upstream suite |
| Agents | 1 (`arch-orchestrator`) | upstream agents |

Counts on the right are **upstream proof**, not this repo's claim until melted.

## First skills

| Skill | Job |
|-------|-----|
| adr-write | Write Architecture Decision Records that age well |
| ddd-bounded-context | Identify bounded contexts, ubiquitous language, seams |
| system-design-lite | Capacity, consistency, and tech selection sketch |
| hexagonal-ports | Ports & adapters — dependency direction that stays testable |
| saga-compensation | Saga choreography vs orchestration + compensation paths |
| caching-strategy | Cache-aside / write-through / invalidation — pick with eyes open |
| migration-strangler | Strangler fig / branch-by-abstraction migration plan |
| resilience-patterns | Timeouts, retries, circuit breakers, bulkheads — defensive defaults |

Agent: `AGENTS/arch-orchestrator.md` — full suite pass.

## Layout (Grok Build)

```
skills/                 # install into .grok/skills or ~/.grok/skills
AGENTS/                 # suite agents
.grok/plugins/          # optional plugin bundle
docs/                   # DEPTH_MATRIX, MELT_RULES
```

## Gold Hat

[GOLD_HAT.md](./GOLD_HAT.md) — empower or extract?

## Suite

- Doctrine: [grok-build-reality-os](https://github.com/HermeticOrmus/grok-build-reality-os)
- Sibling: [LibreUIUX-Grok-Build](https://github.com/HermeticOrmus/LibreUIUX-Grok-Build) · [LibreSessionFlow-Grok-Build](https://github.com/HermeticOrmus/LibreSessionFlow-Grok-Build) · [LibreGEO-Grok-Build](https://github.com/HermeticOrmus/LibreGEO-Grok-Build)
- Skills packs: [grok-skills](https://github.com/HermeticOrmus/grok-skills) · [grok-build-skills](https://github.com/HermeticOrmus/grok-build-skills)
- Claude proof: [LibreArch-Claude-Code](https://github.com/HermeticOrmus/LibreArch-Claude-Code)
- https://ormus.solutions

## License

MIT — see [LICENSE](./LICENSE).
