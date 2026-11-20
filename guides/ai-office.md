# The AI Office

The AI Office is a floor you can walk around. Every AI agent in your workspace has a desk, and the desk shows what the agent is doing right now — idle, thinking, writing a document, in a coding session, running an orchestration, or halted. Walk up to a desk and you are talking to that agent, in its real conversation.

It is the first app in the Portablemind [app catalog](apps.md). A workspace administrator installs it from **Administration → Platform → Apps → Catalog**; it adds no roles or permissions. Once enabled, it appears in the app switcher under **Apps → AI Office**, for workspace administrators.

## Who is on the floor

Only agents. People do not have desks: the office is for talking to agents, and you are there as a figure walking the floor. Agents that exist only as the stages of an orchestration pipeline are not shown either, because you do not talk to those directly; the pipeline's coordinator has a desk.

What a desk shows comes from the agent's live state, not from an animation. A desk only moves when something real happens:

| Desk | Meaning |
|---|---|
| **Idle** | The agent is active and has nothing running |
| **Working** | A run is in progress. Where your workspace records agent events you also see *thinking* and *working on a document*; otherwise the desk shows plain working |
| **In a coding session** | The agent is driving a coding agent through SiloLink |
| **Running an orchestration** | The agent coordinates a pipeline that is pending or running |
| **Away** | The agent is switched off |
| **Halted** | The agent has been halted and will not run until resumed |

When an agent finishes a piece of work its desk gives a small flourish and a toast tells you what it finished, when that is something you could open yourself. The office never shows prompts, tool details or the content of a conversation you are not part of; a title appears only when you could already open that conversation in Portablemind.

## Getting around

| Do this | To |
|---|---|
| **W A S D** or the arrow keys | Walk |
| Click the floor | Walk there |
| Click a desk | Walk up to it and open a chat |
| **E** | Chat with the desk you are next to |
| **/** | Find an agent by name; **Enter** walks to the first match and opens its chat, **↑ ↓** move through the matches |
| Drag | Look around (the camera stops following you until you walk again) |
| Scroll, **+** and **−** | Zoom; the centre button brings you back to yourself at 100% |
| **?** | The keyboard help |
| **Esc** | Close help, then the chat, then leave presenter mode |

The list on the side shows everyone in the office with their status and is the keyboard-only way in: **↑ ↓ Home End** move between agents and **Enter** opens the chat. On a phone or tablet a touch pad takes the place of the keys.

## Talking to an agent

Walking up to a desk and pressing **E** opens a chat panel with that agent's real direct message — the same conversation you would see in Team Chat, with the same history, and an @mention is not needed: the agent answers you here. What you say and what it answers are in that conversation for good. **Open in Portablemind** in the panel takes you to the full conversation.

An agent that is halted or away is still at its desk, and its status says so.

## Your figure

The gear in the office header holds **Your figure**: the character you walk as, from the same set of figures the agents use. It is saved with your profile. **Automatic** lets the office choose.

An administrator can also pick an agent's look: hover its desk and use **Change look**. The office otherwise chooses a figure for each agent itself, so the floor looks varied without anyone deciding.

## Presenter mode

The expand button puts the office full-screen, for a wall display or a demo. The header and list give way to an **Office at a glance** strip showing who is working. In presenter mode you can also switch on **Spotlight**: the camera glides to an agent as it starts working and lingers there, so a room can watch the day unfold. Spotlight is off by default and is not remembered. **Esc** leaves presenter mode.

> **Tip:** the AI Office is at its best with a team of agents that actually run — scheduled runs, orchestrations, coding sessions. See [Building AI Agents](agents.md) and [Agent Orchestration](orchestration.md).
