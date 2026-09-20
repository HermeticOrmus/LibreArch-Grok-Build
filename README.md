# LibreArch-Grok-Build

**Architecture / DDD skills for [Grok Build](https://github.com/HermeticOrmus/grok-build-reality-os)** — ported and melted from [LibreArch-Claude-Code](https://github.com/HermeticOrmus/LibreArch-Claude-Code), not a dumb copy.

> Status: **public v0.1** — three skills melted (`adr-write`, `blast-radius-lite`, `hexagonal-ports`) to **L3–L4**; the rest are honest L2 stubs. See [docs/DEPTH_MATRIX.md](./docs/DEPTH_MATRIX.md).

## Why this exists

Architecture decisions compound. LibreArch owns ADRs, DDD, system design, hexagonal, sagas, resilience. Grok Build needs the same *job* with Grok-native skills, agents, `.grok/`, and truth-seeking voice. This repo counts only what it has melted.

## Install (<5 min)

See [QUICK_START.md](./QUICK_START.md) for clone, dogfood, project-local, and user-global paths.

```bash
git clone https://github.com/HermeticOrmus/LibreArch-Grok-Build.git
cd LibreArch-Grok-Build
# Dogfood: .grok/skills/ already has the skill bodies.
# Other project: cp -R skills/* /path/to/your-system/.grok/skills/
```

Doctrine: install [grok-build-reality-os](https://github.com/HermeticOrmus/grok-build-reality-os) `AGENTS.md` on the machine first. This pack does not replace doctrine.

## Depth (honest)

| Artifact | This repo now | Upstream Claude |
|----------|---------------|-----------------|
| Skills | 3 melted (L3–L4) + 6 stubs (L2) | Proof the job exists; not our inventory |
| Agents | 1 stub (`arch-orchestrator`) | Proof the job exists; not our inventory |
| Plugins | 1 core bundle stub | Proof the job exists; not our inventory |

Do not paste Claude plugin/agent/command totals here. Update [docs/DEPTH_MATRIX.md](./docs/DEPTH_MATRIX.md) when something melts.

## Skills

| Skill | Status | Job |
|-------|--------|-----|
| adr-write | melted | Write ADRs that age well |
| blast-radius-lite | melted | What breaks if this change ships |
| hexagonal-ports | melted | Ports and adapters; inward dependencies |
| ddd-bounded-context | stub | Bounded contexts, ubiquitous language, seams |
| system-design-lite | stub | Capacity, consistency, tech selection sketch |
| saga-compensation | stub | Choreography vs orchestration + compensation |
| caching-strategy | stub | Cache-aside / write-through / invalidation |
| migration-strangler | stub | Strangler fig / branch-by-abstraction |
| resilience-patterns | stub | Timeouts, retries, circuit breakers, bulkheads |

Agent: `AGENTS/arch-orchestrator.md` — stub coordinator for a full suite pass.

## Layout (Grok Build)

```
skills/                 # canonical SKILL.md bodies
AGENTS/                 # suite agents
docs/                   # DEPTH_MATRIX, MELT_RULES
.grok/skills/           # dogfood copy of skills/ (keep in sync)
.grok/plugins/          # optional plugin bundle stub
```

Claude's `.claude/` maps to Grok skills + `AGENTS.md` + `.grok/`. Melt rules: [docs/MELT_RULES.md](./docs/MELT_RULES.md).

## Gold Hat

[GOLD_HAT.md](./GOLD_HAT.md) — does this empower or extract? The manifesto lives in one place: [gold-hat-manifesto](https://github.com/HermeticOrmus/gold-hat-manifesto). Teach the *why* of each decision; do not ship records that only name a winner.

## Suite

- Doctrine: [grok-build-reality-os](https://github.com/HermeticOrmus/grok-build-reality-os)
- This pack: [LibreArch-Grok-Build](https://github.com/HermeticOrmus/LibreArch-Grok-Build)
- Sibling Libre*-Grok-Build packs: [UIUX](https://github.com/HermeticOrmus/LibreUIUX-Grok-Build) · [Copy](https://github.com/HermeticOrmus/LibreCopy-Grok-Build) · [DevOps](https://github.com/HermeticOrmus/LibreDevOps-Grok-Build) · [Embed](https://github.com/HermeticOrmus/LibreEmbed-Grok-Build) · [FinTech](https://github.com/HermeticOrmus/LibreFinTech-Grok-Build) · [GameDev](https://github.com/HermeticOrmus/LibreGameDev-Grok-Build) · [GEO](https://github.com/HermeticOrmus/LibreGEO-Grok-Build) · [MLOps](https://github.com/HermeticOrmus/LibreMLOps-Grok-Build) · [MobileDev](https://github.com/HermeticOrmus/LibreMobileDev-Grok-Build) · [SecOps](https://github.com/HermeticOrmus/LibreSecOps-Grok-Build) · [SessionFlow](https://github.com/HermeticOrmus/LibreSessionFlow-Grok-Build) · [WhatsApp](https://github.com/HermeticOrmus/LibreWhatsApp-Grok-Build)
- Skills collections: [grok-skills](https://github.com/HermeticOrmus/grok-skills) · [grok-build-skills](https://github.com/HermeticOrmus/grok-build-skills)
- Claude proof: [LibreArch-Claude-Code](https://github.com/HermeticOrmus/LibreArch-Claude-Code)
- https://ormus.solutions

## License

MIT — see [LICENSE](./LICENSE).
