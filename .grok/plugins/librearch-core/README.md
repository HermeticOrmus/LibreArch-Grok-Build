# librearch-core (v0 plugin stub, kept as a dogfood copy)

This was the v0 plugin bundle. It had no manifest and no skills, so it bundled nothing: Grok saw it only as a project plugin with one agent, the stub orchestrator. It stays as the dogfood copy of `stubs/agents/arch-orchestrator.md` (the two files must match; CI checks it).

The installable plugin is now [`plugins/libre-arch-grok/`](https://github.com/HermeticOrmus/LibreArch-Grok-Build/tree/main/plugins/libre-arch-grok), with its own manifest. Install it with `grok plugin marketplace add HermeticOrmus/LibreArch-Grok-Build` and `grok plugin install libre-arch-grok@LibreArch-Grok-Build`.

The melted skills now live in that plugin's `skills/`; the stubs live in `stubs/skills/`. Dogfood copies of both: `.grok/skills/`. First-run install does not require this folder; see [QUICK_START.md](../../../QUICK_START.md).

Melted in this pack: `adr-write`, `blast-radius-lite`, `hexagonal-ports`. The rest remain stubs. Honest table: [docs/DEPTH_MATRIX.md](../../../docs/DEPTH_MATRIX.md).

## Suite

- Doctrine: [grok-build-reality-os](https://github.com/HermeticOrmus/grok-build-reality-os)
- Sibling packs: [README suite footer](../../../README.md)
