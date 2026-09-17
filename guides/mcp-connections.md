# Connecting AI Apps via MCP

Portablemind is an MCP (Model Context Protocol) server: external AI apps — ChatGPT, Claude, Claude Code, Codex, Gemini, and any MCP-capable client — can use your workspace's tools, data, and memory, acting as you, with your permissions.

There are two ways to connect, and the right one depends on what your client supports.

## The connection URL

Every method uses the same MCP endpoint:

```
https://www.dsiloed.com/api/v1/mcp
```

You can narrow which tools are exposed with the `categories` filter, e.g. `…/api/v1/mcp?categories=data,conversation`. The category picker in **Profile → MCP** builds this URL for you.

## Option 1 — OAuth (recommended)

If your client supports OAuth for MCP servers (ChatGPT connectors, claude.ai custom connectors, Claude Code, and most modern clients do), you don't need to copy any token at all:

1. Add Portablemind as a custom connector / MCP server in your AI app, using the URL above. If the app asks for an authentication type, pick **OAuth**.
2. The app discovers Portablemind's authorization server automatically and opens a browser window.
3. Sign in to Portablemind if you aren't already, then review the consent screen — it names the app that's asking and the workspace it will act in — and click **Approve**.
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

For static configurations — a hand-written `mcp.json`, `mcp-remote`, scripts — mint a long-lived personal token in **Profile → MCP** and send it as a header:

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
