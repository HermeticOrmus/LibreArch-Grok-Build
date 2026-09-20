# Quick Start — LibreArch for Grok Build

> From a clean machine to one written ADR and a named blast radius in under 5 minutes.

Doctrine first: put [grok-build-reality-os](https://github.com/HermeticOrmus/grok-build-reality-os) `AGENTS.md` on the machine (global Grok doctrine). This pack does not replace it.

## Prerequisites

- `git`
- Grok Build installed and able to see skills under `.grok/skills/` or `~/.grok/skills/`
- A system or service boundary you own / are designing, **or** this repo as the working tree

## Layout this file assumes

Verified against this repository (do not invent extra folders):

```
skills/<name>/SKILL.md          # canonical skill bodies (copy these)
AGENTS/arch-orchestrator.md
docs/DEPTH_MATRIX.md
docs/MELT_RULES.md
.grok/skills/<name>/SKILL.md    # dogfood copy; must match skills/
.grok/plugins/librearch-core/   # plugin stub; not required for first run
```

Melted (usable now): `skills/adr-write/SKILL.md`, `skills/blast-radius-lite/SKILL.md`, `skills/hexagonal-ports/SKILL.md`.
Still stubs: the other six skills + the orchestrator. Honest table: [docs/DEPTH_MATRIX.md](./docs/DEPTH_MATRIX.md).

## Install (pick one)

### A. Dogfood this repo (fastest)

```bash
git clone https://github.com/HermeticOrmus/LibreArch-Grok-Build.git
cd LibreArch-Grok-Build
# Skills are already at .grok/skills/ — open this folder in Grok Build.
```

### B. Install into your service / system repo

```bash
git clone https://github.com/HermeticOrmus/LibreArch-Grok-Build.git ~/LibreArch-Grok-Build
cd /path/to/your-system
mkdir -p .grok/skills
cp -R ~/LibreArch-Grok-Build/skills/* .grok/skills/
```

Confirm the copy landed:

```bash
test -f .grok/skills/adr-write/SKILL.md
test -f .grok/skills/blast-radius-lite/SKILL.md
test -f .grok/skills/hexagonal-ports/SKILL.md
ls .grok/skills
```

You should see nine skill directories, matching `skills/` in this repo.

### C. User-global

```bash
git clone https://github.com/HermeticOrmus/LibreArch-Grok-Build.git ~/LibreArch-Grok-Build
mkdir -p ~/.grok/skills
cp -R ~/LibreArch-Grok-Build/skills/* ~/.grok/skills/
```

Same three `test -f` checks as B, under `~/.grok/skills/`.

Copy `AGENTS/arch-orchestrator.md` only when you want a multi-skill architecture pass. It is still a stub coordinator.

## First-run teach cue

In Grok Build, on a real decision you own:

1. **Decide** — "Run adr-write for the decision you are about to make. Start with a Y-statement. If you cannot finish the accepting clause, stop."
2. **Reach** — "Run blast-radius-lite on that choice: name the contract, list direct dependents, label unverified hops, pick a reach tier. No fake repo-percent scores."
3. **Boundary (melted) / harden (stub)** — "If the change is a port or adapter, run hexagonal-ports. Then list leftover context-map items for ddd-bounded-context. Do not invent a full context map."

You used melted LibreArch depth on Grok — not a Claude paste, not a fake plugin count.

## Hard rules

- Never embed secrets in prompts, ADRs, or examples.
- Honest depth: melted vs stub. See [docs/DEPTH_MATRIX.md](./docs/DEPTH_MATRIX.md).
- Gold Hat: empower or extract? Teach the *why* while you write the record.

## Smoke checklist

- [ ] `adr-write`, `blast-radius-lite`, and `hexagonal-ports` files exist at the install path you chose
- [ ] Grok can see those three skills
- [ ] One ADR draft with a Y-statement, ≥2 alternatives, consequences, and reversibility (no secret material)
- [ ] One blast card with a named contract, dependents, and a reach tier (no invented graph score)
- [ ] No secrets in prompts, examples, or output

## Suite

- Doctrine: [grok-build-reality-os](https://github.com/HermeticOrmus/grok-build-reality-os)
- This pack: [LibreArch-Grok-Build](https://github.com/HermeticOrmus/LibreArch-Grok-Build)
- Sibling Libre*-Grok-Build packs: [UIUX](https://github.com/HermeticOrmus/LibreUIUX-Grok-Build) · [Copy](https://github.com/HermeticOrmus/LibreCopy-Grok-Build) · [DevOps](https://github.com/HermeticOrmus/LibreDevOps-Grok-Build) · [Embed](https://github.com/HermeticOrmus/LibreEmbed-Grok-Build) · [FinTech](https://github.com/HermeticOrmus/LibreFinTech-Grok-Build) · [GameDev](https://github.com/HermeticOrmus/LibreGameDev-Grok-Build) · [GEO](https://github.com/HermeticOrmus/LibreGEO-Grok-Build) · [MLOps](https://github.com/HermeticOrmus/LibreMLOps-Grok-Build) · [MobileDev](https://github.com/HermeticOrmus/LibreMobileDev-Grok-Build) · [SecOps](https://github.com/HermeticOrmus/LibreSecOps-Grok-Build) · [SessionFlow](https://github.com/HermeticOrmus/LibreSessionFlow-Grok-Build) · [WhatsApp](https://github.com/HermeticOrmus/LibreWhatsApp-Grok-Build)
- Skills collections: [grok-skills](https://github.com/HermeticOrmus/grok-skills) · [grok-build-skills](https://github.com/HermeticOrmus/grok-build-skills)
- Claude proof (upstream, not this inventory): [LibreArch-Claude-Code](https://github.com/HermeticOrmus/LibreArch-Claude-Code)
- https://ormus.solutions
