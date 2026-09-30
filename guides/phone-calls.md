# Phone Calls

Phone calls let you talk to your workspace's AI assistant on the phone. You can **call in** and ask it about your work, or ask one of your [AI agents](agents.md) to **call you** (or someone who has agreed to be called) and report back in chat.

Every call follows the same rules:

- **It's disclosed as an AI call.** Every call an agent places opens with a notice that it's an AI assistant and that the call is transcribed, and that notice can't be removed. Calls into your number are answered with the greeting your workspace sets, which should say the same.
- **It's always transcribed.** What both sides say is written down, turn by turn.
- **Each call becomes a private record** under **Calls** in Team Chat, where the people allowed to see it can read the full transcript.

## Before you start

Phone calling is switched on per workspace, and a few things need to be in place before the first call.

### For workspace administrators

- **A phone number and voice calling for your workspace.** Connecting a number and turning on voice is done together with Portablemind support for now, so contact support to set it up. There isn't a self-serve screen that completes this yet. If your workspace brings its own Twilio account, you can prepare your part first; see [Twilio Voice setup](communications-hub.md#twilio-voice-setup).
- **Outbound calling** (agents placing calls). A separate workspace setting, off until it's turned on. Contact support to turn it on.
- **Which agents can place calls.** Only workspace administrators can give an agent the calling tool, from the agent's tools. An agent without it can't dial anyone, whoever asks.
- **Where agents may call.** Agents can only dial numbers in the allowed areas. By default that's US and Canadian numbers (starting **+1**); it can be narrowed further, for example to a few area codes. Contact support to change it.
- **The longest a call can run.** 15 minutes by default. Contact support to change it.

Outbound calling needs the Communications Hub, which is included from the Professional plan, and calls count towards your plan's monthly call minutes. See [Plans, Limits & Fair Use](plans-and-limits.md) for what your plan includes.

### For everyone: allow AI assistants to call you

An agent can only call you once you've said yes. Under US law, a call made with an AI voice needs the prior consent of the person being called, so the platform refuses any call to a number that has no consent on file — no exceptions.

To give your consent:

1. Open **Settings → Notifications** and stay on the **General** tab.
2. Under **Phone Calls**, switch on **Allow AI assistants to call me**.

It's saved as soon as you switch it — there's no separate Save button. Below the switch you'll see which number (or numbers) it applies to.

**Turn it off at any time.** Switching it off stops agents calling you straight away; an agent that tries is refused.

```recording
title: Allow AI assistants to call you
src:
```

### Put your mobile number on your profile

Agents call the number on your profile, and when you call in, that number is how the assistant knows it's you. Click your name at the top of the app, choose **Edit Profile**, and fill in **Phone Number**. Include the country code — for example `+1 555 123 4567`.

If there's no number on your profile, **Settings → Notifications** tells you: *"Add a phone number to your profile to receive calls."*

### Calling people outside your workspace

An agent can also call someone who isn't a member of your workspace — a customer or a contact — but only once their consent has been recorded, with how they gave it (for example in writing, or on an earlier recorded call). A workspace administrator records it. There's no screen for this yet, so administrators arrange it with Portablemind support.

## Calling in

Dial your workspace's phone number. The AI voice assistant answers with your workspace's greeting; then just talk, as you would to a colleague.

**It recognises you by your number.** If the phone you're calling from matches the **Phone Number** on your profile, the assistant knows who you are and has your work to hand, for example:

- "What tasks are assigned to me?"
- "How is the website redesign project doing?"
- "What did I last text about?" (recent text messages from your number, when your workspace uses SMS too)
- General questions — "What's today's date?", "Can you explain what a purchase order is?"

**Callers it doesn't recognise** — a number that isn't on anyone's profile — aren't told who they are, and the assistant doesn't bring up anyone's tasks, projects or messages.

When you hang up, the call and its transcript appear under **Calls**.

```recording
title: Call your workspace's assistant
src:
```

## Having an agent call you

In a chat with an agent that has the calling tool, just ask it — for example:

> @Colin call me and ask how the demo prep is going

What happens next:

1. **The agent places the call** to the number on your profile.
2. **It opens with a disclosure** — something like *"Hi, this is Colin, an AI assistant calling on behalf of Acme. This call is transcribed."* — with your agent's name and your workspace's. This part can't be skipped or removed; the agent's own greeting only comes after it.
3. **Then the conversation**, following what you asked for.
4. **The agent reports back in the chat** once the call ends — a summary of what was said and anything it learned — and the call appears under **Calls**.

You can ask an agent to call someone else in the same way ("@Colin call Dana and confirm Thursday's meeting"), as long as that person has consented to AI calls.

```recording
title: Ask an agent to call you
src:
```

### When an agent won't place a call

An agent refuses the call, and tells you why, when:

- **there's no consent** for the number — the person hasn't switched on **Allow AI assistants to call me**, and no consent has been recorded for them;
- **the number isn't allowed** — it's outside the areas your workspace may call;
- **outbound calling isn't turned on** for your workspace, or your workspace has used its call minutes for the month;
- **the request isn't clear** — for example, it isn't sure who you mean or what the call is for.

That's intentional. A real phone call to a real person can't be taken back, so the agent errs on the side of not dialling. Fix what it tells you — or be more specific about who to call and why — and ask again.

## Reviewing calls

Open **Team Chat**. In the left-hand panel, **Calls** lists your latest few calls; click **All calls** to see them all.

The **Calls** list shows, for each call:

- **Direction**: **Inbound** (someone called in) or **Outbound** (an agent placed the call)
- **Caller / callee**: the person on the other end, shown by name when their number is on a profile, otherwise by the number
- **Placed by**: for outbound calls, the agent (or person) who placed it
- **Started**: when the call started
- **Duration**: how long it lasted

On a phone, the same details are stacked in each row.

Click a call to open it. At the top you'll see who was on the call, the direction, when it **Started** and **Ended**, its **Duration**, the other side's number (**Caller** or **Called**), your workspace's number (**Our line**), and — for outbound calls — who **Placed by**. Below that is the full **Transcript**: the person on the other end on the left, the voice assistant or agent on the right. The left arrow takes you back to **All calls**.

```recording
title: Review a call and its transcript
src:
```

### Who can see a call

Calls are private. A call can be seen by:

- **workspace administrators** — every call in the workspace;
- **the person on the other end**, when their number is on their workspace profile (and is theirs alone);
- **whoever placed an outbound call** — the agent, or the person, who dialled.

Other members of the workspace don't see it. Calls stay out of your Team Chat channel and direct-message lists and unread counts; they only appear under **Calls**.

## Privacy and retention

- **Transcripts are kept for 90 days** by default, then deleted automatically — the call, its transcript and anything the assistant remembered from it. Your workspace can choose a different period.
- **A workspace administrator can delete a call** sooner — contact support if you need a call removed.
- **You can withdraw consent at any time** by switching off **Allow AI assistants to call me**. It takes effect immediately.
- **Calls have a maximum length** — 15 minutes by default, set by your workspace. The call is ended when it's reached.

## Troubleshooting

**"The agent says it can't call me."**
Check, in this order:

1. **Allow AI assistants to call me** is switched on in **Settings → Notifications**.
2. Your **Phone Number** is on your profile (**Edit Profile**), and it's the phone you want to be called on.
3. Your number is one your workspace is allowed to call — by default only numbers starting **+1** (US and Canada).
4. The agent has the calling tool and outbound calling is turned on for your workspace — if not, ask an administrator.

The agent's reply usually says which of these it was.

**"When I call in, it doesn't recognise me."**
The number on your profile must match the phone you're calling from. A number that's on more than one profile — a shared office line, for example — isn't recognised for anyone, so that nobody hears someone else's work.

**"I don't see Calls in Team Chat."**
**Calls** only appears once you can see at least one call. Administrators always see it.

**"My call isn't in the list yet."**
A call appears once it has ended. If you've just hung up, give it a moment.
