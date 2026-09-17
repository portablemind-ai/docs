# Dynamic Functions

Dynamic Functions are your own serverless JavaScript, running securely inside your Portablemind workspace. They let you extend the platform without deploying any infrastructure: pull data from external APIs, transform records, run scheduled jobs, or react to things happening in your workspace — all from a code editor in the app.

Each function executes in a sandboxed runtime that is isolated to your workspace, with a configurable timeout, so experiments can't run away from you.

You'll find them in **AI Studio**, under **Advanced / Dev → Dynamic Functions**. Create one with **New Function**, or bring one in with **Import Dynamic Function** (functions export and import as JSON, which makes them easy to share between workspaces).

```recording
title: Create your first dynamic function
src: https://www.dsiloed.com/api/v1/public/llm_files/2184/raw?key=c84f60023899ede0907f54bcc288f72b
```

## Writing a function

A function is plain JavaScript. The runtime injects a handful of **global variables** describing the run — they are top-level globals, not properties of a wrapper object:

| Variable | What it holds |
| --- | --- |
| `params` | The input parameters passed by whoever invoked the function. |
| `config` | The function's own configuration object (shared configuration merged with the local one). `config.sharedConfigurationId` is the ID of the shared configuration record, when one is attached. |
| `oauth` | Present only when a shared OAuth configuration is connected: `oauth.accessToken` and `oauth.tokenType`. |
| `functionId`, `functionName` | This function's ID and name. |
| `tenantId` (also `tenant_id`) | The workspace this run belongs to. |

The editor starts you with a working template. To produce a result, either `return` a value at the top level or simply let the last expression be the value — both work. That result is what the caller receives, and what shows up in the execution history.

Each function has a **Timeout (seconds)** setting that caps how long a run may take (up to 30 minutes). Separately, a run is stopped if it goes **60 seconds without calling any of the built-in functions below** — that's the infinite-loop guard, so a long job that keeps calling `fetch`, `listRecords`, and friends is fine.

The whole script runs inside a single database transaction. If your code throws, every write it made is rolled back.

## Built-in functions

The sandbox has no network stack, file system, or npm modules of its own. Everything it can reach is provided by the functions below, which bridge into the platform on your behalf — already scoped to your workspace and to the permissions of the user the function runs as.

Unless noted otherwise, every one of these is **synchronous**: the return value *is* the result. There are no promises to await.

### Reading and writing workspace data

The general-purpose door is `executeAction(modelName, action, options)`, where `action` is one of `'list'`, `'details'`, `'create'`, `'update'`, or `'destroy'`. `modelName` is any platform model — `'Party'`, `'User'`, `'Project'`, `'Task'`, `'LlmFile'`, `'BizTxnEvent'`, and so on. The named convenience wrappers below are usually easier to read.

| Function | What it does |
| --- | --- |
| `executeAction(modelName, action, options)` | Any CRUD action on any model. Also available as `execute_action`. |
| `listRecords(modelName, options)` | List records. `options` accepts `limit`, `offset`, and a `search_query` for filtering, joining, and sorting. |
| `getRecord(modelName, id)` | Fetch one record by ID. |
| `createRecord(modelName, attributes)` | Create a record. |
| `updateRecord(modelName, id, attributes)` | Update a record. |
| `deleteRecord(modelName, id)` | Delete a record. |
| `findOrCreateRecord(modelName, findAttributes, createAttributes)` | Look up by `findAttributes`; create with `createAttributes` (defaults to `findAttributes`) when nothing matches. Returns `created: true` or `false` so you can tell which happened. |
| `shareRecord(modelName, recordId, granteePartyId, accessLevel)` | Share a record with another party in your workspace: `'viewer'` (default), `'commenter'`, `'editor'`, or `'full_access'`. Ownership can't be granted, and you can only share what the acting user could share through the normal share UI (their own records, records they hold full access on, or anything in the workspace if they're an admin). Grants are silent — no notification email — and fully audited. |

```javascript
// Find the 10 most recently created organizations
var orgs = listRecords('Party', {
  limit: 10,
  search_query: {
    where: { business_party_type: 'Organization' },
    sort: { column: 'created_at', direction: 'desc' }
  }
});

var project = createRecord('Project', { name: 'Q3 Migration', description: 'From params: ' + params.source });
updateRecord('Project', project.data.id, { description: 'Updated' });

// Make what you just created reachable by the team, not only its owner
shareRecord('Project', project.data.id, teamPartyId, 'editor');
```

A few guarantees worth knowing when you build automation on these:

- **Writes respect the acting user's permission scopes, per action.** A permission scoped to "own records" only deletes own records; a record shared to you as `editor` can be updated but never deleted (deleting through a share requires `full_access`).
- **Filters never fail silently.** A list option the platform can't apply raises a catchable error instead of quietly returning the unfiltered set — so put filters in `search_query: { where: ... }`, and trust that an empty result really means zero rows.

### Linking records together

For many-to-many relationships between models:

| Function | What it does |
| --- | --- |
| `linkRecords(modelName, modelId, relatedModelName, relatedId)` | Link two records. |
| `listRelatedRecords(modelName, modelId, relatedModelName)` | List a record's related records. |
| `unlinkRecords(modelName, modelId, relatedModelName, relatedId)` | Remove a link. |
| `executeRelationshipAction(modelName, action, relatedModelName, options)` | The underlying call, when you need to pass relationship keys yourself. Also available as `execute_relationship_action`. |

### Making HTTP requests

| Function | What it does |
| --- | --- |
| `fetch(url, options)` | Call an external HTTP(S) API. `options` takes `method`, `headers`, and `body`. |
| `urlEncode(params)` | Turn an object into a URL-encoded query string. |

`fetch` looks like the browser API but is **synchronous** — there is no event loop in the sandbox, so `await` is a syntax error and the return value is the response itself. Read it with `response.status`, `response.ok` (the 2xx convenience flag), `response.json()`, or `response.text()`.

Outbound requests are checked before they connect: only `http` and `https` are allowed, and hosts that resolve to private, loopback, or cloud-metadata addresses are refused. If you need to reach a self-hosted service on a private network, an administrator can allow that host for your workspace.

```javascript
var response = fetch('https://api.example.com/v1/invoices?' + urlEncode({ since: params.since }), {
  method: 'GET',
  headers: { Authorization: 'Bearer ' + oauth.accessToken }
});

if (!response.ok) {
  return { error: 'Upstream returned ' + response.status };
}

var invoices = response.json();
```

### Working with files

These operate on the files in your workspace's [file library](files.md).

| Function | What it does |
| --- | --- |
| `listFiles(options)` | List files. Filter by `directory_path` (with `recursive`), `type`, `title_contains`, `mime_type`; paginate with `limit`/`offset`; sort with `sort`. |
| `readFile(fileId)` | Read a file's contents. Documents come back as extracted text, spreadsheets as CSV or a queryable dataset, images and media as base64. |
| `createFile(title, mimeType, content, directoryPath)` | Create a text file. Supported types: `text/markdown`, `text/x-markdown`, `text/plain`, `text/csv`. |
| `updateFile(fileId, { title, content, directory_path })` | Rename, move, or rewrite a file. Content edits apply to text-based files only. |
| `moveFile(fileId, newDirectory)` | Move a file to another folder. |
| `deleteFile(fileId)` | Delete a file. |
| `listDirectories(basePath)` | List the subfolders of a path. |

### Conversations and email

| Function | What it does |
| --- | --- |
| `sendMessage(conversationId, message, options)` | Post a message into a conversation. Pass `{ llm_model_id: id }` to also trigger an AI reply. |
| `addConversationMember(conversationId, partyId, admin)` | Add someone to a conversation. Idempotent — re-adding an existing member just returns them. |
| `sendEmail(toEmail, subject, emailBody, fromEmail)` | Send an ad-hoc email. `emailBody` is HTML; separate multiple recipients with semicolons. |
| `sendTemplatedEmail(key, toEmail, variables)` | Send one of the platform's registered notification emails by key, using your workspace's branded template when it has one. Only templates marked as sendable from a function are accepted. |

`addConversationMember` is the *only* way to add a member from a function — `createRecord('LlmConversationMember', …)` is deliberately refused, because conversation membership is access control rather than ordinary data. Adding someone requires more than permission to create records in general: the acting user must own that conversation, be an admin member of it, or be an admin of the workspace it lives in. Anything else comes back as `{ success: false, error: … }` instead of adding them.

The acting user is whoever triggered the run — for scheduled and callback functions, that's the **Run As User** configured on the function, so give that user the standing on the conversation you need before wiring up an automation that adds people to it.

```javascript
// Ticket-intake pattern: open a thread, then pull the reporter into it
var added = addConversationMember(params.conversation_id, params.reporter_party_id);
if (!added.success) {
  return { warning: 'Thread created but reporter not added: ' + added.error };
}
```

### Calling another function

```javascript
// Run another dynamic function in this workspace, by name or by ID.
// Pass async = true to queue it in the background instead of running it inline.
executeFunction(functionNameOrId, params, async)
```

### Communications Hub lookups

If you're building against the [Communications Hub](communications-hub.md), `hubDiscover(channelId, resource, tenantId, query)` looks up channel-side resources (channels, teams, users) for `discord`, `msteams`, `slack`, `twilio_sms`, or `twilio_voice`. The Hub credentials stay on the server — your code never sees them.

### Connecting records to external systems

When you're syncing with an outside system, these keep track of which local record corresponds to which external ID, so repeated syncs update rather than duplicate:

| Function | What it does |
| --- | --- |
| `getExternalId(modelName, recordId, externalSystemIdentifier, columnName)` | Find the external ID recorded for a local record. |
| `findByExternalId(modelName, externalSystemIdentifier, externalId, columnName)` | Find the local record for an external ID. |
| `storeExternalMapping(modelName, recordId, externalSystemIdentifier, externalId, options)` | Record the mapping. Creates the external system entry if it doesn't exist yet. |

### Reading the results

Most functions return an object with a `success` flag: the file, email, and conversation helpers return `{ success: false, error: '...' }` when something goes wrong, so check `success` before using the result. The data helpers (`executeAction` and its wrappers) instead **throw** on failure, which — because the run is wrapped in a transaction — rolls back everything the function has written so far. Wrap them in `try`/`catch` if you want to handle a failure yourself rather than fail the whole run.

> **Note:** `console.log` exists but goes nowhere — the sandbox has no attached console. To see what a run did, return the values you care about; they're captured in the function's **Execution history**.

## Running functions

There are four ways a dynamic function runs:

- **Manually** — the **Execute (manual run)** action on the function's row runs it on demand with parameters you supply. Great while developing.
- **From the API** — `POST /api/v1/dynamic_functions/:id/execute` (by ID or by name) with `{ params, async }`. By default the function runs with the *caller's* permissions; set `api_executes_as_run_as_user: true` on the function (via the update API) to run API triggers as its **Run As User** instead — the caller is still recorded on the execution for audit. The `execute` permission can also be granted for specific functions rather than all of them.
- **On a schedule** — configure recurring runs directly on the function: every N minutes, every N hours, daily at a set time, monthly on a day of the month, or a raw CRON expression for anything more exotic. Scheduled runs execute as the user you pick in **Run As User**, and the **Active** toggle turns the schedule on and off.
- **On platform events (callbacks)** — attach the function to a **Callback Model** and **Callback Event** (`create`, `update`, `destroy`, or `all`) so it fires automatically when that kind of record changes in your workspace. Supported models include `Party`, `User`, `Project`, `Task`, `BizTxnEvent`, `BizTxnAccount`, `Individual`, `Organization`, `TimeEntry`, and `Timesheet` — teams created through signup fire `Party` create callbacks, and a `User` destroy callback is the hook for account-offboarding cleanup. The record handed to your function only ever contains published API fields (never credentials).

Every run is recorded — the **Execution history** action shows past runs with their results, so you can see what a scheduled or callback-driven function has been doing.

```recording
title: Schedule a function and review its execution history
src: https://www.dsiloed.com/api/v1/public/llm_files/2190/raw?key=add1dedf809c14ffa6dfb0f93feedccf
```

## Connecting to external services (OAuth)

Functions that call external APIs can use a **Shared Configuration (OAuth)** — a workspace-level OAuth connection to an outside service. Once connected, your code receives a ready-to-use `oauth.accessToken` — pass it straight to `fetch` — so you never handle client secrets or token refresh yourself. This is the pattern for integrating accounting systems, CRMs, and other third-party APIs.

## Dynamic functions and AI

Dynamic functions plug into the rest of the platform:

- [AI agents](agents.md) can list and execute your dynamic functions as tools, which means you can hand an agent a custom capability just by writing one.
- Combined with schedules and callbacks, a function can feed fresh external data into the workspace that your agents and [AI memory](memory.md) then work from.

> **Tip:** If a capability is mostly *instructions* for an agent, package it as a [skill](skills.md); if it's mostly *code* that needs to run reliably (API calls, data transforms, scheduled jobs), make it a dynamic function. The two compose well.

For the underlying API — managing and executing functions programmatically — see the [API guide](https://www.dsiloed.com/apps/apiguide/index.html).
