# AI Memory

Portablemind gives your AI a long-term memory. Alongside the conversation history, it keeps short notes — facts, preferences, decisions, lessons — and brings the relevant ones back in later conversations, with other agents, and in scheduled runs. An assistant with memory knows how you like reports written, which approach your team chose last quarter and why, and what fixed a problem the last time it came up, so each conversation builds on the last instead of starting from scratch.

This guide covers what a memory is, who can read it, how you see and correct what is kept about you, and what happens in the background.

## What a memory is

A memory is one short note with a title, a body and a type. Agents are steered to five types:

| Type | What it captures |
|---|---|
| **Fact** | Something true about the work, the people or the world (the default) |
| **Preference** | How someone likes things done |
| **Decision** | A choice that was made, and why |
| **Learning** | A lesson, pattern or fix worth reusing |
| **Context** | Background that explains a situation |

A few other types exist (for example, the insights the system derives on its own) and still work; you'll see them in the memory views when they are used.

Each memory also has an **importance** (0–1) set by whoever saved it. A memory used often and recently ranks a little higher, and one nobody has used for months ranks a little lower, but nothing in the background rewrites the importance you or an agent gave it.

Memories are kept short on purpose: a recalled memory is added to the prompt as it is, so a long one costs tokens on every turn it matches.

## Shared and private memories

Every memory is either **shared** with your workspace or **private**.

- **Shared** memories are workspace knowledge. Any person or agent in your workspace may recall them. Nothing ever crosses into another workspace.
- **Private** memories have exactly one owner, and only that owner can recall them:
  - **you** — a memory saved about you, readable only in your own conversations;
  - **a conversation** — a memory saved in a private conversation belongs to that conversation, so only the people who can read that conversation get it back, and only inside it;
  - **a private agent** — an agent set to keep a private memory sees only its own memories, and nobody else's.

A save is private automatically when you ask for it, when the agent is private, or when it happens in a private conversation. The exception is a group DM (three or more members): it is a shared working space, so what is saved there is shared with the workspace. Everything else is shared.

Private memories are encrypted at rest. A shared memory is checked for secrets (passwords, keys and similar) before it is saved, and refused if it contains one.

## "About you" and the other always-on notes

On top of individual memories, Portablemind keeps three short notes that are always in front of the AI — no search needed:

- **About this workspace** — standing facts about your organization, kept by workspace administrators.
- **About you** — who you are, how you like to work, what to assume. It is added only to conversations that are **private to you** (for example your DM with an agent), never to a channel other people read.
- **About me** — each agent's own note about its job, which the agent maintains itself.

Each note is limited to 1,500 characters and is versioned: every change keeps the previous text. None of these notes is added to a conversation that anyone outside your workspace (a guest, a customer, a partner organization) can read.

**How "About you" stays up to date.** When background capture is on for your workspace and in write mode (see [How memories are created](#how-memories-are-created)), and it learns something about you — a preference, your role, how you like to work — in a conversation only you can read, such as your DM with an agent, Portablemind folds it into your note. It is meant to hold only lasting things about you, so it leaves out the status of projects, tasks and releases, and things about colleagues, customers or agents. A conversation that taught nothing new about you leaves the note as it is. The note is kept short rather than cut off at the limit.

Once you edit the note yourself in **Settings → Memory**, your text is kept word for word: new things learnt about you are only added as short "Recently learned: …" lines, and only while there is room.

## Settings → Memory

**Settings → Memory** shows what Portablemind remembers about you and lets you change it.

- **About you** — edit your always-on note. Each save becomes a new version; the previous text is kept.
- **Memory controls**
  - **Pause memory** — while paused, nothing new is captured from your messages and your private memories are left out of replies. You can still ask an agent to remember something.
  - **Excluded topics** — short phrases such as "my salary" or "health". A memory touching one of them is never saved, and existing memories about it are left out of your conversations.
- **Your memories**, in two views:
  - **About you** — what is about you: what you asked to have remembered, what was learnt about you, and what was learnt in conversations only you can read, such as your DMs with agents. Nothing shared with the workspace is listed here.
  - **Everything that can reach your prompts** — all of the above plus the memories shared with your workspace: everything an agent may recall when it answers you. A memory kept in a private room you share with other people is recalled only inside that room, so it isn't listed.

  You can search, filter to private memories, group by conversation, agent or type, and show what was forgotten in the last 30 days. A pin marks memories saved **on request** (by you or an agent), as opposed to captured automatically.

**Editing and erasing.** The edit and delete buttons appear only on memories that are yours to change: your own, and those learnt in a conversation you read alone. Workspace memories you didn't write are read-only here — ask an administrator if one is wrong. Editing the title or text creates a **new version**: the old one is kept as history and is no longer recalled. Changing only importance or tags edits the memory in place. A forgotten memory can't be edited, only erased. Deleting from this page erases the memory for good.

This page only ever shows memories you can already read. You never see another person's private memories here — not even as an administrator.

**Sharing a private memory.** Only workspace administrators can share; members never see the button. There are two places to do it:

- **Settings → Memory** — your own private memories, such as one about you or one learnt in your DM with an agent.
- **AI Studio → Agents → an agent's Memories** — the private memories that agent keeps to itself. Only administrators who manage that agent see this.

**Share with workspace** appears only on a private memory you are allowed to change and to read. You are shown who will see it and must confirm. Once shared, every member of the workspace and every agent that reads shared memory can recall it; an agent's private memory becomes part of the workspace's shared memory rather than staying that agent's alone. The shared copy is a new version, the private one is kept as history, and the share is recorded on the workspace's audit trail. Anything that looks like a password, key or other secret is refused, and so is a memory that has already been replaced or forgotten. A shared memory can't be made private again, and editing a private memory never makes it shared — to take a shared memory back, erase it.

An agent's memories can also be reviewed and corrected from its **Memories** dialog in AI Studio's agent list.

## Corrections keep their history

Memories are not overwritten. When a fact changes — through an edit, an agent's correction, or background capture — the new version takes over and the old one is closed and kept, linked to its replacement. Recall only uses the current version, but an agent can still ask what was believed on a past date.

A memory that is **forgotten** (rather than replaced) is archived, not destroyed: it stops being recalled but can be restored. Only an explicit delete erases a memory permanently.

## How recall and search work

When you chat with the AI or an agent runs, the most relevant memories are found and added to the prompt automatically. Agents can also search memory themselves.

- **Words and meaning together.** A search matches the distinctive words of your question (in any form — "memories" matches "memory") and, when your workspace has embeddings switched on, memories that mean the same thing in different words. A memory that appears in both ranks highest.
- **A relevance floor.** Matches that are only weakly related are dropped, and very common words can't make a match on their own. A search returns fewer results rather than padding the list with near-misses.
- **Bounded.** Only the best matches travel with any one request, within a size limit; if more matched, the AI is told so and can fetch the rest. Nothing is removed from memory by this — it only limits what goes into a single prompt.
- **Optional re-ranking.** An administrator can name a low-cost model that re-orders the top results for relevance. It is off by default, has its own daily cost cap, and never sees private memories.

Recall always respects the shared/private rules above: the AI only ever recalls what the person or agent it is answering may read.

## The memory tools agents use

Every agent always has these tools, whatever else it is configured with. The AI Assistant has all of them except the last.

| Tool | What it does |
|---|---|
| **Store memory** | Save a new memory, with a title, text, type, importance and tags. |
| **Load memories** | Search memory (words and meaning), search by meaning only, or browse recent, important, by type, by conversation, by agent, or a memory's linked memories. Can answer "what did we know on this date". |
| **Update memory** | Correct a memory the agent saved. A new title or text makes a new version; importance and tags change in place. |
| **Forget memory** | Retire a memory the agent saved, or mark it as replaced by a newer one. Retired memories are kept as history. |
| **Link memories** | Connect two memories with a relationship (below). |
| **Update memory profile** | Rewrite the agent's own always-on "About me" note. |

An agent can only correct or retire memories it wrote itself. When it uses memories from the shared pool, it is told which ones are its own and which came from someone else, so it never claims another author's work as its own.

## Relationships between memories

Memories are linked into a graph. The system writes three kinds of link on its own:

| Relationship | Meaning |
|---|---|
| `related_to` | The two memories are about the same thing (the usual link) |
| `supersedes` | A newer version replaces an older one |
| `exemplifies` | A general insight and an example of it |

When an agent links two memories on purpose, it can also use a more specific type: `caused_by`, `leads_to`, `depends_on`, `references`, `spawns` or `validates`.

You can explore the graph under **AI Studio → Knowledge & Resources → Memories**, where each memory is a node colored by type and connected by its links, with a search that highlights matching memories. The **Memory Graph** widget shows your most recent memories on the home dashboard.

```recording
title: Explore your AI's memory
src: https://www.dsiloed.com/api/v1/public/llm_files/2101/raw?key=ac9adc7ee20de0b680611b800150d022
```

## How memories are created

**On purpose.** Most memories are saved deliberately — you ask an agent to remember something, or an agent saves a decision, fix or preference it judges worth keeping. You can always just say "remember that…".

**Background extraction (off by default).** A workspace administrator can turn on background capture. Every so often it reads recent conversations and picks out the facts, preferences, decisions and lessons worth keeping. It:

- is **off** until an administrator chooses a model for it, and is set per workspace, with a daily cost cap;
- starts in **report mode**: it works out what it would save, update or skip, and writes nothing, so an administrator can check its judgement first. It saves only once switched to write mode;
- never touches older history when first turned on — it only reads conversations from then on (looking back at most 14 days);
- **never rewrites or replaces a memory someone saved on purpose.** If it learns something newer, it adds a new memory and links it to the original instead;
- skips the messages of anyone who has paused memory, and anything touching their excluded topics;
- skips conversations that include anyone from outside your workspace;
- saves what it learns with the same privacy as the conversation it came from.

**Upkeep.** Each day the system links related memories and may write a short derived insight from a recurring pattern. Each week it merges near-duplicates and archives old, low-value memories that were captured automatically. Memories saved on purpose are never aged out this way, and memories an always-on note draws on are never archived as low-value.

**Lessons for agents (off by default).** An administrator can let Portablemind notice lessons that keep recurring in an agent's memories and **propose** adding them to the agent's "About me" note. A proposal changes nothing on its own: the agent's managers are notified, and it is applied only when someone who can edit the agent approves it.

## Privacy and isolation

Each workspace's memories are completely isolated — there is no access across workspaces, and every read goes through the same permission checks that protect the rest of your data. Within a workspace, private memories stay with their owner, and you control what is kept about you from **Settings → Memory**.

## Configuration

Administrators tune memory per workspace in the **Memory Management** configuration (Administration → Configuration Manager). Most teams only need the first row.

| Setting | What it controls | Default |
|---|---|---|
| Enable embeddings | Meaning-based search on or off | On for new workspaces |
| Retrieval relevance floors | How close a match must be before it is returned | Tuned defaults |
| Rerank model | Optional model that re-orders top search results | None (off) |
| Extraction model, mode and daily cost cap | Background extraction: which model, report or write, and the most it may spend a day | No model (off); report mode; 50¢/day |
| Procedural memory | Proposals of recurring lessons for agents | Off |
| Sensitive keywords | Extra words that keep a memory out of the shared pool | A short default list |

> **Note:** Meaning-based search needs an embedding model configured as part of [AI setup](ai-setup.md). Background extraction and reranking run on one of your configured models and count against their own daily caps.

For API-level details, see the [API guide](https://www.dsiloed.com/apps/apiguide/index.html).
