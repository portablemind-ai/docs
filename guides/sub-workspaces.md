# Enterprise Sub-workspaces

An Enterprise workspace can run **sub-workspaces** — separate workspaces for your clients, business units or engagements, owned by you and billed under one agreement. Each is a real workspace with its own members, data, agents and audit trail, and nothing leaks sideways between them.

This is the right model when **you** are running the environments. If instead you're collaborating with an organization that already has its own Portablemind workspace, see [Workspace Sharing](workspace-sharing.md); if you're bringing in an individual contractor or client, see [Guest Users](guest-users.md).

## Who can have them

- Sub-workspaces are an **Enterprise** feature.
- Only a workspace that sits directly with us can have them — a sub-workspace never has sub-workspaces of its own.
- A sub-workspace is always on one of the standard plans (Free through Business), never Enterprise itself.
- Your workspace needs an active **billing agreement** with us before you can create any.

You manage them from the **Tenants** page, using **New Tenant**.

## Bringing in the people who work inside them

The people in a sub-workspace are its own members, invited there — you have no back door into it, by
design. If you run your own app in front of these workspaces and register people from it, give each
of them three things: **External Member** (the baseline anyone from outside needs for the app to
load), **a role of your own scoped to their own records**, and the **section access** — Team Chat,
Files, Projects — you want them to have. [White-label and single sign-on](white-label.md) covers
this, including what to keep for your own staff.

## The billing agreement

Sub-workspaces are covered by an agreement between you and us rather than a self-service setting, so the terms match your contract. The agreement names two things:

| Term | What it controls |
|---|---|
| **Allowance** | How many sub-workspaces your agreement covers |
| **Contract tier** | The highest plan you can place a covered sub-workspace on. You can always choose a lower one |

While an agreement is in force, the Tenants page shows how many of your allowance are in use. Reach the allowance and **New Tenant** is disabled, with a note telling you to contact sales or support to add more. On Enterprise without an agreement yet, the page says so and offers a way to get in touch.

Creating a covered sub-workspace needs **no card** — it's billed under your agreement. Existing sub-workspaces are brought under a new agreement automatically, oldest first, until the allowance is full. Sub-workspaces that already pay for themselves never use up your allowance.

> **Tip:** trying to put a sub-workspace on a plan above your contract tier is refused with a message saying so. Choose a lower plan, or talk to us about changing the tier.

## Billing, and what your customers see

You're billed by **count**, not by people: a standard agreement includes the first few sub-workspaces, then charges per additional one, with the rate dropping at volume. It arrives as a single line on your existing subscription and is prorated when the count changes. Negotiated agreements can use different bands — your agreement is what bills.

How you charge your own customers is entirely up to you and happens outside Portablemind. A sub-workspace you cover deliberately sees **no platform price** on its billing page — just a note that billing is covered by your agreement — and it has no plan-change or payment buttons, because you control its plan.

Everything else about a sub-workspace is normal: it has its own plan limits, its own fair-use guardrails and its own AI tokens, exactly as described in [Plans, Limits & Fair Use](plans-and-limits.md).

## What you can see of a sub-workspace: names and numbers, never content

You can measure every sub-workspace you run — enough to judge how each one is doing and to decide what to charge — without ever reading your customers' work.

**What you can see**, from the **Tenants** page and the API:

- How many **people**, **agents**, **projects**, **conversations**, **messages** and **files** it has, and how many **agent and orchestration runs** it has made.
- Whether it's **active**: when someone was last there, and how many people were active in the last 7 and 30 days.
- Its **AI spend** and **token balance**, broken down by model, by person, by agent, by orchestration and by conversation.
- What it spends on the **models you share** with it, and which of your **agent templates** it has installed and how they're performing.

The spend breakdown is labelled, so you'll see the **names** of a sub-workspace's conversations, people (with their email addresses), agents and orchestrations next to what each one cost. That's deliberate: a number you can't attach to anything isn't useful.

**What you can never see**: what was actually said or stored. There is no way for a parent workspace to read a sub-workspace's messages, files, documents, agent instructions or memories, its member list, or its audit trail — and no way to sign in to it as its parent. Only people the sub-workspace itself invites can get in.

> **Tip:** tell your customers exactly this when you onboard them — "we can see how much you use and what your conversations are called; we can't read them." It's the question they'll ask first.

## Funding a sub-workspace's AI tokens

A sub-workspace gets its plan's monthly AI-token allowance like any other workspace. When one needs more, you can **transfer tokens to it from your own workspace** — open **Tenants**, find the sub-workspace and use the transfer button on its row.

- The tokens come out of **your purchased balance** and land in theirs, one for one. Nothing is created, and the transfer is all-or-nothing: if your purchased balance doesn't cover it, nothing moves.
- **Your monthly plan allowance cannot be transferred.** It's use-it-or-lose-it and resets each month, so it stays with your workspace. Buy tokens first if you want to pass them on.
- Transferred tokens never expire in the sub-workspace — they sit beside its own monthly allowance, not inside it.
- Both workspaces see the move in their token history, with the other workspace named, so you can reconcile what you gave and they can see where it came from.
- **A transfer can't be undone from the app.** Check the amount and the workspace before you confirm. If you send tokens to the wrong place, open a support ticket and we'll correct it for you; a self-service way to reverse a transfer may come later.

A sub-workspace can also buy tokens for itself with its own card, from its own billing page — including one your agreement covers, and buying tokens doesn't change who pays for its plan. The one exception is a sub-workspace whose plan runs on **your card**: it can't buy tokens itself, so a transfer is how it gets more.

### Transferring tokens or sharing a model — pick one per client

These are two different answers to "how does this client's AI get paid for", and running both for the same sub-workspace is what makes it confusing:

| | You transfer tokens | You [share a model](#shared-models) down |
|---|---|---|
| Who pays the provider | us, out of the tokens you bought | you, on your own provider account |
| Whose balance moves | theirs — the tokens are genuinely theirs | nobody's; no AI tokens are involved |
| Your control afterwards | none; they spend it as they like | a monthly spend cap per sub-workspace, and you can withdraw the share |
| If they leave you | they keep the tokens | the model disappears and they fall back to their own |

Both are legitimate. Pick the one that matches what you're selling — an allowance you hand over, or capacity you keep control of — and tell the client which one they're on.

**Whichever you choose, the sub-workspace can see it.** Every row in their AI Studio → Models list carries a **Who pays** label: *Uses your AI tokens* (a Portablemind model, metered against their balance), *Paid by — your workspace’s name* (a model you shared down, on your provider account), or *Your own provider key*. If a sub-workspace works entirely on a model you shared down, the tokens you transferred will simply sit there unspent — that's correct, not a fault.

## Sharing agents and models downward

### Agent templates

Train an agent once in the parent workspace — instructions, persona, memories, runbooks, skills — and publish it as a **versioned template** your sub-workspaces can install. Find it under **AI Studio → Agents & Skills → Agent Templates**, and publish from an agent's menu with **Save as template**.

- You choose who gets it: private, all sub-workspaces, or selected ones.
- Installing creates the sub-workspace's **own copy**. It's theirs from that moment on.
- Installation asks for consent and lists what the template brings: tools, resources, code, permissions, schedules.
- Anything that looks like a credential is stripped when a template is saved, and listed so the installer knows what to configure.
- A new version is opt-in — or automatic, if that workspace's admin turns it on. Either way, an upgrade **keeps what the installed agent has learned** and only replaces what the template provided.

See [Building AI Agents](agents.md) for what goes into an agent in the first place.

### Shared models

You can share an AI model you've configured down to your sub-workspaces, so their work runs on your provider account:

- Sub-workspaces never see your API key.
- You can set an optional **monthly spend cap** per sub-workspace.
- Withdraw the share and those workspaces simply move back to their own model.

[Setting Up AI Models](ai-setup.md) covers configuring the models themselves.

### Branding and single sign-on

White-label — your logo, colours, emails and sign-in from your own app — is part of Enterprise, and your sub-workspaces get it **included with your plan**, on whatever plan they're on. Each one has its own switch, its own branding and its own sign-on key.

You can set it up for a sub-workspace from the **Tenants** page, with the **White-label & single sign-on** button on its row, or its own admins can do it from **Administration → Branding**. See [White-label Branding & Single Sign-on](white-label.md).

Portablemind support can also switch white-label on or off for a sub-workspace if you ask — the switch only. Sign-on keys are created by you or by the sub-workspace's own admins, never by us.

## If you stop covering a sub-workspace

This happens when you leave Enterprise, end your agreement, or lower your allowance below the number of sub-workspaces you have. Nobody loses their workspace or their data.

A sub-workspace that **already pays for itself** simply becomes independent straight away, and its admins are told.

A sub-workspace that was relying on you gets a **14-day grace period**:

1. **Everything keeps working**, and the grace period is free — you stop being billed for it immediately. A banner tells that workspace's admins the date they need to set up billing by, and they get an email when the grace begins.
2. **One reminder** follows, a few days before the deadline.
3. **If the deadline passes**, the workspace enters **billing-only mode**: it's locked except for billing, and its agents are paused. Nothing is deleted.
4. **Taking it over** — an admin of that workspace chooses a plan and supplies their own card. Access returns immediately and the paused agents resume. We never reuse your card for this.

Change your mind during the grace period — return to Enterprise, or reactivate the agreement — and the whole thing is cancelled automatically, with nothing lost.

> **Tip:** lowering your allowance starts this process for the sub-workspaces past the new number, so check the coverage figures on the Tenants page before saving.
