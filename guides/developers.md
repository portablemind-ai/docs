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

## Shipping a role with your app

The people who use your app need a security role in each workspace it runs in: the role decides what
they can see and do. That role belongs to your app, not to the platform — so it isn't something we
seed or migrate for you. You build it once, export it to a file, keep the file in your app's repo,
and import it into each workspace as part of your release.

**Build it once.** In your development workspace, open Administration → Roles, create the role and
give it the capabilities your app needs. Prefer **scoped** grants: a capability with no scope applies
to every record of that kind in the workspace, so "delete Tasks" unscoped lets your users delete
anyone's tasks, not just your app's. Scope it to the records your app owns — a custom-field tag, the
person's own team, the conversations they are in.

**Export it.** The Export button on the role downloads `<role>.role.export.json`. It lists the
capabilities by what they are (action, resource, scope), never by id, so the same file works in any
workspace. One thing to remove before you commit it: if specific records have been shared with the
role, those shares come out as entries pointing at record ids that only exist in your workspace.
Delete them from the file — it should carry the app's grants, nothing workspace-specific. Then
review changes to it the way you review code.

**Import it on every release.** Administration → Roles → Import Role takes the file (paste or
upload); developers can do the same with `POST /api/v1/security_roles/import` as a workspace admin.
An import is exact and repeatable: it creates the role if the workspace lacks it, then replaces the
role's capabilities with the file's — anything granted by hand since the last import is removed,
which is what keeps the file the truth. Records shared with the role are removed too, so re-share
them afterwards if your app relies on that. The description is only overwritten when you tick
"overwrite" or the role had none. A role marked external stays external; an import never un-flags one.

**Who holds the role is separate.** The file says what the role *can do*. Assigning it to people is
workspace membership — User Management, or the role list on a user when your app creates them — and
isn't part of the export. When your app creates users with something other than an admin's
credentials, it can only hand out roles marked external; an internal role is assigned by an admin.

**App users: with or without the Basic role.** Every ordinary member holds Basic, and Basic is broad
on purpose: members can create, change and delete everyday tasks, boards, channels and tickets, so a
new workspace works on day one. A person's access is everything their roles allow together, so your
role's scopes only narrow people who *don't* also hold Basic. If your users are ordinary members,
your role adds what they need on your app's own records, and its limits on everyday records make no
difference. If a workspace wants "app-only" people (say, staff who should only work inside your
app), the workspace gives them your role, plus External Member if they're outside the organisation,
and *not* Basic; then your scopes are the real boundary. That choice is the workspace's to make when
it assigns roles. Your job is a role that is correctly scoped on its own; don't try to restrict Basic
from your app.

Need a capability that doesn't exist yet? That is the one case that is a platform change rather than
an app change; tell us what action on what resource.

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
| App roles | [Shipping a role with your app](#shipping-a-role-with-your-app) | Security role export and import endpoints, scoped capabilities |
| Sub-workspaces | [Enterprise Sub-workspaces](sub-workspaces.md) | Creating sub-workspaces, agent template publishing and install, sharing a model with a spend cap, and the per-sub-workspace metrics a parent can read (names and numbers, never content) |

> **Tip:** If you're building AI agents that act on the platform, start with the MCP tools reference — it's usually a faster path than the raw REST API.
