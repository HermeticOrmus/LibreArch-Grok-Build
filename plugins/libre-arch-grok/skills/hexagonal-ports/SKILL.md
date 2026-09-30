---
name: hexagonal-ports
description: Ports and adapters — keep the core free of frameworks and the dependency arrow pointing inward. Use when drawing use-case boundaries or reviewing where I/O leaked into the domain.
---

# Hexagonal Ports

Ports and adapters (Cockburn): the application core speaks only through ports. Adapters implement those ports at the edge. The dependency arrow points inward. That is what keeps the core testable.

Gold Hat: name the use case first, then teach why the framework stays outside. A hexagon diagram that the team cannot test extracts; a port they can fake in memory empowers.

## When to use

- A new service or a new use case needs a boundary before the first framework annotation
- Domain or application code imports HTTP, SQL, a cloud SDK, or a UI toolkit
- You need a test that does not boot a database or a web server
- An ADR is about "who may depend on whom"

Do not use this skill as a full DDD context map (`ddd-bounded-context` is still a stub) or a traffic-shift plan (`migration-strangler`, stub). After you name a port change, run `blast-radius-lite`. Record the dependency rule with `adr-write`.

## Operating steps

1. **Name the use cases.** Verbs the system performs for someone (`PlaceOrder`, `GetOrder`, `CancelOrder`). If you only have entity names, you do not have a hexagon yet.
2. **Draw inbound (driving) ports.** What the outside world *asks the core to do*. Usually one port per use case, or a small application API.
3. **Draw outbound (driven) ports.** What the core *needs from the world* (store, clock, bus, mailer). Interfaces owned by the core, not by the database.
4. **List adapters.** One adapter per technology: HTTP handler, Postgres, in-memory test double, fake clock. Adapters depend on ports; ports do not depend on adapters.
5. **Plan test doubles.** Every outbound port gets an in-memory (or otherwise fake) adapter used by core tests. If you cannot fake it, the port is too wide or leaks a vendor type.
6. **Teach one sentence.** Why this use case does not import the framework.

Stop if the only "port" is a framework controller talking to a framework repository. That is a layered app with extra nouns. Say so.

## Dependency rule

```
adapters (HTTP, SQL, UI, SDKs)
    → depend on →
application ports + use cases
    → depend on →
domain (entities, value objects, domain events)
```

Nothing in domain or application imports an adapter package, a web framework, or an ORM. Vendor types stop at the adapter. If a SQL row type appears in a use case, the port failed.

Inbound adapters call inbound ports. Outbound adapters implement outbound ports. Inbound adapters do **not** call outbound adapters directly.

## Measurable checks

| Check | Pass | Fail |
|-------|------|------|
| Use case named | Verb + actor | "the OrderService" with no job |
| Inbound port | Core API, no HTTP types | Handler signature is the use case |
| Outbound port | Core-owned interface, core types | Interface lives next to JPA/SQLAlchemy |
| Adapter list | One tech per adapter, implements a port | "infrastructure" bag of helpers |
| Dependency direction | Core tests import fakes, not the framework | Domain file imports Spring / Express / Prisma |
| Test double | In-memory adapter, same port | `@SpringBootTest` to prove a price rule |
| Vendor types | Mapped at the edge | `PrismaClient` in the use case |

## Worked example — PlaceOrder

Job: a shopper places an order. Primary action: accept a command, persist, emit a domain event.

Weak (framework through-line):

```ts
// handler talks to ORM; no port; price rule untested without Postgres
export async function postOrder(req: Request, db: PrismaClient) {
  const total = req.body.items.reduce((s, i) => s + i.price * i.qty, 0)
  return db.order.create({ data: { total, ...req.body } })
}
```

Stronger (ports owned by the core):

```ts
// application/ports/place-order.ts  (inbound)
export type PlaceOrder = (cmd: PlaceOrderCommand) => Promise<PlaceOrderResult>

// application/ports/orders.ts  (outbound)
export type OrdersPort = {
  get: (id: OrderId) => Promise<Order | null>
  save: (order: Order) => Promise<void>
}

// application/ports/clock.ts  (outbound)
export type ClockPort = { now: () => Date }

// application/place-order.ts  (use case — no HTTP, no Prisma)
export function createPlaceOrder(orders: OrdersPort, clock: ClockPort): PlaceOrder {
  return async (cmd) => {
    const order = Order.place(cmd, clock.now())
    await orders.save(order)
    return { orderId: order.id }
  }
}
```

Adapters (edge):

- Inbound: HTTP handler maps `Request` → `PlaceOrderCommand`, calls `PlaceOrder`, maps errors to status codes
- Outbound: `PgOrdersAdapter` implements `OrdersPort`; `MemoryOrdersAdapter` implements the same port in tests
- Outbound: `SystemClock` / `FixedClock`

Three concrete fixes if you only have the weak handler: (1) extract `PlaceOrder` as an inbound port, (2) put `save` on an `OrdersPort` owned by application, (3) write a core test with `MemoryOrdersAdapter` + `FixedClock` — then run `blast-radius-lite` on the new port and `adr-write` if the dependency rule is now a team law.

## Folder sketch (optional, not a religion)

```
src/domain/            # entities, value objects — no ports, no adapters
src/application/       # use cases + port types
src/adapters/http/
src/adapters/postgres/
src/adapters/memory/   # test doubles that implement outbound ports
```

Rename to match the repo. The gold is the arrow, not the folder names. Onion / Clean are the same arrow with different nouns — do not start a taxonomy war in a PR.

## Anti-patterns

| Anti-pattern | Why it fails | Fix |
|--------------|--------------|-----|
| Port in the adapter package | Core must import infrastructure to compile | Move the interface next to the use case |
| ORM types on the entity | Domain cannot run without the ORM | Map row ↔ entity in the adapter |
| Controller → repository | Use case never existed | Put a verb in the middle |
| One "UnitOfWork" god port | Every test double becomes a lie | Split ports by reason to change |
| Hexagon theater | Folders renamed, imports unchanged | Fail a dependency check or say it is not hexagonal yet |

## Output shape

```markdown
## Job
[actor / use case verb / primary action]

## Inbound ports
- [name] — [command / query]

## Outbound ports
- [name] — [what the core needs]

## Adapters
- [tech] — implements [port] — [prod | test]

## Dependency findings
- [pass|fail] — [file] — [import or leak]

## Test doubles
- [port] → [fake] — [what the core test proves]

## Fixes (≤3)
1. …
2. …
3. …

## Teach
[one reusable sentence]

## Leftovers
- blast-radius-lite — [port or adapter you changed]
- adr-write — [whether to record the rule]
- ddd-bounded-context (stub) — [seam you did not map]
```

If the core is already clean, say so. Invented ports for a script that has one function are not allowed.

## Quality bar

A pass is done when a stranger can implement an in-memory adapter and run the use case without a framework. Refuse "add a Service class" with no ports. Refuse Java-only dumps in a non-Java repo.

## Suite

Doctrine: [grok-build-reality-os](https://github.com/HermeticOrmus/grok-build-reality-os). Gold Hat: [GOLD_HAT.md](https://github.com/HermeticOrmus/LibreArch-Grok-Build/blob/main/GOLD_HAT.md). Sibling Libre*-Grok-Build packs: [README suite footer](https://github.com/HermeticOrmus/LibreArch-Grok-Build/blob/main/README.md).
