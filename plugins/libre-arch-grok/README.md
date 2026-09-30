# libre-arch-grok

The Grok-native layer of [LibreArch-Grok-Build](https://github.com/HermeticOrmus/LibreArch-Grok-Build): three skills melted for Grok Build.

| Skill | Job |
|-------|-----|
| `adr-write` | Write ADRs that age well |
| `blast-radius-lite` | What breaks if this change ships |
| `hexagonal-ports` | Ports and adapters; inward dependencies |

## Install

```bash
grok plugin marketplace add HermeticOrmus/LibreArch-Grok-Build
grok plugin install libre-arch-grok@LibreArch-Grok-Build
```

The same marketplace offers every LibreArch-Claude-Code plugin, pinned by commit.

The stubs (`ddd-bounded-context`, `system-design-lite`, `saga-compensation`, `caching-strategy`, `migration-strangler`, `resilience-patterns`) and the stub orchestrator are not part of this plugin. They live in [`stubs/`](https://github.com/HermeticOrmus/LibreArch-Grok-Build/tree/main/stubs), and each names the pack plugin with the real depth. Honest table: [docs/DEPTH_MATRIX.md](https://github.com/HermeticOrmus/LibreArch-Grok-Build/blob/main/docs/DEPTH_MATRIX.md).

Gold Hat: [GOLD_HAT.md](https://github.com/HermeticOrmus/LibreArch-Grok-Build/blob/main/GOLD_HAT.md)
