# Connecting AI Apps via MCP

Portablemind is an MCP (Model Context Protocol) server: external AI apps — ChatGPT, Claude, Claude Code, Codex, Gemini, and any MCP-capable client — can use your workspace's tools, data, and memory, acting as you, with your permissions.

There are two ways to connect, and the right one depends on what your client supports.

## The connection URL

Every method uses the same MCP endpoint:

```
https://www.dsiloed.com/api/v1/mcp
```

You can narrow which tools are exposed with the `categories` filter, e.g. `…/api/v1/mcp?categories=data,conversation`. The category picker in **Profile → Integrations → Connect an AI app (MCP)** builds this URL for you — pick individual categories, or start from a quick preset (Default, Coding, Agents & orchestration) and adjust. With no filter, every tool is exposed; a filter keeps only the categories you list (an unrecognized name is ignored, and if a filter matches nothing you still get a small core so the connection is never tool-less).

The available categories are:

| Category | Tools it exposes |
|---|---|
| `data` | CRUD, schema, files, status |
| `conversation` | Chat messaging |
| `communication` | Email, invitations, voice |
| `memory` | Store and load memories |
| `agents` | Create, execute, monitor agents |
| `admin` | Logs, cost stats |
| `utility` | Date/time, helpers |
| `documentation` | API docs assistant |
| `dynamic_functions` | Serverless JS functions |
| `llm_tools` | Custom tool management |
| `mdm` | External system mappings |
| `developer` | Git provider and SiloLink coding sessions |
| `skills` | Fetch a skill to use it locally |
| `research` | Web search and page fetch |
| `orchestration` | Multi-agent orchestration pipelines |
| `silolink` | Launch and control Claude Code sessions on your machine |
| `workflow` | Workflow artifacts |
| `coordination` | Agent resource coordination |
| `organization` | Agent org structure and escalation lookup |
| `ui` | Navigate, show, or walk you through the app |
| `support` | Ticket context for a support agent |

### Acting in a partner's workspace

A connection acts in your own workspace unless its URL names another one. To have an AI app work inside a partner's workspace you've been admitted to (see [Working inside a partner's workspace](workspace-sharing.md#working-inside-a-partners-workspace)), give it that workspace's own URL — the identifier goes in the **path**, and the categories filter still works:

```
https://www.dsiloed.com/api/v1/mcp/<their identifier>?categories=data,conversation,memory
```

**Profile → Integrations → Connect an AI app (MCP) builds it for you:** pick the workspace in **Workspace** (it lists your own and every partner workspace you've been admitted to), and the URL and the line beside it — *"This connection acts in …"* — change to match.

- **One connector per workspace.** Add a separate connector for each client workspace (for example "Portablemind — Acme") next to the one for your own. The copied Claude Code, Codex and Gemini commands name it `portablemind-<their identifier>` (your own stays `portablemind`), so adding a client's workspace adds a second server instead of replacing the first. Each has its own URL, so claude.ai, Claude Desktop and Claude Code keep them apart — Claude custom connectors sync across all three.
- **You still sign in as yourself.** The OAuth consent is your normal Portablemind sign-in; the consent screen says which workspace the connector will act in. If you haven't been admitted to that workspace, the consent screen tells you so instead of approving a connection that couldn't work.
- **The AI app is told where it is.** When it connects it's told the workspace it's working in — and that it isn't your home workspace — so what it reads, creates and saves lands where you intend.
- **Other ways to name the workspace.** `?workspace_tenant_id=<their identifier>` on the plain URL, or a `Workspace-Tenant-Id` header (for clients that send headers freely — a hand-written `mcp.json`, `mcp-remote`, scripts, `claude mcp add --header`), mean the same thing. Prefer the path form for connectors: Claude Code keeps connectors apart by URL **without** the query string, so two connectors that differ only in `?workspace_tenant_id=` show up there as one; and claude.ai's connector **Request Headers** need Anthropic's approval for your account.

If you name a workspace you haven't been admitted to (or one that doesn't exist), the connection is **refused** with *"Workspace switch refused: …"* rather than quietly working in your own workspace. If the URL names one workspace and a header or `?workspace_tenant_id=` names a different one, it is refused as *"Conflicting workspace"*. Naming your own workspace is the same as leaving it out. A connection made with an API key can't switch workspaces.

## Option 1 — OAuth (recommended)

If your client supports OAuth for MCP servers (ChatGPT connectors, claude.ai custom connectors, Claude Code, and most modern clients do), you don't need to copy any token at all:

1. Add Portablemind as a custom connector / MCP server in your AI app, using the URL above. If the app asks for an authentication type, pick **OAuth**.
2. The app discovers Portablemind's authorization server automatically and opens a browser window.
3. Sign in to Portablemind if you aren't already, then review the consent screen — it names the app that's asking, the account you're signed in as (name and email) and the workspace it will act in — and click **Approve**. If that's the wrong account (you have more than one), click **Not you? Switch account**: you're signed out, you sign in with the right one, and you land back on the same consent screen.
4. You're returned to the AI app, connected. Behind the scenes it received a short-lived access token and refreshes it automatically; there is nothing to rotate by hand.

### ChatGPT

In ChatGPT: **Settings → Connectors → Advanced → Developer mode**, then **Create** a connector with the MCP URL above and OAuth authentication. ChatGPT registers itself with Portablemind automatically and walks you through the consent screen. (The personal-plan connector dialog cannot send custom authorization headers — OAuth is the supported path.)

### Claude (claude.ai)

In claude.ai: **Settings → Connectors → Add custom connector**, paste the MCP URL, and complete the OAuth window when it opens.

### Claude Code

```bash
claude mcp add --transport http portablemind https://www.dsiloed.com/api/v1/mcp
```

then run `/mcp` inside Claude Code and choose **Authenticate** to complete the OAuth flow in your browser.

### Codex CLI

```bash
codex mcp add portablemind --url https://www.dsiloed.com/api/v1/mcp
codex mcp login portablemind
```

`codex mcp login` opens the PortableMind consent screen in your browser. Then start Codex and run `/mcp` to confirm the tools are connected.

### Gemini CLI

Add this to `~/.gemini/settings.json` under `mcpServers` (no token — Gemini discovers the sign-in automatically):

```json
{
  "mcpServers": {
    "portablemind": {
      "httpUrl": "https://www.dsiloed.com/api/v1/mcp"
    }
  }
}
```

Start the Gemini CLI; it opens a browser for the PortableMind consent screen and refreshes access on its own.

### Revoking access

Approving the consent screen authorizes that app until you revoke it. To revoke, change your password (or use "sign out everywhere") — that invalidates every session and every connected app's token for your account, so each app has to ask for consent again. Denying the consent screen sends the app away with no access.

## Option 2 — Personal MCP token (for clients that send headers)

For static configurations — a hand-written `mcp.json`, `mcp-remote`, scripts — mint a long-lived personal token in **Profile → Integrations → Connect an AI app (MCP)** and send it as a header:

```
Authorization: Bearer <your MCP token>
```

The Profile dialog generates ready-to-paste config for Claude Code and `mcp-remote`. Tokens last 90 days and can be revoked.

> **Do not put tokens in the URL.** A `?jwt=…` query parameter lands in proxy and server logs and browser history. Portablemind now rejects ordinary session tokens passed that way; if your client cannot send an `Authorization` header, use OAuth (Option 1) instead.

## For developers

The OAuth layer implements the MCP authorization spec: RFC 9728 protected-resource metadata, RFC 8414 authorization-server metadata, dynamic client registration (RFC 7591), authorization-code + PKCE (S256), and rotating refresh tokens. Discovery starts at:

```
https://www.dsiloed.com/.well-known/oauth-authorization-server
https://www.dsiloed.com/.well-known/oauth-protected-resource/api/v1/mcp
```

Any spec-compliant MCP client library will handle this automatically from a 401 challenge on the MCP endpoint. See the [Developer Resources](developers.md) page for the MCP tools reference.
