# Quick Start — LibreArch for Grok Build

> From zero to an architecture review cue in under 5 minutes.

## Prerequisites

- Grok Build installed and working
- A system or service boundary you own / are designing

## Install skills (repo-local)

```bash
git clone https://github.com/HermeticOrmus/LibreArch-Grok-Build.git
cd your-project
mkdir -p .grok/skills
cp -R /path/to/LibreArch-Grok-Build/skills/* .grok/skills/
```

Or user-global:

```bash
mkdir -p ~/.grok/skills
cp -R /path/to/LibreArch-Grok-Build/skills/* ~/.grok/skills/
```

## First-run teach cue

1. **ADR** — "Run adr-write for the decision you are about to make."
2. **DDD** — "Run ddd-bounded-context to find seams."
3. **Resilience** — "Run resilience-patterns for timeouts, retries, bulkheads."

## Hard rules

- Never embed secrets in prompts or examples.
- Honest stubs — melt depth next.
- Gold Hat: empower or extract?

## Smoke checklist

- [ ] Skills visible to Grok
- [ ] One skill run produces measurable output
- [ ] No secrets in output
