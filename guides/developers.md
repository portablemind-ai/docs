# Developer Resources

Portablemind is built on an open, API-first platform. Everything you can do in the app — and a great deal more — is available programmatically, so you can integrate Portablemind with your own systems or build entirely custom applications on top of it.

This documentation site covers using the Portablemind app. Developer-level material lives in the platform API guide, summarized below.

## The API guide

The [API guide](https://www.dsiloed.com/apps/apiguide/index.html) is the home for everything code-level:

- **REST API reference** — authentication (JWT + tenant headers), response formats, error handling, and the full set of endpoint groups: parties and contacts, business events, security, and AI.
- **MCP tools reference** — the Model Context Protocol tools that let AI agents (including external agents like Claude) operate on the platform: creating records, querying data, managing conversations, and more.
- **Dynamic Functions** — serverless JavaScript that runs in a sandboxed environment inside your workspace, with OAuth integration and scheduling.
- **Building your own app** — scaffolding a single-page application against the platform, including shared authentication components and working sample code.
- **Sample applications** — a gallery of prebuilt demo apps showing platform patterns in action.

## Template apps: fork a working example

Three complete open-source applications built on Portablemind are published as public repos. Each is a real, deployed product — and each is deliberately structured as a **template you can fork** to build your own custom app. All three share the same minimal architecture: a single-page HTML + vanilla JavaScript frontend and a tiny zero-dependency Node proxy that injects runtime configuration and forwards authenticated requests to the platform. No framework, no build step.

| Repo | What it is |
| --- | --- |
| [pm-ticket-portal](https://gitlab.com/russonrails/pm-ticket-portal) | White-label customer support portal: clients register with an access key, submit tickets, and chat with an AI support agent that responds autonomously — with human staff able to step in at any time. |
| [pm-payer-portal](https://gitlab.com/russonrails/pm-payer-portal) | White-label healthcare payer portal: prior-authorization workflows driven by UM intake agents, with turnaround-time tracking and clinician-controlled denials. |
| [pm-agentic-accelerator](https://gitlab.com/russonrails/pm-agentic-accelerator) | Participant portal for agent-driven orchestration pipelines: users register, launch multi-stage pipelines, approve milestones, and view deliverables — scoped so each team sees only its own activity. |

These are the same kind of apps showcased on the [Apps](/apps) page — working examples of what you can build on the platform. In fact, `pm-ticket-portal` is the code behind our own live support site at [support.portablemind.ai](https://support.portablemind.ai), so you can see exactly what the template produces in production.

### Build your own app with a coding agent

The fastest path from template to custom app is to hand one of these repos to a coding agent (Claude Code, SiloLink, Codex, …) with a prompt like this:

```text
Clone https://gitlab.com/russonrails/pm-ticket-portal and use it as a template to
build a new app for me.

What I want to build: <describe your app — who uses it, what they can do, and
what the AI agent should handle>.

Keep the template's architecture: a single-page HTML + vanilla JS frontend served
by the zero-dependency Node proxy, which injects runtime config and forwards
authenticated requests to the platform. Reuse its authentication flow, API-client
patterns, and Docker deployment setup unchanged.

Replace the domain-specific screens, workflows, and agent configuration with my
use case, pointed at my Portablemind workspace (API base URL and tenant:
<your values>). For endpoint details, use the platform API guide
(https://www.dsiloed.com/apps/apiguide/index.html) and the interactive API
reference (https://www.dsiloed.com/docs/api/v1/index.html).

Before writing code, read the repo's README and integration guide and confirm
your plan with me.
```

Swap in whichever repo is closest to what you're building: the support-desk shape (`pm-ticket-portal`), the form-and-workflow shape (`pm-payer-portal`), or the orchestration-pipeline shape (`pm-agentic-accelerator`).

## Interactive API reference

A browsable Swagger/OpenAPI reference is available at
[www.dsiloed.com/docs/api/v1](https://www.dsiloed.com/docs/api/v1/index.html), covering request and response schemas for every public endpoint.

## Where the two guides meet

Some Portablemind features have both a user-facing side (documented here) and a developer side (documented in the API guide):

| Feature | User docs | Developer topics in the API guide |
| --- | --- | --- |
| Conversations & AI | [Chat & the AI Assistant](ai-assistant.md) | Webhook ingestion, embedding the chat component |
| Guest users | [Guest Users](guest-users.md) | Capability creation and assignment APIs |
| Workspace sharing | [Workspace Sharing](workspace-sharing.md) | Cross-tenant access request APIs |
| Coding agents | [Coding Agents (SiloLink)](coding-agents.md) | SiloLink session APIs and MCP bridge |
| Agents | [Building AI Agents](agents.md) | Agent and model configuration APIs |
| Dynamic functions | [Dynamic Functions](dynamic-functions.md) | Function management and execution APIs |
| White-label & single sign-on | [White-label Branding & Single Sign-on](white-label.md) | White-label setup and sign-on key APIs, the signed sign-on assertion and its exchange for a session |
| Sub-workspaces | [Enterprise Sub-workspaces](sub-workspaces.md) | Creating sub-workspaces, agent template publishing and install, sharing a model with a spend cap, and the per-sub-workspace metrics a parent can read (names and numbers, never content) |

> **Tip:** If you're building AI agents that act on the platform, start with the MCP tools reference — it's usually a faster path than the raw REST API.
