---
name: adr-write
description: Write Architecture Decision Records that age well. Use when a significant, hard-to-reverse choice needs context, alternatives, consequences, and a status that future engineers can trust.
---

# Adr Write

Write Architecture Decision Records that age well. An ADR is a dated, owned record of a *choice* and the *why* — not a design essay, not a ticket dump, not a retrospective justification.

Gold Hat: teach the decision so the next engineer can apply it without you. A record that only names the winner extracts; a record that names rejected options and what you accepted in trade empowers.

## When to use

- A choice is significant (store, bus, ID format, public API shape, consistency model, auth boundary)
- Reversing it would take more than a quiet afternoon
- You are about to supersede, reject, or deprecate an older ADR
- Onboarding needs the history, not folklore
- A fitness check should point at a named decision

Do not use this skill for implementation notes, sprint logs, or "we already shipped it, write something." Write during the decision. After the fact, mark **reconstructed** and say what you no longer know.

Hand off change reach to `blast-radius-lite` (melted). Hand off dependency direction to `hexagonal-ports` (melted). Context seams stay with `ddd-bounded-context` (still a stub) — call it; do not invent its depth.

## Operating steps

1. **Name the problem, not the product.** One sentence: who is stuck, what constraint is real, what must be true after. If you cannot name the problem without naming a vendor, stop.
2. **Write a Y-statement first.** If the "accepting" clause is vague, the decision is not ready. Do not paper over it with adjectives.
3. **List at least two real alternatives** plus status quo. One option is a decree. Rejected ADRs stay in the log.
4. **Pick a format that matches scope.** Compact Nygard for a clear internal choice. MADR-shaped body (drivers, options, consequences, reversibility) when the decision will outlive the current team.
5. **Record consequences and reversibility in time**, not vibes. "Hard (months)" or "Easy (hours)" plus *what* would have to move.
6. **Set status + date + owners.** Link code and the ADR it supersedes. Point a fitness check at the rule when the rule is enforceable.
7. **Teach one reusable sentence.** Why this, in language the next reviewer can reuse.

Never embed secrets, connection strings, or real credentials in an ADR or example.

## Y-statement (readiness test)

```
In the context of [concrete situation + honest numbers],
facing [the force that makes the status quo fail],
we decided [choice],
to achieve [measurable outcome],
accepting [specific cost, risk, or constraint].
```

If you cannot complete **accepting** with a cost someone could disagree with, you are still exploring. Keep exploring. Do not mint an ADR.

## Status lifecycle

| Status | Meaning |
|--------|---------|
| Proposed | Options are real; no one should implement yet |
| Accepted | The choice is in force. Code and reviews treat it as current |
| Deprecated | Still true historically; do not start new work on it |
| Superseded | Replaced by a named later ADR. Update **both** files |
| Rejected | We considered it and said no. Keep the record so the debate does not restart |

Supersession is two edits: the old ADR points forward; the new ADR points back. A one-sided link is how stale ADRs survive.

## Format — compact Nygard

Use when the decision space is already clear:

```markdown
# ADR-0031: Emit JSON structured logs in every service

Status: Accepted
Date: 2026-09-20
Deciders: @platform-lead, @observability

## Context
Twelve services log in different text formats. Cross-service search needs a regex per service. Trace correlation is manual.

## Decision
Every service emits JSON logs with required fields: timestamp (ISO 8601), level, service, version, trace_id, span_id, message. Extra context is top-level fields, not a blob string.

## Consequences
- Positive: one schema; facets work without per-service parsers; traces join on ids.
- Negative: raw terminal output needs `jq` or a viewer; existing services need a migration (estimate per service, do not invent a fleet-wide week count).

## Reversibility
Medium (weeks) — log shipper rules and dashboards assume the schema.
```

## Format — MADR-shaped (larger scope)

Add **Decision drivers**, **Considered options** (each with why-not), **Positive / negative consequences**, **Reversibility**, and **Links** (supersedes, RFC, code paths). Title in imperative mood: "Use X for Y" or "Reject X for Y".

## Measurable checks

| Check | Pass | Fail |
|-------|------|------|
| Problem | Readable without naming the winner | "Use Postgres" is the context |
| Alternatives | ≥2 real options + status quo, each rejected for a reason | One option, or "others exist" with no why-not |
| Accepting clause | Concrete cost (time, risk, leak, ops) | "Some complexity" / "tradeoffs" |
| Consequences | Split + and −, both specific | Only upsides |
| Reversibility | Hours / weeks / months + what moves | "We can change later" |
| Status | Dated, owned, linked if superseded | "Accepted" forever, no date |
| Secrets | None | Tokens, passwords, private URLs |

## Worked example — ID format

Job: primary keys on a high-write orders table. Force: random UUID v4 fragments a B-tree; inserts at tens of thousands of rows per day already show page-split pain. Do not invent a row count you did not measure — if the number is inferred, say **inferred**.

Y-statement:

```
In the context of PostgreSQL primary keys on write-heavy order rows,
facing B-tree fragmentation from random UUID v4 inserts,
we decided to adopt UUID v7 (RFC 9562),
to achieve sequential write locality and cursor pagination on `id`,
accepting that the high bits encode approximate creation time and that
existing v4 rows need a migration, not a silent rewrite.
```

ADR body (abridged):

```markdown
# ADR-0023: Use UUID v7 for entity identifiers

Status: Accepted
Date: 2026-09-20
Deciders: @arch, @backend-lead
Supersedes: ADR-0012 (UUID v4 for entity identifiers)

## Context and problem
UUID v4 primary keys insert in random order. B-tree page splits and cache misses grow with write volume. Cursor pagination on `id` is awkward.

## Decision drivers
- Insert locality on orders / events
- Opaque IDs (no sequential business leak)
- No coordination service
- Sortable IDs for `WHERE id > :cursor`

## Considered options
1. UUID v7 — time-ordered, random suffix, IETF standard
2. ULID — similar order, non-RFC encoding
3. Snowflake — needs a coordination story this team does not have
4. BIGSERIAL — sequential, enumerable, cheap
5. Status quo: UUID v4 — random, fragments indexes

## Decision
Chosen: UUID v7. Time-ordered writes, opaque low bits, no coordinator, RFC 9562.

## Consequences
- Positive: fewer page splits; cursor pagination is `ORDER BY id`; standard libraries exist
- Negative: v4 data needs a planned migration; created-at leaks in the high bits — do not use these IDs where creation time is sensitive

## Reversibility
Hard (months) — every FK and every client that persisted an id.

## Links
- Supersedes: ADR-0012
- Code: `src/shared/id-generator.ts` (comment the ADR id there)
```

That is an ADR: problem, options, accepting clause, reversibility. Not "we use UUIDs."

## Anti-patterns

| Anti-pattern | Why it fails | Fix |
|--------------|--------------|-----|
| Stale ADR | Status still Accepted after the system moved | Review on replace; supersede both files |
| Decision without context | Future engineers cannot replay the force | Restate the problem without the product name |
| Written after the fact | Alternatives are fan-fiction | Mark **reconstructed**; leave unknowns blank |
| Decree (one option) | No decision occurred | Add status quo + one rejected path |
| Sprawl, no index | 200 files, no way in | `docs/decisions/README.md` grouped by concern |
| Secret in the record | Extracts and leaks | Redact; point at a secret store name only |

## Fitness functions (lite)

When the ADR states an enforceable rule ("domain does not import the web framework"), add a check in CI that fails the PR. Language-agnostic shape:

- Name the ADR in the test title
- Assert the dependency or naming rule
- Leave a code comment `ADR-00XX` at the seam

Do not paste a Java ArchUnit suite into a Python repo. The gold is *the rule is executable*, not a framework brand.

## Output shape

```markdown
## Job
[who is deciding / what force / primary outcome]

## Y-statement
[context / facing / decided / to achieve / accepting]

## ADR
[Nygard or MADR-shaped draft, including status, date, owners]

## Alternatives rejected
- [option] — [why not]
- [status quo] — [why not now]

## Reversibility
[hours | weeks | months] — [what would move]

## Blast radius
[one line + pointer to blast-radius-lite]

## Teach
[one reusable sentence]

## Leftovers
- [stub skill] — [what you did not pretend to finish]
```

If the decision is not ready, output the Y-statement gaps and stop. Invented alternatives and fake dates are not allowed.

## Quality bar

A pass is done when a stranger can apply the choice, name what was rejected, and estimate reversal cost. Refuse vibe-only ADRs ("use the modern stack"). Translate them through this skill or drop them.

## Suite

Doctrine: [grok-build-reality-os](https://github.com/HermeticOrmus/grok-build-reality-os). Gold Hat: [GOLD_HAT.md](https://github.com/HermeticOrmus/LibreArch-Grok-Build/blob/main/GOLD_HAT.md). Sibling Libre*-Grok-Build packs: [README suite footer](https://github.com/HermeticOrmus/LibreArch-Grok-Build/blob/main/README.md).
