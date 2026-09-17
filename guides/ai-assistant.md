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

Per-message token usage and cost are tracked for every model, so you can see this directly rather than guess at it — see [Setting Up AI Models](ai-setup.md).

## Memory across conversations

Conversations feed the platform's persistent [AI memory](memory.md). Preferences you express, decisions your team makes, and solutions the AI discovers are remembered and recalled in future conversations — so the AI you talk to next week knows what you told it this week. Nothing is required from you; capture and recall are automatic.

## Connecting external systems

Conversations can also receive messages from outside Portablemind through inbound webhooks — for example, a monitoring system posting alerts into a channel, or an external application feeding events into a conversation. A webhook message can even include an `@ai` mention, so an incoming alert can trigger an immediate AI analysis in the thread.

Webhooks are created per conversation and each has a unique URL.

> **Warning:** Webhook URLs contain unique keys and should be treated as sensitive. Store them securely and rotate them if compromised.

For API-level details, see the [API guide](https://www.dsiloed.com/apps/apiguide/index.html).
