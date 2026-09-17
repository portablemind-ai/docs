# Skills

Skills are how you teach your AI agents new capabilities without writing prompts from scratch every time. A skill packages up the know-how for a particular kind of work — how to run deep research, how to produce branded documents, how to summarize a web page — and lets you grant that capability to any agent with a single click.

Skills work hand-in-hand with [Building AI Agents](agents.md): you define an agent's personality and purpose there, then use skills to extend what it can actually do.

## What is a skill?

A **skill** is a reusable bundle of know-how you grant to an AI agent: a set of **instructions** (how to do something well) plus the **tools** it needs. Granting a skill is one click — the agent then has that capability.

To keep the agent fast, it only sees a skill's *name and description* until it actually needs it. When a request comes in that the skill applies to, the agent "loads" the full skill on demand. This is called **progressive disclosure** — an agent can carry dozens of skills without slowing down, because the detailed instructions only enter its context when they're relevant.

> **Note:** Skills follow the **Agent Skills open standard** — the same `SKILL.md` format used by Claude Code, Codex, and the 1,000+ community skills. That means you can **import** skills from the ecosystem, and skills you build in Portablemind are portable. Learn about the standard at [agentskills.io](https://agentskills.io).

## Installing a ready-made skill

The fastest way to add a capability is the **Skill Catalog** in AI Studio. Browse the catalog, pick a skill (for example *Deep Research* or *Office Documents*), and install it — it then appears among your workspace's skills, ready to be granted to an agent.

Each installed skill's detail view lists example requests, so you can see exactly what kind of request activates it — just say one to an agent that has the skill.

```recording
title: Install a skill from the catalog
src: https://www.dsiloed.com/api/v1/public/llm_files/2182/raw?key=68cc2e3820077cfbd75c8bc28cc544df
```

## What's in the catalog

The catalog currently offers these ready-made skills:

| Skill | What it does |
|-------|--------------|
| **office-documents** | Generate PowerPoint (.pptx) decks and print-quality PDFs from Markdown, or convert Office documents — themed and ready to share. |
| **deep-research** | Deep multi-source web research: fan out searches, cross-check sources, and synthesize a cited report (optionally as a PDF). |
| **diagram** | Turn a plain description into a polished on-brand diagram — flowchart, architecture, sequence, ER, or state — as PDF, PNG, or SVG. |
| **infographics** | Polished on-brand poster-style infographics (architecture, positioning, process, comparison) built from professional templates, as PNG or PDF. |
| **demo-video-recorder** | Captioned product walkthrough videos on demand. |
| **file-organization** | Audit and reorganize the workspace's Files tree: sweep loose files, consolidate duplicates, archive stale artifacts. |
| **agent-fleet-review** | Audit every agent in the workspace — personas, prompts, tools, health, cost — with per-agent recommended actions. |
| **agent-model-audit** | Audit agents against real usage and the model catalog; recommend the most cost-efficient model per agent, with projected savings. |

The catalog is growing — more skills are on the way.

## Importing a skill from the ecosystem

Found a skill on [agentskills.io](https://agentskills.io) or elsewhere? You can bring it into Portablemind directly. In AI Studio's Skills area, use **Import SKILL.md** and either **paste** the SKILL.md text or **upload** a `.md` file or a `.zip` bundle.

Before anything is created, you get a **preview** showing the skill's name, description, and an honest **tier badge** telling you what will actually run in Portablemind (see [What runs where](#what-runs-where--the-three-tiers) below). Confirm the import, then grant the skill to an agent.

A SKILL.md is just text — YAML frontmatter plus a Markdown body:

```yaml
---
name: web-summarizer
description: Summarize a web page
---
# How to use
Fetch the page and summarize the key points.
```

## What runs where — the three tiers

Skills are honest about *what actually runs*. When you import one, it's tagged with a tier so there are no surprises:

| Tier | What it means |
|------|---------------|
| **native** | Instructions only — a playbook. No bundled scripts, so it runs as-is, immediately. |
| **python** | Bundles a Python script — imported as a playbook, but the script only runs after a platform admin reviews and approves it. |
| **requires-silolink** | Needs a real coding environment (shell, CLI, browser). Imported as a playbook; the code runs via a SiloLink session on *your own* connected machine — your sandbox, your control. |

Every skill card shows its tier badge, with an explanation of what will run. (Separately from these import tiers, skills you build in Portablemind can bundle **sandboxed JavaScript scripts** that run with no review — see [Building your own skill](#building-your-own-skill) below.)

## Assigning skills to agents

Skills do nothing on their own — they take effect when you **grant them to an agent**. You can do this from the **Skills** section of the agent's edit dialog, or when creating an agent — the creation wizard's **Tools & Roles** step includes a skills picker. Each skill's card also shows which agents it's currently granted to. Once granted, the skill's name and description become part of what that agent knows it can do.

```recording
title: Assign a skill to an agent
src: https://www.dsiloed.com/api/v1/public/llm_files/2187/raw?key=7608a80841a8e2058918ea636277cbd3
```

To use a granted skill, just **talk to the agent in plain language** — in [AI Assistant](ai-assistant.md) or any conversation the agent is part of. The agent recognizes when the skill applies, loads it, and does the work. You don't need to know any commands or parameters.

> **Tip:** With the *Deep Research* skill granted, say "*Do deep research on the open-source agent frameworks landscape and give me a cited report.*" The agent loads the skill and runs the research.

## Building your own skill

You can create skills from scratch in AI Studio. Give the skill a name, a description, and instructions (the Markdown playbook). Then optionally add:

- **Scripts (sandboxed JavaScript)** — code that runs in a secure isolate with no review needed: it can make safety-checked web requests and use your workspace's data, files, and email helpers, but can't reach the server or other tenants. A granted agent calls it as a tool. Write a JS body that reads its arguments from the `params` object and returns a value, e.g. `return { total: params.values.reduce((a,b)=>a+b,0) };`
- **Reference files** — brand templates or example payloads the skill can use (for example a PowerPoint template for branded decks).
- **Built-in tools / Python scripts** — wire in approved platform tools.

```recording
title: Build a custom skill
src: https://www.dsiloed.com/api/v1/public/llm_files/2188/raw?key=d22446031d3237aca536d132e51a385d
```

> **Note:** Need something heavier than sandboxed JavaScript? Connect a SiloLink session and a skill can run real code on your own machine — see [Coding Agents](coding-agents.md).

Coding agents can also work the other way around: an MCP client such as Claude Code can fetch any of your Portablemind skills as a `SKILL.md` and run it locally. For API-level details, see the [API guide](https://www.dsiloed.com/apps/apiguide/index.html).
