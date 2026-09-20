# Depth matrix

Update this table when melting. Status words mean what they say:

| Status | Meaning |
|--------|---------|
| stub | Thin cue only. Usable as a reminder, not a playbook. Suite depth: **L2**. |
| melted | Real Grok skill: when-to-use, steps, measurable checks, example, output shape. Suite depth: **L3–L4**. |

Levels (honest, this pack only):

| Level | What it is | This repo |
|-------|------------|-----------|
| L1 | Empty scaffold | Past. Not current. |
| L2 | Teach-cue stub | Six skills + `arch-orchestrator` |
| L3 | Playbook (when / steps / checks) | Included in every melted skill |
| L4 | Playbook + worked example + output shape + anti-patterns + stub handoffs | The three melted skills target this. Not claimed for the rest. |
| L5 | Depth-complete encyclopedia / full plugin | **Not claimed.** Upstream Claude is proof the *job* exists. |

Never copy Claude plugin / agent / command totals into this inventory. Upstream [LibreArch-Claude-Code](https://github.com/HermeticOrmus/LibreArch-Claude-Code) is proof that the *job* exists, not a count this repo has earned.

| ID | Kind | Status | Depth | Source (Claude, for melt) | Notes |
|----|------|--------|-------|---------------------------|-------|
| adr-write | skill | melted | L3–L4 | plugins/architecture-decision-records | Y-statement, Nygard/MADR, lifecycle, anti-patterns. No slash-command theater. |
| blast-radius-lite | skill | melted | L3–L4 | Grok-native (no Claude plugin) | Change-reach card. No fake repo-percent scores. Not a security scanner. |
| hexagonal-ports | skill | melted | L3–L4 | plugins/hexagonal-architecture | Ports, adapters, inward deps, in-memory doubles. Framework-agnostic. |
| ddd-bounded-context | skill | stub | L2 | plugins/domain-driven-design | Glossary / map cue only. |
| system-design-lite | skill | stub | L2 | plugins/system-design | Capacity cue only. |
| saga-compensation | skill | stub | L2 | plugins/saga-patterns | Compensation cue only. |
| caching-strategy | skill | stub | L2 | plugins/caching-strategies | TTL cue only. |
| migration-strangler | skill | stub | L2 | plugins/migration-strategies | Seam cue only. |
| resilience-patterns | skill | stub | L2 | plugins/circuit-breaker | Timeout cue only. |
| arch-orchestrator | agent | stub | L2 | suite coordinator (Claude agents as proof) | Coordinates the skills; not a melted specialist. |

This repo now: **3 melted skills (L3–L4)**, **6 stub skills (L2)**, **1 stub agent (L2)**.

Dogfood copies of every skill live at `.grok/skills/<name>/SKILL.md` and must match `skills/<name>/SKILL.md`.

## Suite

Doctrine: [grok-build-reality-os](https://github.com/HermeticOrmus/grok-build-reality-os). Sibling Libre*-Grok-Build packs: [README suite footer](../README.md).
