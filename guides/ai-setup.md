# Setting Up AI Models

Portablemind's AI features — the [AI Assistant](ai-assistant.md), [AI agents](agents.md), memory, and document analysis — are powered by Large Language Models (LLMs). Before anyone in your workspace can use them, you connect at least one AI provider and configure a model.

Portablemind supports models from Anthropic (Claude), OpenAI (GPT), Google (Gemini), and xAI (Grok), as well as local models served through Ollama. You bring your own provider API key, so you stay in control of billing and usage. This page walks through obtaining a key from each provider and configuring models in Portablemind.

## Choose your provider

Which provider you start with depends on your priorities:

| Provider | Models | Good to know |
|---|---|---|
| Anthropic | Claude family | Strong reasoning and long-context work; pay-as-you-go credits |
| OpenAI | GPT and o-series | Broad general-purpose lineup; pay-as-you-go pricing per model |
| Google | Gemini family | Very large context windows; free tier with generous limits |
| xAI | Grok family | Strong reasoning with a real-time information focus; monthly free credits |
| Ollama | Llama, Mistral, Qwen, and other open models | Runs on your own hardware — private, offline-capable, no API key |
| AWS Bedrock | Claude, Nova, Llama, Mistral, Qwen | One AWS account covers every model; billed through AWS — see [Connecting AWS Bedrock](bedrock-setup.md) |
| Google Vertex AI | Claude, Gemini, open models | One Google Cloud project covers every model; billed through GCP — see [Connecting Google Vertex AI](vertex-setup.md) |

You can configure models from multiple providers side by side and choose between them per conversation or per agent.

> **Note:** AWS Bedrock and Google Vertex AI work differently from the rest. Instead of a per-model API key, each uses a single workspace-level connection to your cloud account, shared by every model it serves. They have their own setup guides — [Bedrock](bedrock-setup.md) and [Vertex](vertex-setup.md) — and the rest of this page does not apply to them.

## Get a provider API key

The steps below happen on each provider's own website, not in Portablemind. Once you have a key, jump to [Configure a model](#configure-a-model-in-portablemind).

> **Warning:** Treat API keys like passwords. Most providers show the full key only once at creation — copy it somewhere safe, never share it publicly, and never commit it to version control.

### Anthropic (Claude)

1. Go to [console.anthropic.com](https://console.anthropic.com) and sign up for an account if you don't have one.
2. Navigate to the API Keys section and click "Create Key". Give it a descriptive name (e.g., "Portablemind Integration") and copy the generated key — it starts with `sk-ant-`.
3. Add credits to your Anthropic account. Even a small amount ($5–10) provides substantial usage for getting started.

### OpenAI (GPT)

1. Go to [platform.openai.com](https://platform.openai.com) and sign up or log in.
2. In the API Keys section of your account settings, click "Create new secret key", name it (e.g., "Portablemind Integration"), and copy the key — it starts with `sk-`. You won't be able to see it again.
3. Add credits to your account. OpenAI uses pay-as-you-go pricing with different rates for each model.

### Google (Gemini)

1. Go to [Google AI Studio](https://makersuite.google.com/app/apikey) and sign in with your Google account.
2. Click "Create API Key", select a project (or create a new one), and copy the generated key.
3. Make sure the Generative Language API is enabled for your project in the Google Cloud Console.

> **Note:** The Gemini API has a free tier with generous limits for development and testing.

### xAI (Grok)

1. Go to [console.x.ai](https://console.x.ai) and sign up or log in.
2. Open the API Keys section, click "Create API key", name it, and copy the key — it starts with `xai-`. The full key isn't viewable again after creation.
3. xAI provides $25 in free credits every month, which is generous for development and testing. You can add more through the billing section if needed.

### Ollama (local models)

Ollama runs open models on your own hardware, giving you privacy and offline capability with no API key required.

1. Download and install Ollama from [ollama.ai](https://ollama.ai) for your operating system:

```bash
# macOS/Linux
curl -fsSL https://ollama.ai/install.sh | sh

# Windows — download the installer from ollama.ai
```

2. Pull the models you want to use:

```bash
ollama pull llama3.2:3b
ollama pull mistral
ollama pull qwen2.5:7b
```

3. Ollama runs as a local API server on port 11434 and starts automatically after installation. Verify it's running with `ollama list`.

> **Tip:** Start with smaller models (1–4 GB) if you have limited RAM. Larger mixture-of-experts models can require 26 GB or more.

## Configure a model in Portablemind

Model configuration lives in **AI Studio**, Portablemind's home for AI model, agent, and prompt configuration — specifically the **LLM Models** section, under **Models & Tools** in AI Studio's navigation panel. Creating a model (the **New Model** button) connects your provider key to a specific model so it can be used across the platform.

```recording
title: Add a provider API key and configure a model
src: https://www.dsiloed.com/api/v1/public/llm_files/2087/raw?key=4006ad2fce1ac9a5aeb91214afdb1336
```

When you create a model, you:

1. **Select a provider**, then choose from that provider's pre-configured model types. Each model type comes with its specifications — description, context window, and pricing — already filled in, so you don't need to look them up. Providers typically offer a range of tiers: flagship models for the hardest work (Claude Opus, GPT-4-class, Gemini Pro, the latest Grok), balanced mid-tier models, and fast, inexpensive models for high-volume tasks (Claude Haiku, GPT mini variants, Gemini Flash).
2. **Enter your API key** for that provider. For Ollama there's no key — instead you enter the host and port of your Ollama server (e.g., `localhost` and `11434` for a local install).
3. **Name the model and set the internal identifier.** The friendly name is what people see; the internal identifier is what you'll use when referencing this model elsewhere in the platform (for example, in agent configuration or settings that ask for a model name). It's auto-generated from the name if you leave it blank, or you can customize it.
4. **Save.** The model is available immediately throughout Portablemind, with consistent pricing, context window, and capability information carried over from the model type you selected.

> **Note:** Model configuration is workspace-wide — once a model is created it powers AI features for your whole workspace, and its usage is billed to the provider key you supplied. Portablemind tracks per-message token usage and cost for every configured model, so you can see exactly what your AI spend looks like.

## Keeping AI spend down

Most of what you pay a provider is for **input** — the conversation the model has to read before it can answer. Two things reduce that, and Portablemind does both for you:

- **Prompt caching.** Every provider here can recognize that it has already read the opening of a conversation and bill it at a fraction of the normal input rate — typically a 50–90% discount depending on the provider. Portablemind lays each request out so the reusable part stays identical between turns, which is what makes the discount apply. You'll see this in the cost tracking as cached input; healthy long-running workspaces read a large share of their input from cache rather than paying full price for it.
- **Context windowing.** Very long conversations don't get sent in full. Older messages and older attachments are summarized or referenced instead of re-read every turn — see [Chat & the AI Assistant](ai-assistant.md) for what you'll notice as a user.

Two things that are up to you:

- **Match the model to the job.** Provider line-ups run from flagship models to fast, inexpensive ones, and the price difference between tiers is large. Routine, high-volume work rarely needs the flagship.
- **Start a new conversation for a new topic.** A fresh conversation has almost nothing to re-read, so it is both the fastest and the cheapest. Keeping one enormous thread going for unrelated questions is the most common avoidable cost.

> **Tip:** Cached input only helps when requests share an opening, so it favours conversations that stay on one topic and turns that happen reasonably close together. A workspace whose cached share is near zero is usually either sending very short prompts (below the provider's minimum cacheable size) or spreading work across many short-lived conversations.

## Who can manage AI configuration

AI Studio is a protected area: access is controlled by Portablemind's capability-based security system, so only users whose security roles grant AI Studio access can add providers, manage API keys, or change model configuration. In practice this is typically your workspace administrators, via AI Studio and the Administration area.

A few practices worth adopting:

- Limit AI configuration access to the people who genuinely need it — the same principle of least privilege that applies to [agent permissions](agents.md).
- If you suspect a provider key has been exposed, rotate it in the provider's console and update the model configuration with the new key.
- Keep an eye on your provider billing dashboards alongside Portablemind's built-in cost tracking.

## Test your setup

Once a model is configured, the quickest test is a conversation: open the [AI Assistant](ai-assistant.md) and send a message. If you've configured multiple models, you can pick which one to chat with.

```recording
title: Test your model in a conversation
src: https://www.dsiloed.com/api/v1/public/llm_files/2088/raw?key=36777ef21f8d6a975119ffe9b7be8e2b
```

With a working model you can now:

- Chat with AI assistants that understand your business context and data — see [AI Assistant](ai-assistant.md).
- Upload and analyze documents in your conversations — see [Files](files.md).
- Build autonomous agents that work on your behalf, on demand or on a schedule — see [Building AI Agents](agents.md).
- Give your AI persistent, long-term memory across sessions — see [Memory](memory.md).
- Extend what your AI can do with reusable skills — see [Skills](skills.md).

Developers can also connect external tools such as Claude Code to a Portablemind workspace via the Model Context Protocol (MCP) — see [Developers](developers.md) and [Coding Agents](coding-agents.md). For API-level details, see the [API guide](https://www.dsiloed.com/apps/apiguide/index.html).
