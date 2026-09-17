# PortableMind docs

Public, agent-facing documentation for [PortableMind](https://www.portablemind.ai) — the
AI-native workspace: team memory, agents, files, tasks and conversations, exposed to any AI
app as an **MCP server**. This repo is what [Context7](https://context7.com) indexes, so an
agent sitting in Claude Code, Cursor, Codex or ChatGPT can answer "how do I do X in
PortableMind?" from the current source of truth.

| Path | What | Maintained |
|---|---|---|
| [`mcp/README.md`](mcp/README.md) | MCP tool reference index — every client-facing tool by category | **Generated** from `model_api` (`rake mcp:docs`) on every merge to `development` |
| [`mcp/tools/`](mcp/tools) | One page per tool: served description, parameters, example, gotchas, schema | **Generated** (examples/gotchas come from `model_api/docs/mcp_reference/`) |
| [`mcp/connect.md`](mcp/connect.md) | Endpoint, OAuth vs token, workspace scoping, tool filtering, response shape | Hand-written, here |
| [`mcp/recipes.md`](mcp/recipes.md) | The calls agents most often get wrong, and the right ones | Hand-written, here — mirrored as `rules` in `context7.json` |
| [`guides/`](guides) | The in-app user guides (`www.portablemind.ai/docs`) | **Synced** from `harmoniq-frontend` on every merge to `develop` |
| [`llms.txt`](llms.txt) | Index for LLM crawlers ([llmstxt.org](https://llmstxt.org)) | Rebuilt by `scripts/build-llms-txt.sh` on every publish |
| [`context7.json`](context7.json) | Context7 configuration: folders, rules | Hand-written, here |

## How it flows

```
model_api (GitLab) ──publish_mcp_docs──▶ mcp/README.md + mcp/tools/   ┐
harmoniq-frontend (GitLab) ──publish_user_docs──▶ guides/             ├─▶ this repo (GitLab, source of truth)
hand edits (MRs here) ──▶ mcp/connect.md, mcp/recipes.md, context7.json ┘         │ push mirror
                                                                                  ▼
                                                                  github.com/portablemind-ai/docs
                                                                                  │ POST /v1/refresh (CI here)
                                                                                  ▼
                                                                    Context7  /portablemind-ai/docs
```

- **Do not edit generated files** (`mcp/README.md`, `mcp/tools/*`). Change the tool class in
  `model_api`, or its overlay in `model_api/docs/mcp_reference/<tool>.md`; the next merge
  republishes.
- **Do edit** `mcp/connect.md`, `mcp/recipes.md`, `context7.json`, this README — via an MR here.
  When you add a recipe, add the one-line version to `rules` in `context7.json`.
- `scripts/publish-slice.sh` is what the source repos' CI calls; `scripts/build-llms-txt.sh`
  regenerates `llms.txt` from the tree.

## Using it from an agent

With the Context7 MCP server installed, ask for PortableMind and add `use context7`, e.g.
"How do I change a task's status through the PortableMind MCP? use context7". Context7
resolves the library as `/portablemind-ai/docs`.

To connect the agent to a PortableMind workspace itself, see [`mcp/connect.md`](mcp/connect.md).
