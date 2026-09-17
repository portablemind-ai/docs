# Recipes: what agents get wrong, and the right call

> Short, correct call shapes for the PortableMind MCP tools that are most often misused. Each recipe is also a Context7 rule.

All examples are `tools/call` arguments — never include `tenant_id`.

## Change a task's status

Status is **not** an attribute. It is a tracked-status application with history, and the
identifier is entity-prefixed.

```json
{"name": "apply_status_tool", "arguments": {"model_name": "Task", "id": 3717, "status": "task_in_progress"}}
```

Task identifiers: `task_not_started`, `task_in_progress`, `task_review`, `task_blocked`,
`task_on_hold`, `task_completed`, `task_cancelled`, `task_failed`, `task_backlog`.
`completed` alone matches a *different* status type and silently attaches the wrong one.
Setting `current_status` through `general_crud_tool` is rejected.

## Learn a model before you query it

```json
{"name": "model_schema_tool", "arguments": {"model_name": "Task"}}
```

Returns `special_filters` (what `filters` accepts), `required_fields` and associations.
Filter names are model-specific — do not guess them.

## List everything, or page

`general_crud_tool` returns **10 rows** unless told otherwise.

```json
{"name": "general_crud_tool", "arguments": {"model_name": "Project", "action": "list", "limit": -1}}
```

Or page: `"limit": 50, "offset": 100`, with `"sort": {"column": "created_at", "direction": "desc"}`.

## Find records shared from another workspace

```json
{"name": "general_crud_tool", "arguments": {"model_name": "Task", "action": "list", "include_shared": true, "filters": {"project_id": 21}}}
```

`details` (and the file/conversation tools) fall back to your shared access automatically;
`list`, `update` and `destroy` need `include_shared: true`.

## Post into a conversation

```json
{"name": "conversation_chat_tool", "arguments": {"conversation_id": 3870, "message": "@Ralph approved, proceed."}}
```

- `message` is a **string** here.
- Start with `@AgentName` when an agent should react. Mention-dispatch is the only trigger;
  an unmentioned message is a note nobody acts on.
- To have a model reply, add `llm_model_id`; the reply is generated asynchronously — poll the
  conversation newest-first, do not re-send.
- If you must create an `LlmMessage` row directly, its body is an object:
  `"attributes": {"llm_conversation_id": 3870, "message": {"role": "user", "content": "…"}}` —
  there is no top-level `content`.

## Start a direct message

```json
{"name": "start_dm_with_user_tool", "arguments": {"party_id": 19, "message": "@Rick quick one on the Context7 task."}}
```

`party_id` is the other side's **Party** id (every user and agent has one), not `user_id`
or `llm_agent_id`. Building `LlmConversation` + `LlmConversationMember` rows by hand
produces one-sided "ghost" DMs.

## Files: read, find, create, edit

```json
{"name": "list_llm_files_tool", "arguments": {"title_search": "contract"}}
```
```json
{"name": "read_llm_file_tool", "arguments": {"llm_file_id": 3699}}
```
```json
{"name": "create_llm_file_tool", "arguments": {"title": "Q3 status", "mime_type": "text/markdown", "content": "# Q3\n…", "directory_path": "/reports"}}
```
```json
{"name": "update_llm_file_tool", "arguments": {"llm_file_id": 3672, "replacements": [{"find": "$20k", "replace": "$30k"}]}}
```

- Something to **read** → `text/markdown`. Something to **look at** (dashboard, scorecard,
  board) → one self-contained `text/html` page, inline styles, no scripts.
- Images: `source_url` or `content_base64`, never base64 in `content`.
- No PDF/DOCX from a string — use `convert_to_pdf_tool` or the upload API.
- Do not CRUD `LlmFile` through `general_crud_tool`; the file tools extract text, handle
  images and attach the file to the conversation.

## Run an agent and get its answer back

```json
{"name": "list_available_agents_tool", "arguments": {}}
```
```json
{"name": "execute_agent_tool", "arguments": {"agent_name": "Ben", "prompt": "Draft the LinkedIn post.", "reply_conversation_id": 3870}}
```
```json
{"name": "check_agent_status_tool", "arguments": {"run_id": 48213}}
```

From a conversation, always pass `reply_conversation_id` or the reply lands nowhere visible.
Poll with the `run_id` the execute call returned; do not re-execute while a run is open.

## Remember and recall

```json
{"name": "store_memory_tool", "arguments": {"title": "Deploys auto-tag", "content": "PROD deploys tag automatically; set RELEASE_SUMMARY first or nothing posts to release-notes.", "memory_type": "fact", "importance_score": 0.8}}
```
```json
{"name": "load_memories_tool", "arguments": {"query": "deploy procedure", "limit": 10}}
```

Queries are semantic: plain words, no AND/OR/quotes. If two wordings return the same rows,
it is not in memory. Memories are re-injected verbatim into future conversations — keep each
one to a few sentences.

## Keep the tool list small

Every tool's description and schema is sent on every turn. Put a filter on the endpoint URL:

```
https://www.dsiloed.com/api/v1/mcp?categories=data,conversation,memory,utility
https://www.dsiloed.com/api/v1/mcp?tools=general_crud_tool,apply_status_tool,conversation_chat_tool
```
