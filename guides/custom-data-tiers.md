# Custom Data: Levels & Tiers

Every workspace eventually needs to store or reach data that doesn't fit Portablemind's built-in models — a domain object of your own, or records that already live in a system you run. There are two ways to do that today, and they suit different situations. Neither requires deploying any infrastructure of your own; the difference is *where your data lives*.

| | Tier 1 — Custom Objects | Tier 2 — Your Own Backend |
| --- | --- | --- |
| Where the data lives | Stored in Portablemind | Stays in your system |
| Best for | New object types you don't have anywhere else | Data that already exists elsewhere, or that must stay under your control |
| Set up by | Administration → Custom Data → Custom Objects (or by an agent, or the API) | Writing a Dynamic Function, or configuring a webhook |

## Tier 1 — Custom Objects (DynamicModel)

Use this when you want to track something Portablemind has no built-in model for — a piece of equipment, a competitor, a lease, a claim, whatever your business needs — and you're fine with it living in your workspace like everything else.

A custom object is a **type** you name — `Engine`, `Competitor`, `Lease` — plus the fields its records carry. Three things make this more than a generic blob:

- **Typed fields, defined per type** — each type has its own field list, with real types (text, number, date, select, checkbox, and more). An `Engine` can carry Torque and Max RPM while a `Pump` carries Flow Rate; they're validated independently. This is the same field editor used for custom fields on Tasks, Projects, and Tickets.
- **Only defined fields are accepted** — by default, saving a record with a field name the type doesn't define is rejected, and the error tells you which names are valid. This matters most when an AI agent is writing the data: without it, a mistyped field name is stored silently and nothing ever reads it. You can turn it off per type if you want a deliberately freeform record.
- **Associations** — custom objects can be linked to each other, or to any other record in your workspace (a Task, a Project, a Party), with a label you choose (`"related_to"`, `"blocks"`, `"parent_of"`, ...). This is how you build real relationships between custom objects instead of duplicating data into a single flat record.

No migration or deploy is needed to add a new type or a new field — it takes effect immediately.

### Defining a type

Go to **Administration → Custom Data → Custom Objects**.

1. **New Type**, and give it a name — "Engine". Portablemind derives an identifier (`engine`) from it; that's the name the API and your agents use.
2. With the type selected, add its fields: a label, a type, and whether it's required. Select fields take a list of choices. Changes save as you make them.
3. **Only allow defined fields** is on by default. Leave it on unless you specifically want a freeform record.

### Asking an agent to do it

Agents can define types and write records themselves — useful when you're capturing something on the fly and don't want to stop and design a schema first:

> "Create a custom object type called Engine with torque in Nm, max RPM, and fuel type (petrol or diesel). Then add the M20B25: 222 Nm, 6500 RPM, petrol."

An agent can also read back what exists — "what custom object types do we have, and what fields does Engine carry?" — before writing, so it uses your field names rather than inventing its own.

### Through the API

Types are `/api/v1/dynamic_model_types` (standard CRUD; a type's `field_definitions` is just an attribute, so defining fields is an ordinary update). Records are `/api/v1/dynamic_models`, where `dynamic_model_type` names the type and `custom_fields` carries the values. Links between them are `/api/v1/dynamic_model_associations`.

## Tier 2 — Your Own Backend (Dynamic Functions + Webhooks)

Use this when the data already lives somewhere else — your own database, a CRM, an accounting system — or when you'd rather keep it there than copy it into Portablemind. Portablemind doesn't store the data; it talks to your system instead.

There are two directions this goes:

- **Pull** — a [Dynamic Function](dynamic-functions.md) is your own serverless JavaScript, running in your workspace, that can call out to any external API (`fetch`, with OAuth handled for you via a Shared Configuration). Trigger it manually, from the API, on a schedule, or on a platform event (a callback when a record changes) — it reads from or writes to your system on your behalf.
- **Push** — an outbound webhook does the opposite: when something happens in Portablemind (today, a new message in a conversation), we POST it to a URL you configure, signed with HMAC-SHA256 so you can verify it came from us. This is how you keep your own system in sync without polling.

The two compose: a Dynamic Function can pull fresh data in on a schedule, while an outbound webhook pushes activity out in real time.

**When to prefer this over Tier 1:** your data is sensitive and you'd rather it not leave your infrastructure at all; it already exists in a system of record you're not going to replace; or you need custom logic (validation, transformation, side effects in another system) rather than just storage.

**How to use it:** see the [Dynamic Functions](dynamic-functions.md) guide for writing pull-side logic, OAuth, schedules, and callbacks. Outbound webhooks are configured per conversation — ask an admin or your integration contact to set one up with the destination URL you want to receive events at, and hold onto the signing secret shown at creation time (it isn't shown again).

## Choosing between them

Start with Tier 1 if you're not sure — it's the lower-friction option and works well for anything that's genuinely new data. Reach for Tier 2 only when the data has to stay outside Portablemind, or when keeping it in sync with a system you already run matters more than having it live natively alongside your Tasks, Projects, and Tickets.
