# Building AI Agents

AI agents are autonomous AI collaborators that perform work in your Portablemind workspace — researching, writing, analyzing data, sending communications, and keeping projects moving. Unlike a chat assistant that responds only when you message it, an agent has its own instructions, tools, and (optionally) a schedule, so it can act on demand or entirely on its own.

Agents are created in **AI Studio**, on the Agents tab, using a guided step-by-step wizard. Before you can build one you need at least one AI model configured — see [Setting Up AI Models](ai-setup.md) if you haven't done that yet.

## The agent creation wizard

The wizard walks you through seven steps, so you never have to assemble an agent's configuration by hand:

1. **Template** — start from a prebuilt agent template that pre-fills the later steps, or choose custom to build from scratch.
2. **Identity** — name, description, and the LLM model the agent thinks with.
3. **Persona** — the agent's persona, its system prompt, and (for scheduled agents) an optional recurring prompt. For each you can reuse an existing one from your workspace or write a new one, with AI assistance available to help draft them.
4. **Tools & Roles** — check the tools the agent may use (marking critical ones as *always on*), attach [skills](skills.md), grant security roles, and attach resource files.
5. **Operations** — the run controls: an optional daily cost limit (the agent stops responding for the day once it hits it), the schedule toggle, whether the agent is active, discoverable by other agents, or private to you.
6. **Avatar** — give the agent a face by uploading an avatar image.
7. **Review** — confirm everything and create the agent.

After creation, any of this can be changed from the agent's edit dialog on the same Agents tab.

```recording
title: Build your first agent
src: https://www.dsiloed.com/api/v1/public/llm_files/2091/raw?key=133d37cc5e6628f4c624bee986d5b761
```

## Agent components

An agent is composed of a set of components, each serving a specific purpose:

### LLM model

The AI brain of your agent. It connects to one of your configured AI models (like Claude) to process information and make decisions, and determines the intelligence, speed, and cost profile of your agent. Fast, inexpensive models suit high-frequency routine agents; flagship models suit complex reasoning work.

### Prompts (system + recurring)

A layered set of instructions:

- **System prompt** — defines the agent's personality, behavior patterns, and operational constraints.
- **Recurring prompt** — for scheduled agents: the specific task instructions and objectives the agent should accomplish on each scheduled run.

### Persona (behavioral roles)

Context-based behavioral guidelines. Assigning a persona like "Software Engineer" or "Technical Writer" gives the agent expertise context for execution. An agent can hold multiple behavioral roles and use different combinations on different runs.

### Tools

The actions the agent can perform — sending emails, creating reports, updating records, or integrating with external systems. You can select from built-in system tools or add custom ones. Reusable capabilities can also be packaged as skills the agent draws on — see [Skills](skills.md).

### Resources

Data sources and information access: databases, documents, APIs, and other sources the agent needs to complete its tasks effectively.

### Schedule

Controls when and how often the agent runs:

- **Manual** — run on demand when you trigger it.
- **Scheduled** — recurring runs on a schedule you set, from every few minutes to daily or weekly.
- **Conversational** — agents also respond when @mentioned in any conversation they're a member of, whether or not they have a schedule.

### Conversations

Agents participate in conversations like any other member of your workspace. The conversation history gives the agent communication context and continuity — it can remember previous interactions across sessions.

### Memory

Beyond conversation history, agents use Portablemind's persistent memory system to store decisions, solutions, and insights long-term, and to learn patterns from their own execution history. See [Memory](memory.md) for how memories are stored, consolidated, and shared.

### Security roles

Permission-based access control. Separate from behavioral roles, security roles determine what data and capabilities the agent is actually allowed to touch. More on this [below](#agents-and-security-roles).

## Creating your first agent

Some advice for a first build through the wizard:

1. **Start from a template** if one fits — it pre-fills sensible prompts and tools you can then adjust, which is much faster than starting custom.
2. **Name the agent** descriptively (e.g., "Content Creation Agent") and pick a model matched to its workload.
3. **Keep the persona and system prompt focused.** Personality, behavior, and guardrails go in the system prompt; the recurring prompt holds the task itself.
4. **Grant only the tools and security roles it needs** — you can always add more later from the edit dialog.
5. **Set a daily cost limit** in the Operations step so an early misconfiguration can't run up spend.
6. **Test before scheduling.** Leave the schedule off at first (the wizard says exactly this), run the agent manually, try different role combinations, and only then turn scheduling on.

```recording
title: Test and activate an agent
src: https://www.dsiloed.com/api/v1/public/llm_files/2094/raw?key=6301c6b5e7a8cae63ab50c273b8bec3e
```

## Running agents manually

Beyond scheduled automation, any agent can be executed on demand with fine-grained control over the run:

- **Run immediately** without waiting for a schedule.
- **Add extra instructions** that apply just to this execution.
- **Select which roles to use.** All of the agent's roles are pre-selected by default; deselect some to change its behavior for this run.

> **Tip:** Use manual execution with different role combinations to see how your agent behaves in different contexts. A content agent run with only its "Technical Writer" role selected might focus on documentation; adding "Marketing Specialist" makes it more promotional. Combine that with a one-off instruction like "focus on API endpoints" to steer a single run precisely.

## Agent identity: agents are members of your workspace

Every agent is automatically set up with both a **party** and a **user account**, giving it a real identity in your workspace rather than existing as a faceless background process:

- **Party (identity).** The agent exists in the same party system as people and organizations. This is what lets it hold behavioral roles, appear in your organizational structure, and participate in conversations as a named member — you can chat with an agent, mention it, and see its messages attributed to it.
- **User account (security).** The agent has its own user account (with a username matching its name — no email address required). This account is what security roles attach to, so the agent's access is governed by the same capability-based security system as any human user.

This dual identity is what makes agents true collaborators: they show up where your team works, and they are held to the same access rules as everyone else.

## Agents and security roles

Portablemind deliberately separates two kinds of roles:

| | Behavioral roles | Security roles |
|---|---|---|
| Purpose | Personality and expertise | Permissions and access |
| Attached to | The agent's party | The agent's user account |
| Controls | Execution context and decision-making | What data and capabilities the agent can reach |
| Examples | "Software Engineer", "Technical Writer" | "Content Manager", "Data Analyst" |

Behavioral roles shape *how* the agent thinks; security roles bound *what* it can do. An agent with a persuasive persona but a narrow security role simply cannot touch data outside its permissions.

> **Warning:** Security best practices for agents:
>
> - Apply the **principle of least privilege** — assign only the security roles an agent actually needs.
> - Keep behavioral roles and permission roles separate; don't use one to approximate the other.
> - Regularly audit which security roles your agents hold.
> - Review and test agents thoroughly before activating scheduled operation.

For API-level details, see the [API guide](https://www.dsiloed.com/apps/apiguide/index.html).

## Next steps

- Give your agents durable knowledge with [Memory](memory.md).
- Package reusable capabilities as [Skills](skills.md) your agents can share.
- Coordinate multiple agents on multi-stage work with [Orchestration](orchestration.md).
- Need another model for a new agent? See [Setting Up AI Models](ai-setup.md).
