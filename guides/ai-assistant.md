# Chat & the AI Assistant

Chat is where you and your AI work together in Portablemind. Every conversation is a shared space that can include you, your teammates, and AI participants — the AI joins as a peer collaborator, not a separate tool you switch to. Ask a quick question in a private conversation with the AI Assistant, or bring the AI into a team discussion exactly when you need it.

The same conversation model powers everything: one-on-one chats with the AI, team channels, direct messages, and conversations that agents participate in. Messages arrive in real time, conversations are organized and persistent, and the AI has access to your workspace context — so its answers reflect your actual data, files, and history.

## Talking to the AI with @ai mentions

How you talk to the AI depends on the kind of conversation:

- **In a direct AI Assistant conversation**, every message is treated as a prompt — just type and the AI replies. No mention needed.
- **In team channels and direct messages**, the AI responds when you mention it. Start your message with `@ai` and the AI will reply in the thread. (The mention needs to be at the beginning of the message — if you put it in the middle, the composer offers to reformat for you.) Messages **without** an @ai mention are ordinary human messages — they're saved to the conversation but don't trigger an AI response.

This is what makes mixed human-AI conversations work: your team can discuss freely and pull the AI in only when it's wanted.

```recording
title: Start a conversation with @ai
src: https://www.dsiloed.com/api/v1/public/llm_files/2095/raw?key=3ae890dc7dd441750c4a637d5afea70e
```

### Mention syntax

The basic `@ai` mention uses your workspace's default model. You can also target a specific model, or ask for conversation compaction (a summarized context window — useful in very long conversations):

```text
@ai                       Uses the default AI model
@ai:model_name            Uses a specific AI model
@ai/compact               Default model, with conversation compaction
@ai:model_name/compact    Specific model, with conversation compaction
```

Examples:

- `@ai Can you help me analyze this data?` — default model responds.
- `@ai:claude-sonnet Please review this code` — a specific model responds.
- `@ai:gpt-4/compact Summarize our conversation` — a specific model responds using a compacted view of the conversation.

The models available to mention are the ones configured for your workspace — see [Setting up AI providers](ai-setup.md).

> **Tip:** In long-running conversations, `/compact` keeps responses fast and focused by summarizing earlier history instead of resending all of it.

## Multi-member conversations

Conversations aren't limited to you and one AI. A single conversation can include:

- **Multiple human members** — teammates added to the conversation, each with role-based access.
- **AI models** — mentioned on demand with `@ai`, as described above.
- **AI agents** — persistent, named agents that are members of the conversation and can be mentioned by name, take on work, and report back. See [Building AI Agents](agents.md).

This makes chat the natural home for human-AI teamwork: a project channel might hold a design discussion between three people, an `@ai` request to summarize the thread, and a task handed to an agent — all in one place. Everyone (human and AI) sees the same conversation history, and the AI's contributions are visible to the whole group.

## Threads

To follow up on one message without interrupting the conversation, hover over it and choose **Reply in thread**. An `@ai` mention or an agent mention inside a thread is answered in that thread, using that thread as its context. See [Threads](threads.md).

## File attachments

You can attach files directly to conversations, and the AI can read them. Supported formats include PDFs, Word documents (DOCX), Markdown and plain text, images (PNG, JPG), PowerPoint presentations, and video files (MP4, WebM, MOV). Attach a contract and ask `@ai` to summarize it, drop in a screenshot for analysis, or share a deck and ask for feedback on it.

```recording
title: Attach files to a conversation
src: https://www.dsiloed.com/api/v1/public/llm_files/2100/raw?key=18438dde2f1c75c1aef05bd8e4c9139e
```

Attached files also live in your workspace's file system, so they stay available beyond the conversation — see [Working with files](files.md).

## Long conversations: what to expect

An AI reply is not just your latest message — the AI has to re-read the conversation to answer in context. So the longer a thread gets, the more there is to read, and you'll notice two things in a very long conversation: replies take longer to start, and each turn costs more, even for a short question.

Portablemind manages this for you:

- **The conversation is windowed automatically.** Beyond a certain size, older messages are left out of what's sent to the model and replaced by a short note saying how many were omitted. The AI can still go get them — it searches the conversation's own history on request, so nothing is lost, it just isn't re-read every time.
- **Older attachments become references.** Files on recent messages are read in full; files further back are replaced by a pointer the AI can follow if it needs them. This is why a conversation with dozens of attachments doesn't get progressively slower forever.
- **Repeat turns reuse cached context.** Every provider we support can recognize that it has already read the beginning of your conversation and charge a fraction of the normal rate for it. Portablemind arranges each request so this works — which is why turns in an established conversation are cheaper than the first one, and why turns sent close together benefit most.
- **Compaction summarizes the rest.** When a conversation grows very large, the AI can replace old messages with a summary that preserves the decisions and details. You can request this yourself at any time with `@ai/compact` (see the mention syntax above).

If a thread has drifted onto an unrelated topic, **starting a new conversation is the single most effective thing you can do** — a fresh conversation has nothing to re-read, so it answers in seconds. Long-running threads are worth keeping for continuity; they aren't the right place for quick, unrelated questions.

The tools the AI carries are re-sent on every turn as well, which is why each conversation gets a short list rather than the whole catalog — see [Choosing which tools the AI can use](#choosing-which-tools-the-ai-can-use).

Per-message token usage and cost are tracked for every model, so you can see this directly rather than guess at it — see [Setting Up AI Models](ai-setup.md).

## Choosing which tools the AI can use

Tools are what let the AI act instead of only answering: look up and change records, read and write files, search the web, send email, hand work to an agent. Portablemind has about 90 built-in tools, plus any custom tools and MCP servers your workspace has added.

The AI is deliberately **not** given all of them. Every tool's description is sent to the model with every message, whether or not the tool is used, and the full catalog runs to tens of thousands of tokens. Handing it all over makes every reply slower and more expensive, leaves less room for the conversation itself, and makes the AI more likely to pick the wrong tool. So each conversation gets a short list, which you control at two levels:

- **The workspace default** applies to every AI Chat and to `@ai` in every channel and direct message.
- **A single conversation** can have its own list, which replaces the default there.

Both use the same picker: search for a tool by what it does ("sending emails", "web search"), check or uncheck it, and save.

If you ask the AI for something it has no tool for, it should tell you which tool is switched off and how to add it, rather than say it can't be done. You can also ask it directly: "which tools are available?" lists every tool and whether it's on in this conversation.

### What's on by default

Until an administrator changes it, every conversation gets this list:

| The AI can… | Tools |
| --- | --- |
| Remember and recall — **always on** | `store_memory_tool`, `load_memories_tool`, `update_memory_tool`, `forget_memory_tool`, `link_memories_tool` |
| Know the date and time — **always on** | `current_date_time_tool` |
| Search this conversation's earlier messages — **always on** | `search_conversation_history_tool` |
| Find, create and update records (projects, tasks, tickets and more) and set their status | `general_crud_tool`, `model_schema_tool`, `apply_status_tool` |
| Work with files | `create_llm_file_tool`, `read_llm_file_tool`, `update_llm_file_tool`, `list_llm_files_tool`, `move_llm_file_tool`, `delete_llm_directory_tool`, `convert_to_pdf_tool` |
| Research on the web | `web_research_tool` |
| Send email | `send_email_tool` |
| Post in other conversations and start direct messages | `conversation_chat_tool`, `start_dm_with_user_tool` |
| Use skills | `load_skill_tool`, `use_skill_tool` |
| Find agents, hand them work and check on it | `list_available_agents_tool`, `execute_agent_tool`, `check_agent_status_tool` |
| Look up who's who in your organization | `org_lookup_tool` |
| Answer questions about how Portablemind works | `dmapi_assistant_tool` |
| Take you to a screen, point something out, or walk you through a task | `navigate_user_tool`, `show_user_tool`, `walk_user_tool` |

The **always on** tools appear checked and locked in the picker. They can't be removed, so memory and conversation history keep working whatever else you choose.

### Changing the workspace default

Workspace administrators set the default under **Administration → System Defaults → AI Conversation Tools**.

1. Search or browse the catalog. Built-in tools are grouped by category, your workspace's own tools are under **Custom Tools**, and each connected MCP server has its own group.
2. Check the tools every conversation should have and uncheck the ones it shouldn't.
3. Click **Save Defaults**.

The label beside the page title shows which list is in effect: **Using platform defaults** (the table above) or **Tenant default configured** (your own list). **Reset to Platform Defaults** returns to the table above.

Add a tool to the default when most of your team needs it in most conversations — a custom tool that looks up orders in your own system, say. Remove one when the AI shouldn't do something anywhere in your workspace, such as sending email. Keep the list short: every tool you add is paid for on every message in every conversation.

> **Note:** A custom tool or MCP server is never added to conversations automatically. Create it in **AI Studio → Models & Tools** (**LLM Tools** or **MCP Servers**), then check it here or in a conversation's AI Tools.

### Changing the tools for one conversation

Open **AI Tools** for the conversation in either of two ways:

- In the chat sidebar, click the gear icon beside a channel, then **AI Tools**.
- In any open conversation, including an AI Chat, click **⋮** (More actions) at the top of the conversation, then **AI Tools**.

Check or uncheck tools and click **Save for Conversation**. The label at the top changes from **Following tenant defaults** to **Conversation override**.

A conversation with its own list keeps exactly that list. It no longer picks up changes to the workspace default. To go back to following the default, open AI Tools and click **Use Tenant Defaults**.

Give a conversation its own list when it needs something the rest of the workspace doesn't: a specialist or custom tool for one team's channel, or a tool that's too heavy to give everyone. Or go the other way and remove tools, for example taking email away in a channel shared with guests.

Two things to know:

- **Only the conversation's owner or an admin of it can change its tools.** If you don't see AI Tools in the menu, you aren't one, or the conversation belongs to another workspace, which manages its own tools.
- **The list applies to agents in the conversation too.** An agent answering there can't use a built-in tool you left unchecked, even if the agent normally has it. Its own custom tools and skills are unaffected.

## Memory across conversations

Conversations feed the platform's persistent [AI memory](memory.md). When you ask the AI to remember something — or it judges a preference, decision or solution worth keeping — it saves a memory, and relevant memories are recalled automatically in future conversations, so the AI you talk to next week knows what you told it this week. Your workspace administrator can also turn on background capture from conversations (off by default). You can see and correct what is kept about you under **Settings → Memory**.

## Connecting external systems

Conversations can also receive messages from outside Portablemind through inbound webhooks — for example, a monitoring system posting alerts into a channel, or an external application feeding events into a conversation. A webhook message can even include an `@ai` mention, so an incoming alert can trigger an immediate AI analysis in the thread.

Webhooks are created per conversation and each has a unique URL.

> **Warning:** Webhook URLs contain unique keys and should be treated as sensitive. Store them securely and rotate them if compromised.

For API-level details, see the [API guide](https://www.dsiloed.com/apps/apiguide/index.html).
