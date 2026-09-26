# Communications Hub

The Communications Hub connects Portablemind conversations to external messaging platforms — Microsoft Teams, Slack, Discord, Twilio SMS, and Twilio Voice — and it's where you connect the Twilio account your [video meetings](meet.md) run on. Once configured, messages flow bidirectionally: when someone sends a message in Teams or Slack, it appears in the linked Portablemind conversation. When an AI agent or user replies in Portablemind, the response is delivered back to the external platform.

This enables powerful workflows: a customer can text your Twilio number and get an AI-powered response, your team can interact with [AI agents](agents.md) directly in their Teams or Slack channels, and all conversations are centralized in Portablemind with full history, analytics, and agent capabilities.

> **Note:** **Multi-tenant by design.** Each tenant gets their own isolated channel instances with their own credentials. A single Hub deployment serves all tenants securely — your channels, credentials, and messages are never visible to any other tenant.

## How it works

| Step | What happens |
|------|--------------|
| 1 | **Platform setup** — Register a bot or app on the external platform (Teams, Slack, Discord, or Twilio) |
| 2 | **Store credentials** — Save the platform credentials in the channel's setup wizard in Portablemind (**Administration → Communications Hub → Manage**) |
| 3 | **Hub connects** — The Hub automatically detects new credentials and connects to the platform |
| 4 | **Link channels** — Use Portablemind to link external channels/conversations to Portablemind conversations |
| 5 | **Messages flow** — Inbound and outbound messages are automatically routed between platforms and Portablemind |

### The Manage page

All in-app configuration lives on one screen: **Administration → Communications Hub → Manage**. The page shows a tile for each channel — **Slack, Teams, Discord, SMS, Voice, Video** — with a status dot (grey = not configured, orange = configured but disabled, green = enabled). The Hub itself must be switched on first via **Get Started**; it's available on qualifying plan tiers, and the page shows an upgrade prompt if your current plan doesn't include it.

Clicking a channel tile opens that channel's **setup wizard**: numbered setup steps for the external platform, your tenant's exact webhook URLs with copy buttons, and a credential form. **Save & Enable** turns the channel on; **Disable Channel** turns it off while preserving the saved credentials.

### Supported channels

| Channel | What it covers |
|---------|----------------|
| Microsoft Teams | Team channels and 1:1 chats |
| Slack | Public and private channels, DMs |
| Discord | Server text channels |
| Twilio SMS | Inbound and outbound text messages |
| Twilio Voice | AI-powered voice calls with context enrichment |
| Twilio Video | The account your [Meet video meetings](meet.md) run on |

## Finding your tenant ID

Throughout this guide, webhook URLs include your **tenant ID** — the numeric ID of your tenant in Portablemind. You don't need to hunt for it: each channel's setup wizard (**Administration → Communications Hub → Manage**, then click the channel tile) displays the exact, ready-to-paste webhook URLs for your tenant, with copy buttons. For API-level details, see the [API guide](https://www.dsiloed.com/apps/apiguide/index.html).

> **Warning:** All webhook URLs in this guide use the format `https://hub.portablemind.ai/webhooks/<channel>/<tenant_id>/...`. Replace `<tenant_id>` with your actual tenant ID (e.g., `22`).

## AI agent display names

When AI agents reply from Portablemind, the Hub can display the agent's name instead of the generic bot name on platforms that support it (currently Slack). For example, if you have an agent named "Dilbert", their replies in Slack will show "Dilbert" as the sender rather than "Portablemind Bot".

This happens automatically — no extra configuration needed. The agent's display name is passed through with the outbound message.

## Microsoft Teams setup

Connecting Microsoft Teams requires creating an Azure Bot and a Teams App Package. This is the most involved setup of the channels, but each step is straightforward.

### Step 1: Create an Azure App Registration

> **Tip:** If you already have an Azure App Registration for a bot, skip to Step 2.

1. Go to [Azure Portal → App registrations](https://portal.azure.com/#view/Microsoft_AAD_RegisteredApps/ApplicationsListBlade)
2. Click **New registration**
3. Name: choose something descriptive (e.g., "Portablemind Bot")
4. Supported account types: **Accounts in any organizational directory (Multitenant)**
5. Redirect URI: leave blank for now
6. Click **Register**
7. On the app's Overview page, copy these two values — you'll need them later:

| Value | Used as |
|-------|---------|
| Application (client) ID | Your `bot_id` |
| Directory (tenant) ID | Your Azure `tenant_id` |

### Step 2: Create a client secret

1. In your app registration, go to **Certificates & secrets**
2. Click **New client secret**
3. Add a description (e.g., "Portablemind Hub") and choose an expiry period
4. Click **Add**
5. **Copy the Value immediately** — it will only be shown once. This is your `bot_password`.

> **Warning:** Set a reminder to rotate the client secret before it expires. When it expires, your Teams integration will stop working.

### Step 3: Create an Azure Bot resource

1. Go to [Azure Portal → Create a resource → Azure Bot](https://portal.azure.com/#create/Microsoft.AzureBot)
2. Bot handle: choose a unique name
3. Pricing tier: Free (F0) is fine for getting started
4. Type of App: **Multi Tenant**
5. Creation type: **Use existing app registration**
6. App ID: paste your **Application (client) ID** from Step 1
7. Click **Review + create**, then **Create**

### Step 4: Set the messaging endpoint

1. Open your Azure Bot resource and go to **Configuration**
2. Set **Messaging endpoint** to:

```bash
https://hub.portablemind.ai/webhooks/msteams/YOUR_TENANT_ID/messages
```

Replace `YOUR_TENANT_ID` with your Portablemind tenant ID, then click **Apply**.

### Step 5: Enable the Teams channel

1. In your Azure Bot resource, go to **Channels**
2. Click **Microsoft Teams**
3. Accept the terms and click **Apply**

### Step 6: Add Graph API permission (for channel discovery)

This permission allows Portablemind to list your Teams channels when linking conversations.

1. Go back to your **App registration** → **API permissions**
2. Click **Add a permission** → **Microsoft Graph** → **Application permissions**
3. Search for and add: `Channel.ReadBasic.All`
4. Click **Grant admin consent** (requires admin privileges)

### Step 7: Find your Team ID

The Team ID is needed for channel discovery. To find it:

1. In Microsoft Teams, click the **…** (three dots) next to your team name
2. Select **Get link to team**
3. The URL contains your Team ID as the `groupId` parameter:

```bash
https://teams.microsoft.com/l/team/...?groupId=97d8107a-2d4f-4280-84d2-ed0a3dd0051d&tenantId=...
```

The `groupId` value is your Team ID. If you have multiple teams, comma-separate their IDs.

### Step 8: Sideload the Teams app

You need a Teams App Package (a .zip file) to install the bot in your Teams tenant.

1. Create a `manifest.json` file with your bot's Application (client) ID
2. Include two icon files (color icon 192x192, outline icon 32x32)
3. Zip all three files together
4. In Teams, go to **Apps** → **Manage your apps** → **Upload an app** → **Upload a custom app**
5. Select your .zip file and install it

For a complete manifest.json template, see the [Teams manifest schema documentation](https://learn.microsoft.com/en-us/microsoftteams/platform/resources/schema/manifest-schema).

### Step 9: Store credentials in Portablemind

Save the following in the **Teams** channel's setup wizard (**Administration → Communications Hub → Manage** → Teams tile), then click **Save & Enable**:

| Field | Value | Where to find it |
|-------|-------|------------------|
| `bot_id` | Application (client) ID | Azure App Registration → Overview |
| `bot_password` | Client secret value | Azure App Registration → Certificates & secrets |
| `tenant_id` | Directory (tenant) ID | Azure App Registration → Overview |
| `service_url` | `https://smba.trafficmanager.net/teams/` | Default value — rarely changes |
| `team_ids` | Your Team ID(s) | Teams → Get link to team → `groupId` |

> **Note:** **Teams @mention requirement:** in team channels, the bot only receives messages when @mentioned. In 1:1 chats, all messages are received automatically.

```recording
title: Store channel credentials in Portablemind
src: https://www.dsiloed.com/api/v1/public/llm_files/2167/raw?key=b9da2bc59e725fcd036419249b89bf82
```

## Slack setup

> **Tip:** The fastest path is in-app: open the **Slack** tile in **Administration → Communications Hub → Manage** and click **Add to Slack** to authorize the connection via OAuth — no manual app creation needed. The manual steps below remain available in the wizard under **Advanced: Manual Setup**.

Connecting Slack manually involves creating a Slack App, adding the right permissions, and configuring event subscriptions so Slack notifies the Hub when messages arrive.

### Step 1: Create a Slack App

1. Go to [api.slack.com/apps](https://api.slack.com/apps)
2. Click **Create New App** → **From scratch**
3. Give your app a name (e.g., "Portablemind Bot") and select your workspace
4. Click **Create App**

### Step 2: Add bot token scopes

Go to **OAuth & Permissions** in the sidebar, scroll to **Scopes**, and add these **Bot Token Scopes**:

| Scope | Purpose |
|-------|---------|
| `chat:write` | Send messages to channels |
| `chat:write.customize` | Display AI agent names instead of bot name on replies |
| `channels:read` | List public channels (for channel discovery in Portablemind) |
| `channels:history` | Read messages in public channels the bot is in |
| `groups:read` | List private channels (for channel discovery) |
| `groups:history` | Read messages in private channels the bot is in |
| `im:history` | Read direct messages to the bot |
| `files:read` | Access files shared in conversations |
| `users:read` | Resolve user information |

### Step 3: Install the app to your workspace

1. Still on **OAuth & Permissions**, scroll up and click **Install to Workspace**
2. Review the permissions and click **Allow**
3. Copy the **Bot User OAuth Token** (starts with `xoxb-`) — this is your `slack_bot_token`

### Step 4: Get the signing secret

1. Go to **Basic Information** in the sidebar
2. Under **App Credentials**, copy the **Signing Secret** — this is your `slack_signing_secret`

### Step 5: Enable event subscriptions

1. Go to **Event Subscriptions** in the sidebar and toggle it **ON**
2. Set the **Request URL** to:

```bash
https://hub.portablemind.ai/webhooks/slack/YOUR_TENANT_ID/events
```

Slack will send a verification challenge — the Hub responds automatically. You should see a green "Verified" checkmark.

3. Expand **Subscribe to bot events** and click **Add Bot User Event** for each:

| Event | Description |
|-------|-------------|
| `message.channels` | Messages in public channels the bot is in |
| `message.groups` | Messages in private channels the bot is in |
| `message.im` | Direct messages to the bot |

4. Click **Save Changes**

> **Warning:** **Without these events, inbound messages will not work.** Outbound messages (Portablemind → Slack) will still function, but Slack won't notify the Hub when users send messages in channels.

### Step 6: Store credentials in Portablemind

Save the following in the **Slack** channel's setup wizard (**Administration → Communications Hub → Manage** → Slack tile → **Advanced: Manual Setup**), then click **Save & Enable**:

| Field | Value | Where to find it |
|-------|-------|------------------|
| `slack_bot_token` | Bot User OAuth Token (`xoxb-...`) | OAuth & Permissions page |
| `slack_signing_secret` | Signing Secret | Basic Information → App Credentials |

### Step 7: Invite the bot to channels

> **Warning:** You can link any visible Slack channel to a Portablemind conversation, but the bot can only **send and receive messages** in channels where it has been invited.

To invite the bot to a channel, open the Slack channel and type `/invite @YourBotName`. The bot will now receive messages and can respond in that channel.

**Recommended workflow:** link the channel in Portablemind first, then invite the bot in Slack. Unlike Teams, the bot receives *all* messages in a channel — no @mention required.

```recording
title: Connect a Slack channel
src: https://www.dsiloed.com/api/v1/public/llm_files/2170/raw?key=609ca024dd9e1b526619fdc2996a70eb
```

## Discord setup

Discord integration connects text channels in your Discord server to Portablemind conversations. The bot listens for messages via Discord's Gateway (WebSocket) connection.

### Step 1: Create a Discord application

1. Go to the [Discord Developer Portal](https://discord.com/developers/applications)
2. Click **New Application**
3. Name it (e.g., "Portablemind Bot") and click **Create**

### Step 2: Add a bot

1. Go to the **Bot** section in the sidebar
2. Click **Reset Token** and **copy the token immediately** — this is your `bot_token`
3. Under **Privileged Gateway Intents**, enable **Message Content Intent**
4. Click **Save Changes**

> **Warning:** The bot token is only shown once when you reset it. If you lose it, you'll need to reset it again (which invalidates the old token).

### Step 3: Invite the bot to your server

1. Go to **OAuth2** → **URL Generator** in the sidebar
2. Under **Scopes**, check `bot`
3. Under **Bot Permissions**, check `Send Messages`, `Read Message History`, and `View Channels`
4. Copy the generated URL at the bottom, open it in your browser, and select the server to add the bot to

### Step 4: Get the server (guild) ID

1. In Discord, go to **User Settings** → **Advanced** → enable **Developer Mode**
2. Right-click on your server name in the sidebar
3. Click **Copy Server ID** — this is your `guild_id`

### Step 5: Store credentials in Portablemind

Save the following in the **Discord** channel's setup wizard (**Administration → Communications Hub → Manage** → Discord tile), then click **Save & Enable**:

| Field | Value | Where to find it |
|-------|-------|------------------|
| `bot_token` | Bot token | Developer Portal → Bot → Reset Token |
| `guild_id` | Server (Guild) ID | Right-click server → Copy Server ID |

> **Note:** Unlike Slack and Teams, the Discord bot receives **all messages in all text channels** it has access to — no invite or @mention required.

## Twilio SMS setup

Twilio SMS enables your Portablemind conversations to send and receive text messages. When someone texts your Twilio number, the message appears in the linked Portablemind conversation. If no conversation is linked, one is created automatically.

### Step 1: Get your Twilio credentials

1. Log in to the [Twilio Console](https://console.twilio.com/)
2. On the dashboard, find and copy:

| Value | Notes |
|-------|-------|
| Account SID | Starts with `AC` — this is your `twilio_account_sid` |
| Auth Token | Click to reveal — this is your `twilio_auth_token` |

### Step 2: Get a phone number

1. In Twilio Console, go to **Phone Numbers** → **Manage** → **Buy a number**
2. Choose a number with **SMS** capability
3. Note the number in E.164 format (e.g., `+18005551234`) — this is your `twilio_phone_number`

### Step 3: Configure Twilio webhooks

1. Go to **Phone Numbers** → **Manage** → **Active Numbers** → click your number
2. Under **Messaging**, set:

| Setting | Value |
|---------|-------|
| A message comes in | **Webhook**, POST, `https://hub.portablemind.ai/webhooks/twilio/YOUR_TENANT_ID/sms/inbound` |
| Status callback URL | `https://hub.portablemind.ai/webhooks/twilio/YOUR_TENANT_ID/sms/status` |

3. Click **Save**

### Step 4: Store credentials in Portablemind

Save the following in the **SMS** channel's setup wizard (**Administration → Communications Hub → Manage** → SMS tile), then click **Save & Enable**:

| Field | Value | Where to find it |
|-------|-------|------------------|
| `twilio_account_sid` | Account SID (`AC...`) | Twilio Console → Dashboard |
| `twilio_auth_token` | Auth Token | Twilio Console → Dashboard |
| `twilio_phone_number` | E.164 format (e.g., `+18005551234`) | Twilio Console → Phone Numbers |
| `domain` | `hub.portablemind.ai` | Hostname only — no `https://` |

> **Warning:** The `domain` must be the hostname only (e.g., `hub.portablemind.ai`), not a full URL. The Hub adds `https://` automatically.

### Auto-created conversations

When an SMS arrives from a phone number that isn't linked to any Portablemind conversation, the system **automatically creates a new conversation** and links it. The conversation is named `twilio-sms-+18005551234` with the phone number in the description. Future messages from the same number route to the same conversation.

### Outbound SMS registration requirements

> **Note:** US carriers require registration for outbound SMS. Without it, outbound messages may be blocked.
>
> - **Local numbers (10DLC):** requires A2P campaign registration (Brand + Campaign) — 3-7 business days
> - **Toll-free numbers:** requires toll-free verification — 1-3 business days
>
> Inbound SMS works immediately regardless of registration status. Trial accounts can only send to verified caller IDs.

## Twilio Voice setup

Twilio Voice provides an AI-powered voice agent that answers inbound calls with real-time speech recognition and text-to-speech. The agent can look up caller context from Portablemind (who is calling, their history, open projects) and perform mid-call data lookups triggered by natural language.

Voice uses the same Twilio account and phone number as SMS. If you've already set up SMS, you just need to add the voice webhook and a few extra configuration values.

### Step 1: Configure the voice webhook

1. In the [Twilio Console](https://console.twilio.com/), go to **Phone Numbers** → **Manage** → **Active Numbers** → click your number
2. Under **Voice & Fax**, set:

| Setting | Value |
|---------|-------|
| A call comes in | **Webhook**, HTTP POST, `https://hub.portablemind.ai/webhooks/twilio/YOUR_TENANT_ID/voice/twiml` |

3. Click **Save**

### Step 2: Get an OpenAI API key

The voice agent uses a fast OpenAI model (GPT-4o-mini by default) for real-time responses during calls. This is separate from the LLM models used in Portablemind conversations.

1. Go to [OpenAI API Keys](https://platform.openai.com/api-keys)
2. Create a new key and copy it

### Step 3: Store credentials in Portablemind

Save the following in the **Voice** channel's setup wizard (**Administration → Communications Hub → Manage** → Voice tile), then click **Save & Enable**:

| Field | Value | Notes |
|-------|-------|-------|
| `twilio_account_sid` | Account SID | Same as SMS |
| `twilio_auth_token` | Auth Token | Same as SMS |
| `twilio_phone_number` | Phone number | Same as SMS (E.164 format) |
| `domain` | `hub.portablemind.ai` | Hostname only |
| `openai_api_key` | Your OpenAI API key | For fast voice responses |
| `openai_model` | `gpt-4o-mini` | Default — fast and cost-effective |
| `tts_provider` | `ElevenLabs` | Text-to-speech provider |
| `tts_voice_id` | ElevenLabs voice ID | Optional — uses default voice if empty |
| `welcome_greeting` | Your greeting message | What the bot says when answering |
| `context_provider` | `portablemind` | Enables caller context enrichment |

### Voice + SMS shared conversations

Voice and SMS share the same conversation for a given phone number. When a caller's phone number is mapped to an SMS conversation, voice calls from that number will load the same conversation context and post transcripts to the same thread.

### Caller context enrichment

When the context provider is enabled, the voice agent automatically looks up the caller's phone number in Portablemind to find who they are, what projects they're associated with, and any relevant history. This context is injected into the AI prompt so the agent can greet the caller by name and have informed conversations.

## Twilio Video setup

The **Video** channel connects your own Twilio account to [Meet](meet.md). With it, your meetings run on your Twilio account: Twilio bills you for the video directly, and meetings use **no tokens** from your balance (your plan's monthly meeting minutes still apply — see [Meeting minutes and billing](meet.md#meeting-minutes-and-billing)).

Video can use the same Twilio account as SMS and Voice. Unlike them, it needs no phone number and no webhook: rooms, access and meeting status are all set up automatically.

### Step 1: Get your Account SID and Auth Token

1. Log in to the [Twilio Console](https://console.twilio.com/)
2. On the dashboard, under **Account Info**, copy:

| Value | Notes |
|-------|-------|
| Account SID | Starts with `AC` |
| Auth Token | Click to reveal. Used to verify the meeting status updates Twilio sends |

If you've already set up SMS or Voice, the wizard fills these in for you.

### Step 2: Create an API key

Video access uses an API key rather than your Auth Token.

1. In the Twilio Console, go to **Account → API keys & tokens** (from the account menu at the top right)
2. Click **Create API key**
3. Give it a name (e.g., "Portablemind Meet"), leave the key type as **Standard**, and click **Create**
4. Copy the key's **SID** (starts with `SK`) and its **Secret**

> **Warning:** The API key secret is shown **only once**, when the key is created. If you lose it, create a new key and update the Video channel with it.

### Step 3: Store credentials in Portablemind

Save the following in the **Video** channel's setup wizard (**Administration → Communications Hub → Manage** → Video tile), then click **Save & Enable**:

| Field | Value | Where to find it |
|-------|-------|------------------|
| Account SID | `AC...` | Twilio Console → Dashboard → Account Info |
| Auth Token | Auth Token | Twilio Console → Dashboard → Account Info |
| API Key SID | `SK...` | Twilio Console → Account → API keys & tokens |
| API Key Secret | The key's secret | Shown once, when you create the API key |

Meetings started after you save use your account. To go back, click **Disable Channel** in the same wizard — your credentials are kept.

## Linking channels to conversations

After setting up credentials, you link external channels to specific Portablemind conversations. This determines which conversation receives messages from which external channel.

Linking happens from the conversation's **Channel Details** dialog, on its **External Channels** tab: you add a mapping, choosing the external system and resource type, then selecting the specific external channel:

| Resource type | How it works |
|---------------|--------------|
| **Discord channels** | Search and select a channel from your Discord server |
| **Slack channels** | Search and select a channel from your Slack workspace |
| **Teams conversations** | Search and select a channel from your Teams team |
| **SMS conversations** | Enter a phone number in E.164 format (e.g., `+18005551234`) |

Once the mapping is saved, messages flow in both directions. Any [AI agents](agents.md) in the conversation participate just as they do in the [AI Assistant](ai-assistant.md) — external users are effectively chatting with them from Teams, Slack, Discord, or SMS.

```recording
title: Link an external channel to a conversation
src: https://www.dsiloed.com/api/v1/public/llm_files/2172/raw?key=1b81e85dd4dddb240c78e72192712d83
```

### Cross-channel bridging

A single Portablemind conversation can be linked to **multiple external channels** across different platforms. When a message arrives on any linked channel, it is **fanned out to all other linked channels** on the same conversation. This means a Discord message will appear in Teams and Slack, and vice versa.

### Webhook URL reference

These are the webhook URLs used by each channel (replace `YOUR_TENANT_ID` with your actual tenant ID):

| Channel | Webhook URL | Where to configure |
|---------|-------------|--------------------|
| Teams | `https://hub.portablemind.ai/webhooks/msteams/YOUR_TENANT_ID/messages` | Azure Bot → Configuration → Messaging endpoint |
| Slack | `https://hub.portablemind.ai/webhooks/slack/YOUR_TENANT_ID/events` | Slack App → Event Subscriptions → Request URL |
| Discord | *No webhook needed — Discord uses a Gateway (WebSocket) connection* | — |
| Twilio SMS | `https://hub.portablemind.ai/webhooks/twilio/YOUR_TENANT_ID/sms/inbound` | Twilio Console → Phone Number → Messaging |
| Twilio Voice | `https://hub.portablemind.ai/webhooks/twilio/YOUR_TENANT_ID/voice/twiml` | Twilio Console → Phone Number → Voice |
| Twilio Video | *No webhook needed — set automatically for each meeting* | — |

## Troubleshooting

| Problem | Likely cause | Fix |
|---------|--------------|-----|
| Outbound works but inbound doesn't (Slack) | Bot events not subscribed | Add `message.channels`, `message.groups`, `message.im` in Event Subscriptions |
| Outbound works but inbound doesn't (Teams) | Messaging endpoint not set or wrong tenant ID | Check Azure Bot → Configuration → Messaging endpoint matches your tenant ID |
| Bot doesn't respond in Slack channel | Bot not invited to channel | Type `/invite @BotName` in the Slack channel |
| Bot doesn't respond in Teams channel | Bot not @mentioned | @mention the bot in team channels. 1:1 chats don't need @mentions. |
| No channels found when adding a mapping | Credentials not configured or Hub hasn't refreshed | Verify credentials are saved in Portablemind. The Hub refreshes its channel list every 5 minutes. |
| Slack shows "Your request URL responded with an HTTP error" | Wrong webhook URL format | Use the tenant-scoped URL: `.../webhooks/slack/YOUR_TENANT_ID/events` |
| SMS outbound blocked (error 30034) | A2P registration not complete | Complete 10DLC campaign registration or toll-free verification in Twilio |
| Meet says it isn't set up after you saved the Video channel | Credentials incomplete, or the channel is disabled | Open the **Video** tile and check all four fields are filled in, then **Save & Enable** |
| Azure client secret expired | Teams integration stopped working | Create a new client secret in Azure and update the `bot_password` in your Portablemind channel configuration |
