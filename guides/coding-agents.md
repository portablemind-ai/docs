# Coding Agents (SiloLink)

SiloLink is a bridge that connects coding-agent CLIs — **Claude Code**, **Gemini CLI**, and **Codex** (OpenAI) — to your Portablemind conversations. A small daemon runs on the machine where your code lives; Portablemind talks to it in real time. The result: you can launch a coding session from the Portablemind UI, chat with it like any other conversation, monitor it from AI Studio's Live Sessions view, and even drive it from a linked Slack or Discord channel — all without sitting at the terminal.

Under the hood, the daemon starts the chosen CLI in its own terminal session on your machine and wires it into the conversation automatically. Messages you send in Portablemind reach the agent; its progress updates, questions, and results flow back to the conversation — and to any external channels linked to it.

## Supported coding agents

A SiloLink session can run on any of three coding-agent CLIs. The workflow — launch, chat, peek, interrupt, nudge — is identical across all three.

| Agent | Notes |
|---|---|
| **Claude Code** | The default |
| **Gemini CLI** | Google's coding agent |
| **Codex** | OpenAI's coding agent |

You pick the agent when launching a session — the launch dialog has a coding-agent toggle. Whichever you choose, its CLI must be **installed and authenticated on the machine running the SiloLink daemon**.

> **Note:** Token usage for all three agents is captured automatically and rolled up under your user in AI Studio's cost analysis — see [Cost tracking](#cost-tracking) below.

## Setting up the SiloLink daemon

SiloLink runs once per machine — typically your development laptop or a build server where your repositories live. Setup is a one-time step.

**Prerequisites:**

- A machine with your code repositories on it
- **tmux** (the terminal multiplexer SiloLink uses to manage sessions)
- **Node.js / npm** (SiloLink installs as an npm package)
- The coding-agent CLI you want to use, installed and signed in (`claude`, `gemini`, or `codex`)

**The easiest path — let a coding agent install it for you.** The Launch SiloLink Session dialog in Team Chat includes a **Generate setup prompt** action. It produces a one-shot setup prompt pre-filled with your host, workspace, and credentials. Paste it into any coding agent running on the target machine, and the agent installs the daemon, configures it, and starts it for you.

If you prefer to do it by hand, full installation and configuration instructions ship with SiloLink itself, and the daemon's interactive setup wizard (`silolink config`) walks you through connecting it to your Portablemind account. The daemon can also be configured to run on behalf of one of your Portablemind AI agents rather than your user — see [Building AI Agents](agents.md) for how agents fit into the platform. For configuration reference, CLI commands, and daemon internals, see the [API guide](https://www.dsiloed.com/apps/apiguide/index.html).

> **Tip:** Your password is never stored on disk. The setup wizard exchanges your login for a long-lived token; if the server ever rejects it (for example after a password change), just re-run the setup wizard to refresh it.

## Launching a session from Portablemind

Once the daemon is running, launching a coding session takes seconds and requires no terminal work:

1. In **Team Chat**, open the launch dialog from the SiloLinks section.
2. Enter a session name, an optional starting prompt, and pick the coding agent.
3. Launch. The conversation appears immediately; the agent initializes in about 20–30 seconds and announces when it's ready.
4. Start chatting — the agent works on your machine and reports back in the conversation.

```recording
title: Launch a coding agent session
src: https://www.dsiloed.com/api/v1/public/llm_files/2191/raw?key=6b29934f44fcc248c79d62bc962a8268
```

SiloLink handles everything behind the scenes: it spawns the agent process on your machine, connects it to the conversation, and keeps the link alive. You just type messages.

### Sessions restart themselves

If a session goes idle or you close your browser, nothing is lost. When a new message arrives on a SiloLink conversation with no active session, SiloLink automatically restarts the agent — your message is buffered and delivered as soon as it's ready. Idle sessions announce "Going idle" and shut down cleanly on their own after a few minutes of silence.

### Peek, interrupt, and nudge

Three controls help you manage a running session from the conversation:

- **Peek** — see a live snapshot of what the agent is doing in its terminal right now.
- **Interrupt** — stop the agent mid-task and redirect it to check for your new instructions.
- **Nudge** — wake a session that has stopped responding.

Deleting a SiloLink conversation stops its agent session as well. Multiple sessions can run at once — each conversation gets its own independent agent process.

## Monitoring from AI Studio

Active SiloLink sessions appear in **AI Studio → Operate → Live Sessions** alongside the rest of your [AI agent](agents.md) activity, with real-time status tracking:

- **Session name** — matches the conversation name
- **Status** — idle, working, waiting for human, error, or completed
- **Heartbeats** — last-activity timestamps updated as the agent works
- **Conversation link** — jump straight to the session's conversation

There is also a **SiloLink Fleet** view in the same Operate group (visible to administrators) showing one row per daemon — which machine it's on, what version it's running, and how many live sessions it has. Daemons keep themselves up to date automatically: small updates apply on their own while the daemon is idle (never mid-session), and major upgrades always wait for a human. Administrators can pin or stage versions across the fleet — see the [API guide](https://www.dsiloed.com/apps/apiguide/index.html) for the version-policy details.

## Permission and consent gates

Coding-agent CLIs normally ask for confirmation before running tools, editing files, or executing shell commands. Sessions launched through SiloLink are pre-configured to run autonomously, so the agent can work without stalling on a prompt every few seconds.

> **Warning:** Autonomous mode grants the agent broad authority over the tools available on that machine. Only run SiloLink sessions in environments where you trust everything that's configured, and understand what the agent can reach.

Even in autonomous mode, the CLIs keep a hardcoded safety circuit breaker: genuinely dangerous patterns (like recursive deletes of your home directory) still require explicit confirmation. When that happens, you don't need to find the terminal — the **Peek** view in Team Chat detects the prompt and renders its options as one-click buttons, so you can approve, deny, or type a free-text redirection straight from the web UI.

```recording
title: Answer an agent's permission prompt from the peek view
src: https://www.dsiloed.com/api/v1/public/llm_files/2196/raw?key=63e9776f4f6aa1748e4b2dfbfe234e3f
```

If the agent needs a decision from you (for example, "Should I proceed with the migration?"), it posts the question in the conversation and waits for your reply — from the web UI or any linked channel.

## Driving agents from Slack or Discord

SiloLink conversations are ordinary Portablemind conversations, which means they can be linked to external channels — Slack, Discord, or Microsoft Teams — through the [Communications Hub](communications-hub.md).

Once linked, the loop looks like this:

1. Launch a session from the Portablemind UI.
2. Link the conversation to a Slack or Discord channel.
3. Send commands from that channel — "run the test suite", "fix the failing spec".
4. The agent executes on your machine and reports results back to the channel.

You can steer a full coding session from your phone in Slack while the work happens on your workstation at home.

```recording
title: Drive a coding agent from Slack
src: https://www.dsiloed.com/api/v1/public/llm_files/2238/raw?key=45692747ab7d49cac3f4f1b803222ee2
```

## Working in parallel — workspace isolation

When several sessions work on the same repository at once, they could step on each other's changes. SiloLink prevents this with **workspace isolation**: each session can get its own isolated working copy (a git worktree) on its own branch, so parallel sessions edit, commit, and test independently. When a session finishes, its branch is merged back to the base branch and the workspace is cleaned up.

Sessions can also **claim files** they intend to edit. Claims are advisory soft-locks: if another session claims a file that's already taken, both sessions — and both of their conversations — get a conflict warning, but work isn't blocked. Workspace state survives daemon restarts, and stale workspaces are cleaned up automatically.

You can watch all of this from **AI Studio → Operate → SiloLink Workspaces**, which shows each live session's workspace branch, its file claims, and any conflicts. Everything happens on your own machine, in your own repository — the isolation just keeps parallel SiloLink sessions out of each other's way. For the workspace tool reference and merge-conflict handling details, see the [API guide](https://www.dsiloed.com/apps/apiguide/index.html).

## Cost tracking

SiloLink sessions run the coding CLI outside Portablemind, so their token usage isn't billed through the normal message path. The daemon closes that gap automatically: it reads each CLI's local transcript, totals tokens by model, and reports them to Portablemind, where they're priced with the same model catalog used for in-app chat and rolled into **AI Studio → Cost Analysis** alongside everything else.

- **Where it shows** — cost analysis totals, broken down by model and user like any other usage.
- **By source** — a breakdown separating SiloLink (CLI agent) usage from in-app message usage.
- **By cost basis** — *real* (metered API key — actual marginal spend) vs *imputed* (subscription session — priced for visibility, with no per-token charge).
- **Idempotent reporting** — usage reports during and at the end of each session never double-count, even across reconnects.
- **Nothing to configure** — tracking is automatic for sessions launched through Portablemind.

Coding sessions you start yourself in a plain terminal (outside Portablemind) can be reported too, with the `silolink report-usage` command — run it manually after a session, or wire it into the CLI's session-end hook so every session self-reports. Either way, the usage rolls up under your user in Cost Analysis. Cost figures are close estimates computed from token counts; the provider's bill remains the authoritative number.

For API-level details — the MCP tool reference, control endpoints, and daemon protocol — see the [API guide](https://www.dsiloed.com/apps/apiguide/index.html).
