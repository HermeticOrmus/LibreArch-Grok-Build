# Changelog

## [1.0.0] - 2026-09-30

The Grok edition: one marketplace add brings the Grok-native skills plus the LibreArch pack, pinned by commit. Every crack this release found and sealed is in [LEDGER.md](./LEDGER.md).

### Added

- `plugins/libre-arch-grok/`: the three melted skills (`adr-write`, `blast-radius-lite`, `hexagonal-ports`) as an installable Grok plugin with `.grok-plugin/plugin.json` (version 1.0.0).
- `.grok-plugin/marketplace.json` (`libre-arch-grok`): the Grok-native plugin, then all 21 LibreArch-Claude-Code plugins as remote entries pinned to commit `c493984`. The optional `libre-arch-hooks` plugin installs too; its hooks are unverified inside a Grok session.
- `scripts/pin-pack.sh`: moves every pack entry to the pack's current main HEAD, adds new pack plugins, drops removed ones, and prints the diff. `--check` fails when the pack's plugin set changed.
- `.github/workflows/validate.yml`: validates the plugin, checks the dogfood copies, checks every pinned commit is reachable, checks the pack plugin names, and installs every entry in a clean `GROK_HOME`.
- Issue forms for feedback, routing misses and plugin proposals, with the `feedback`, `routing-miss` and `plugin-proposal` labels.
- `LEDGER.md`, the kintsugi ledger: 9 cracks sealed, 3 open.

### Changed

- The melted skills moved from `skills/` to `plugins/libre-arch-grok/skills/`. The stubs moved to `stubs/skills/` and the orchestrator from `AGENTS/` to `stubs/agents/`; none of them install. Each stub names the pack plugin that holds the real depth, and its description starts "Stub cue".
- Install is `grok plugin marketplace add HermeticOrmus/LibreArch-Grok-Build`, then `grok plugin install <plugin>@LibreArch-Grok-Build`. README, QUICK_START, AGENTS, CONTRIBUTING, DEPTH_MATRIX and MELT_RULES follow the new layout.
- README header follows the Ormus GitHub standard; the Depth table counts what installs.
- `.grok/skills/` stays as the dogfood copy of the plugin skills and the stubs, and `.grok/plugins/librearch-core/` stays as the dogfood copy of the stub orchestrator. CI keeps both in sync.
- What a 0.1.0 user must change: delete the skill folders you copied from `skills/` (the stubs among them are cues, not skills), then install through the marketplace. If you installed the repo root directly, uninstall that plugin; the root holds no skills now.

### Fixed

- Nothing beyond the layout: the v0 links in this repo already resolved.

## [0.1.0] — 2026-09-20

### Changed

- Melted `skills/adr-write/SKILL.md` and `skills/hexagonal-ports/SKILL.md` into usable Grok skills (when-to-use, steps, checks, examples, output shape).
- Added melted `skills/blast-radius-lite/SKILL.md` (Grok-native change-reach; no Claude plugin to clone).
- Dogfood copies under `.grok/skills/` match `skills/`.
- Rewrote [QUICK_START.md](./QUICK_START.md) for a clean-machine install (<5 min) with paths that exist in this repo.
- Updated [docs/DEPTH_MATRIX.md](./docs/DEPTH_MATRIX.md): 3 melted (L3–L4), 6 stub skills, 1 stub agent. No Claude inventory counts.
- Suite footers on README, QUICK_START, and AGENTS.md now link Reality OS plus the sibling Libre*-Grok-Build packs.

## [0.0.1] — 2026-09-19

### Added

- Public scaffold for LibreArch-Grok-Build (v0 stubs).
- Stub SKILL.md for first skills + suite orchestrator agent.
- README, LICENSE (MIT), GOLD_HAT, QUICK_START, CONTRIBUTING, SECURITY.
- Depth matrix + melt rules docs.

### Notes

- Honest stubs — not fake upstream depth counts. Melt next.
