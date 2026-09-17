# AI Memory

Portablemind gives your AI a persistent, long-term memory. Unlike simple chat history, the memory system stores what your AI learns — facts, preferences, decisions, solutions — and recalls it semantically across sessions, conversations, and even different agents. The result is an AI that remembers your preferences, past decisions, and learned patterns, so every interaction builds on the last instead of starting from scratch.

Memory matters because it changes the character of your AI from a stateless tool into a knowledgeable collaborator. An assistant with memory knows how you like reports formatted, which approach your team chose last quarter and why, and which solution fixed a problem the last time it appeared. This dramatically improves the relevance and quality of AI responses, and it compounds: the longer your team works with Portablemind, the more useful its AI becomes.

## How memory works

Three capabilities work together to make memory more than a transcript archive:

### Semantic search

Memories are stored with vector embeddings, so recall works on **meaning, not keywords**. Asking "What does Ben like?" will surface a memory that says "Ben Koloski loves spaghetti" — no shared words required. When you chat with the AI or an agent runs a task, relevant memories are automatically retrieved and used as context for the response. Under the hood this uses an embedding model configured for your workspace; you don't interact with it directly.

Recall is **ranked and bounded**: the most relevant memories are included up to a size limit, and if more matched than fit, the AI is told so and can retrieve the rest on request. This keeps recall from quietly crowding out the conversation itself — memory is meant to add context to a turn, not dominate it. Nothing is dropped from the store; only what travels with any single request is limited.

### Graph relationships

Memories aren't stored as isolated notes — they're connected through **typed relationships**, building a knowledge graph of how facts, preferences, and insights relate to each other. When memories are linked, the system classifies the relationship semantically, so connections carry meaning instead of being a generic "related to":

| Relationship | Meaning |
|---|---|
| `caused_by` | Causal link (a bug caused by a configuration) |
| `leads_to` | Consequence (a decision leads to an implementation) |
| `contradicts` | Conflicting information |
| `references` | Cross-reference (an implementation references a design) |
| `spawns` | Parent-child generation (a feature spawns subtasks) |
| `supersedes` | Replacement (a new approach supersedes an old solution) |
| `validates` | Test or verification of another memory |
| `exemplifies` | A concrete example of a pattern |

Relationship classification runs in two modes: fast rule-based heuristics (zero cost, keyword-driven) and LLM-based analysis (high accuracy, applied selectively to important memories). The recommended hybrid approach combines both — typically fewer than 5% of relationships need the LLM, keeping costs negligible.

### Automatic consolidation

The memory system maintains itself with background processing — no manual curation required:

- **Memory consolidation** (daily): identifies patterns across related memories, creates relationships, and extracts derived insights — new knowledge synthesized from what's already stored.
- **Memory pruning** (weekly): cleans up low-importance memories and merges duplicates so the memory store stays sharp.
- **Agent learning** (daily): analyzes your agents' execution history to recognize patterns and improve their performance over time. See [Building AI Agents](agents.md) for how agents use their memory.

You can see all of this for yourself in the **Memories** section of AI Studio (under Knowledge & Resources in its navigation panel), which renders the memory store as an interactive graph — each node a memory, colored by type and connected by its relationships — with a search that highlights the memories matching your query. There's also a Memory Graph widget for the home dashboard that shows your most recent memories at a glance.

```recording
title: Explore your AI's memory
src: https://www.dsiloed.com/api/v1/public/llm_files/2101/raw?key=ac9adc7ee20de0b680611b800150d022
```

## Memory types

Every memory is classified by type, which helps the AI weigh and retrieve it appropriately:

| Type | What it captures |
|---|---|
| **Fact** | Specific facts, data points, or verified information |
| **Preference** | User preferences, settings, or choices |
| **Decision** | Important decisions made during conversations |
| **Insight** | Analysis, conclusions, or discovered patterns |
| **Context** | Background information or situational context |
| **Solution** | Technical solutions, fixes, or configurations |

## Privacy and isolation

Memory is secure by design. Each workspace's memories are completely isolated — there is no cross-tenant access, and retrieval is governed by the same capability-based access control that protects the rest of your data. This isolation is strong enough to support regulated use cases such as healthcare applications that must maintain compliance while remembering patient context.

## What memory unlocks

- **Personalized assistants** — the AI remembers your preferences, work patterns, and communication style across sessions, so interactions feel natural rather than repetitive.
- **Smarter development agents** — coding agents accumulate solutions, code patterns, and architectural decisions, improving consistency and quality over time.
- **Organizational knowledge** — customer insights, market observations, and strategic decisions build into a durable knowledge base your whole team's AI can draw on.

Memories are captured automatically as you work — in [chat conversations](ai-assistant.md) and as [agents](agents.md) complete their tasks — and recalled automatically whenever they're relevant. You don't need to tell the AI to remember or to look something up.

## Configuration

Memory behavior is tuned per workspace by an administrator through the workspace's memory management configuration, found in the Administration area's Configuration Manager. Most teams never need to change the defaults, but the tunable settings are:

| Setting | What it controls | Typical value |
|---|---|---|
| Enable embeddings | Turns semantic (meaning-based) search on or off | On |
| Similarity threshold | How closely a memory must match a query to be recalled (0.0–1.0) | 0.7 |
| Classification method | How relationship types are determined: heuristic rules, LLM analysis, or hybrid | Hybrid |
| Classification thresholds | Minimum similarity and importance scores before the LLM is used to classify a relationship | 0.9 / 0.8 |
| Max LLM calls per consolidation | Cost-control cap on LLM classification during each consolidation run | 50 |

> **Note:** Semantic search requires an embedding model to be configured for your workspace as part of [AI setup](ai-setup.md). Relationship classification can optionally use one of your configured chat models for higher accuracy.

For API-level details, see the [API guide](https://www.dsiloed.com/apps/apiguide/index.html).
