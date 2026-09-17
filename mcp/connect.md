# Connecting an agent to PortableMind (MCP)

> Endpoint, authentication, workspace scoping, tool filtering and response shape for the PortableMind MCP server.

PortableMind is a remote MCP (Model Context Protocol) server over streamable HTTP. Any
MCP-capable client — Claude Code, Claude.ai, ChatGPT connectors, Cursor, Codex CLI, Gemini
CLI, or your own agent — connects to one URL and gets the tools in the
[tool reference](README.md).

## Endpoint

```
https://www.dsiloed.com/api/v1/mcp
```

`POST` carries JSON-RPC (`initialize`, `tools/list`, `tools/call`, `resources/read`).
`GET` answers `405` — the server does not open an SSE stream, and clients should not expect one.
`DELETE` tears a session down.

## Authentication

**OAuth 2.1 (recommended).** An unauthenticated request gets `401` with a
`WWW-Authenticate: Bearer resource_metadata=…` challenge, so OAuth-capable clients discover
the authorization server and open the consent screen themselves. The consent screen names the
app and the workspace it will act in; approving returns a short-lived access token the client
refreshes on its own.

```bash
# Claude Code
claude mcp add --transport http portablemind https://www.dsiloed.com/api/v1/mcp
# then inside Claude Code: /mcp → Authenticate

# Codex CLI
codex mcp add portablemind --url https://www.dsiloed.com/api/v1/mcp
codex mcp login portablemind
```

Claude.ai: **Settings → Connectors → Add custom connector** with the URL.
ChatGPT: **Settings → Connectors → Advanced → Developer mode → Create**, OAuth.
Gemini CLI: add `{"mcpServers": {"portablemind": {"httpUrl": "https://www.dsiloed.com/api/v1/mcp"}}}` to `~/.gemini/settings.json`.

**Personal MCP token** (for static configs, `mcp-remote`, scripts): mint one in
**Profile → MCP** in the app and send it as a header. Tokens last 90 days and can be revoked.

```
Authorization: Bearer <your MCP token>
```

Revoking: change your password or "sign out everywhere" — that invalidates every connected
app's token, and each has to ask for consent again.

## Who the calls run as

Every tool call runs **as the authenticated user, in that user's workspace, with that user's
permissions**. There is no service account and no impersonation over MCP:

- **Never send `tenant_id`.** The server derives the workspace from the credential; a
  `tenant_id` in the arguments is ignored or rejected.
- **Sharing crosses workspaces, credentials do not.** Records shared with you from another
  workspace (conversations, files, projects, tasks…) are reachable: `details` and file/conversation
  lookups fall back to your shared access automatically; `general_crud_tool` `list`/`update`/`destroy`
  need `include_shared: true`.
- Anything the user cannot do in the app, the agent cannot do through MCP either.

## Choosing which tools you get

The full catalogue is ~90 tools, and every tool's description and schema is sent to the
model on every turn. Narrow it on the URL:

| Query | Effect |
|---|---|
| `?categories=data,conversation` | only the listed [categories](README.md) |
| `?tools=general_crud_tool,apply_status_tool` | only the named tools |
| both | the union |

The **Profile → MCP** dialog in the app builds these URLs. A typical "work my tasks and
files" client wants `data,conversation,memory,utility`.

## What comes back

Tool results are MCP text content blocks, not a JSON envelope:

- **Errors** are one text block beginning `Error: …`.
- **Successes** are a message line, usually followed by a second block of pretty-printed JSON
  (the record, the list, the id you need next). Some tools return a single JSON block.
- Images (e.g. `read_llm_file_tool` on an image) come back as image content the model can see.

Large results: prefer narrowing (filters, `limit`, `title_search`, a `directory_path`) over
paging through everything; tools that can exceed a sensible size say so in their result
(`truncated: true` + a notice, or a `result_next_offset`).

## Where to go next

- [Tool reference](README.md) — every tool with parameters, an example and gotchas.
- [Recipes](recipes.md) — the calls agents most often get wrong.
- [User guide: Connecting AI Apps via MCP](../guides/mcp-connections.md) — the same connection
  steps written for people, with screenshots' worth of menu paths.
