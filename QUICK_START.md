# Quick Start — LibreArch for Grok Build

> From a clean machine to one written ADR and a named blast radius in under 5 minutes.

Doctrine first: put [grok-build-reality-os](https://github.com/HermeticOrmus/grok-build-reality-os) `AGENTS.md` on the machine (global Grok doctrine). This pack does not replace it.

## Prerequisites

- Grok Build installed: `curl -fsSL https://x.ai/cli/install.sh | bash`, then `grok --version`. Plugin commands need no login.
- `git` (only for the dogfood and copy paths); `jq` for the install-everything loop
- A system or service boundary you own / are designing, **or** this repo as the working tree

## Layout this file assumes

Verified against this repository (do not invent extra folders):

```
.grok-plugin/marketplace.json                   # the marketplace: libre-arch-grok, then the pack's plugins by pinned commit
plugins/libre-arch-grok/.grok-plugin/plugin.json
plugins/libre-arch-grok/skills/<name>/SKILL.md  # the melted skills (canonical)
stubs/skills/<name>/SKILL.md                    # stub cues; not installed
stubs/agents/arch-orchestrator.md               # stub coordinator; not installed
docs/DEPTH_MATRIX.md
docs/MELT_RULES.md
.grok/skills/<name>/SKILL.md                    # dogfood copy; must match its source above
.grok/plugins/librearch-core/                   # v0 bundle stub; dogfood copy of the stub orchestrator
```

Melted (usable now): `plugins/libre-arch-grok/skills/adr-write/SKILL.md`, `plugins/libre-arch-grok/skills/blast-radius-lite/SKILL.md`, `plugins/libre-arch-grok/skills/hexagonal-ports/SKILL.md`.
Still stubs, in `stubs/`: `ddd-bounded-context`, `system-design-lite`, `saga-compensation`, `caching-strategy`, `migration-strangler`, `resilience-patterns`, plus the orchestrator. Each stub names the pack plugin with the real depth. Honest table: [docs/DEPTH_MATRIX.md](./docs/DEPTH_MATRIX.md).

## Install (pick one)

### A. Marketplace (recommended)

One marketplace brings the Grok-native plugin and every LibreArch-Claude-Code plugin, each pinned to a commit:

```bash
grok plugin marketplace add HermeticOrmus/LibreArch-Grok-Build
grok plugin install libre-arch-grok@libre-arch-grok
grok plugin install domain-driven-design@libre-arch-grok
```

Every entry at once (needs `jq`):

```bash
for p in $(curl -fsSL https://raw.githubusercontent.com/HermeticOrmus/LibreArch-Grok-Build/main/.grok-plugin/marketplace.json | jq -r '.plugins[].name'); do
  grok plugin install "$p@libre-arch-grok"
done
```

Confirm what landed:

```bash
grok plugin list
grok plugin details libre-arch-grok
```

You should see `libre-arch-grok` (three skills: `adr-write`, `blast-radius-lite`, `hexagonal-ports`) plus the pack plugins you installed. The optional `libre-arch-hooks` plugin installs its hooks, but whether they fire inside a Grok session is unverified ([LEDGER.md](./LEDGER.md)).

Only the Grok-native plugin, without the marketplace:

```bash
grok plugin install HermeticOrmus/LibreArch-Grok-Build#plugins/libre-arch-grok
```

Do not install the repo root itself (`grok plugin install HermeticOrmus/LibreArch-Grok-Build`): since v1.0.0 the root holds no skills, so Grok installs an empty plugin.

### B. Dogfood this repo

```bash
git clone https://github.com/HermeticOrmus/LibreArch-Grok-Build.git
cd LibreArch-Grok-Build
# Dogfood copies of the melted skills and the stubs are at .grok/skills/; open this folder in Grok Build.
```

### C. Install into your service / system repo (copy, no plugin manager)

```bash
git clone https://github.com/HermeticOrmus/LibreArch-Grok-Build.git ~/LibreArch-Grok-Build
cd /path/to/your-system
mkdir -p .grok/skills
cp -R ~/LibreArch-Grok-Build/plugins/libre-arch-grok/skills/* .grok/skills/
```

Confirm the copy landed:

```bash
test -f .grok/skills/adr-write/SKILL.md
test -f .grok/skills/blast-radius-lite/SKILL.md
test -f .grok/skills/hexagonal-ports/SKILL.md
ls .grok/skills
```

You should see three skill directories, matching `plugins/libre-arch-grok/skills/` in this repo. The stubs are not copied: they are cues, not skills.

### D. User-global copy

```bash
git clone https://github.com/HermeticOrmus/LibreArch-Grok-Build.git ~/LibreArch-Grok-Build
mkdir -p ~/.grok/skills
cp -R ~/LibreArch-Grok-Build/plugins/libre-arch-grok/skills/* ~/.grok/skills/
```

Same three `test -f` checks as C, under `~/.grok/skills/`.

Copy `stubs/agents/arch-orchestrator.md` only when you want a multi-skill architecture pass. It is still a stub coordinator, and no install path ships it.

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

- [ ] `grok plugin list` shows `libre-arch-grok` (or the three skill files exist at the copy path you chose)
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
