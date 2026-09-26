# Plans, Limits & Fair Use

Every Portablemind workspace runs on a plan, and every plan sets how much room that workspace has. This page explains the three different things that can stop an action — a **published plan limit**, a **fair-use guardrail**, or an empty **AI token balance** — where to see each one, and what the warnings mean before anything is refused.

The short version: limits are about **capacity**, never about people. There is no per-seat pricing on any plan, for humans or for agents. Adding teammates never costs more.

## Where to see your usage

Go to **Administration → Billing → Subscription & Account**. Under your current plan you'll find a **Usage & Limits** card:

| Row | What it shows |
|---|---|
| Storage | Live document storage, e.g. `412.0 MB / 1 GB` |
| Projects | Projects used, against your plan's cap |
| Conversations | Conversations used, against the cap |
| Tasks | Tasks used, against the cap |
| Agents | Agents you've created, against the cap |

Each row has a bar that turns amber past 80% and red once you're at the limit. A limit your plan doesn't cap shows the count followed by **Unlimited**, with no bar. If your plan caps nothing at all, the card simply says your plan has no usage limits.

These are the **published limits** — the ones a plan advertises. Storage is measured live, so deleting files frees the space immediately.

## Fair-use guardrails

Behind the published limits sits a second, deliberately generous set of **fair-use guardrails** — things like messages per month, scheduled-function runs per day, image and video generation, agent emails, and how many memories or custom tools a workspace keeps.

They aren't sold as plan features and they don't appear on the Usage & Limits card, because they're set well above what normal heavy use of a plan looks like. They exist to keep the platform fast and predictable for everyone, and to stop a runaway agent quietly consuming a shared resource.

You only hear about one when you're close to it:

- **At 80%** — workspace admins get a notice, and a banner appears naming the guardrail you're approaching. You can dismiss it; if you then reach the limit, it returns with firmer wording.
- **At 100%** — the action is refused, and a dialog names the limit that stopped it.

> **Tip:** if a fair-use guardrail is getting in your way during legitimate work, contact support. They can be raised — that's the point of calling them guardrails rather than plan limits.

## When something is refused

Whatever you were doing — posting a message, uploading a file, creating a project, launching an agent — the refusal appears as one dialog, titled by the kind of limit involved:

| Dialog | What it means |
|---|---|
| **Plan limit reached** | A published plan limit — projects, conversations, tasks or agents |
| **Storage limit reached** | Document storage is full. Delete files you no longer need, or move to a larger plan |
| **Fair-use limit reached** | A fair-use guardrail. You can upgrade for more room, or contact support |
| **Monthly message limit reached** | The monthly message guardrail. Messages resume at the start of next month |
| **Not included in your plan** | The feature isn't part of this plan at all — see below |
| **Out of AI tokens** | Your AI token balance is empty. This is a balance, not a limit |
| **Usage limit reached** | Something was rate-limited rather than capped — you're going too fast. Wait a moment and retry |

Dismissing a dialog suppresses that same limit briefly, so a background refresh can't reopen it every few seconds.

### "Not included in your plan"

Some features are switched off on lower plans by setting their limit to zero — coding sessions and video generation on Free, outbound calls and video meetings below Professional, and so on. When you try one you don't get "limit reached", because you never had an allowance to use up: you get **Not included in your plan**, with an upgrade prompt.

A brand-new workspace is therefore never told it has used up something it never had.

### Messages are messages, not tokens

If you reach the monthly message guardrail, every message says exactly that — and offers an upgrade. It will never tell you that you're out of AI tokens, and never try to sell you tokens. The two are separate things: a message guardrail is about volume, while **Out of AI tokens** means an actual empty balance. See [AI Memory](memory.md) and [Setting Up AI Models](ai-setup.md) for how AI usage is metered.

## Traffic: what's metered and what never is

**Using Portablemind is never rate-limited or metered.** Signing in through the web or mobile app gives you an ordinary session, and nothing you do in it counts against an API quota or a per-minute request limit — including the pages that refresh in the background.

What *is* counted is **external traffic**:

- **API keys and integration tokens.** Requests made with an API key, or with a token issued for a third-party integration, count toward a daily quota of external API requests and a per-minute ceiling. Cross the per-minute ceiling and the API answers with a rate-limit error and a `Retry-After` header.
- **MCP has a flood guard, not a quota.** Connecting an MCP client — Claude, ChatGPT connectors, your own tooling — doesn't consume your API quota at all. MCP is limited only by a generous per-minute limit and a cap on how many requests can be in flight at once, to stop a runaway client. Cross it and your client receives a standard JSON-RPC error with a retry hint, which MCP clients back off on automatically. See [Connecting AI Apps (MCP)](mcp-connections.md).

## AI tokens

AI usage draws from a token balance rather than a limit. Anything that costs us provider money — chats, agent turns, images and video on our keys, background summaries — draws from it, and each plan includes a monthly allowance. You can buy more at any time.

Bring your own provider key and that usage costs no tokens at all: the call goes to your account, not ours. [Setting Up AI Models](ai-setup.md) covers connecting your own provider, and [Connecting AWS Bedrock](bedrock-setup.md) and [Connecting Google Vertex AI](vertex-setup.md) cover running models through your own cloud billing.

> **Tip:** a turn that begins with tokens left may run slightly past zero rather than stopping mid-answer. The overrun is carried as a small debt and cleared by your next top-up or renewal.

## Meeting minutes

[Video meetings](meet.md) have their own monthly allowance, counted in **participant-minutes** (one person connected for one minute): 1,000 on Professional, 5,000 on Business and 20,000 on Enterprise. Free and Starter don't include meetings, and Meet appears only on plans that do (for people with Meet access, in a workspace with a video account set up).

Meetings that run on the platform's Twilio account also draw on your token balance: the tokens worth 1¢ (US) per participant-minute, at the same conversion as AI usage. Connect your own Twilio account in the [Communications Hub](communications-hub.md#twilio-video-setup) and meetings use no tokens — only the minute allowance. A running meeting is ended when the minutes — or, on the platform's account, the tokens — run out; this is checked every few minutes. [Meeting minutes and billing](meet.md#meeting-minutes-and-billing) has the details, and what each message means when a meeting can't start or is ended.

## Running many workspaces

If you run separate workspaces for clients or business units, an Enterprise workspace can own them as sub-workspaces under one agreement — each with its own limits, data and audit trail. See [Enterprise Sub-workspaces](sub-workspaces.md).
