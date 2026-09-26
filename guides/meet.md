# Video Meetings (Meet)

Meet is video meetings inside Portablemind. Start a meeting from the app, invite your teammates, share your screen, and talk in a meeting chat that's kept with the rest of your work — where your [AI agents](agents.md) can join in when you @mention them.

## Who can use Meet

**Meet** appears in the app switcher only when all three of these are true:

| Requirement | Who decides |
|---|---|
| **Your plan includes video meetings.** Meet is part of the Professional plan and above. | Your plan — see [Meeting minutes](#meeting-minutes-and-billing) below |
| **You have Meet access** — the **Meet (Video) Access** security role. | Your workspace administrator grants it, person by person |
| **Your workspace has a video account to run meetings on** — its own Twilio account connected in the [Communications Hub](communications-hub.md#twilio-video-setup), or the platform's Twilio account where that has been made available to your workspace. | Your workspace administrator |

If any of them is missing, Meet simply doesn't appear.

> **Tip:** if a teammate can't find Meet, check their security roles first — administrators grant **Meet (Video) Access** by assigning that security role to the person in the Administration area.

## Starting or joining a meeting

**To start a meeting**, open **Meet** from the app switcher and click **Join**. Meet fills in a new, unique room name for you (something like `huddle-k7q2x9mfa3`), so nobody else can take the room before you — click **New meeting** for a different one, or type your own name. Room names ignore case and punctuation — "Team Sync" and "team-sync" are the same room — and a name made only of symbols is refused. When you click **Join**, your browser asks for your camera and microphone first (the first time), then Meet connects. The person who starts a meeting is its **host**.

**To join someone else's meeting**, open the invitation notification or the link they sent you: Meet opens with their room already filled in, and you click **Join**.

A meeting under way is private to the people in it: to come in, you must be **invited** (see below). If you try to join a meeting in progress that you weren't invited to, Meet tells you who is hosting it, so you can ask them to invite you.

## Inviting people

While you're in a meeting, click **Invite** at the top of the meeting chat and pick people from your workspace. Anyone without Meet access is shown but can't be picked — an administrator needs to grant them the role first. Click **Invite** and they're added to the meeting and its chat, which is what lets them in while it's under way.

Each person you invite gets a notification — **"… invited you to a meeting"** — that opens Meet with the meeting's room filled in; they click **Join**. You can also click **Copy link** and send the link yourself, for example in a chat. (If your browser won't copy it, Meet shows the link for you to copy by hand.)

People from other organizations and guests can't be invited to meetings yet.

## The meeting chat

Every meeting has its own chat beside the video. Use it to share links and notes while you talk; the chat is saved, so it's still there after the meeting ends.

- **Meeting events** — who joined, who left, when the meeting started and ended — appear in the chat as small event markers, so the record reads as a timeline.
- **AI agents** — type `@` and pick an agent to bring it into the conversation, exactly as you would in [Chat & the AI Assistant](ai-assistant.md).

## During the meeting

| Control | What it does |
|---|---|
| **Microphone** | Mute or unmute yourself |
| **Camera** | Turn your video off or on |
| **Share screen** | Share a screen, window or tab. While someone is sharing, their screen takes the main area and everyone's video moves to a strip above it. One person shares at a time — the button is disabled while someone else is presenting |
| **Leave** | Leave the meeting. You can **Rejoin** from the same screen |

If your connection drops, Meet shows **Reconnecting…** while it tries to recover. If it can't, it says the connection was lost and offers **Rejoin**.

If you join the same meeting from a second tab or device, the first one is closed automatically — you're only ever in a meeting once.

## Meeting minutes and billing

Meetings are measured in **participant-minutes**: one person connected for one minute. A 30-minute meeting with four people uses 120 participant-minutes.

Each plan includes a monthly allowance, shared by everyone in your workspace:

| Plan | Participant-minutes per month |
|---|---|
| Free | Not included |
| Starter | Not included |
| Professional | 1,000 |
| Business | 5,000 |
| Enterprise | 20,000 |

The allowance resets at the start of each month. When Meet shows you the join screen, it also shows how many minutes your workspace has left.

**Which Twilio account a meeting runs on decides whether it also uses tokens:**

- **Your own Twilio account** (connected in the [Communications Hub](communications-hub.md#twilio-video-setup)) — Twilio bills you directly for the video, and meetings cost **no tokens**. Your plan's minute allowance still applies.
- **The platform's Twilio account** — each participant-minute also draws on your workspace's [token balance](plans-and-limits.md#ai-tokens), alongside the minute allowance: the tokens worth **1¢ (US) per participant-minute**, converted at the same rate as your AI usage. The 30-minute, four-person meeting above (120 participant-minutes) draws the tokens worth $1.20.

If your workspace has connected its own account, meetings always use it.

## When Meet can't start your meeting

When you click **Join**, Meet explains anything that stops you, with a button that fixes it where there is one:

| Message | What it means | What to do |
|---|---|---|
| **Your workspace has used all of its meeting minutes for this month** | The monthly participant-minute allowance is used up | **Upgrade plan** for more minutes, or wait for next month |
| **Your workspace is out of tokens** | Meetings on the platform's Twilio account draw on your token balance, and it's empty | **Buy tokens** — or connect your own Twilio account, which uses no tokens |
| **This meeting is in progress** (naming its host) | The room has a meeting under way that you're not part of | Ask the host, or anyone in the meeting, to invite you |

A meeting that is already running is **ended** if your workspace runs out of meeting minutes — or, on the platform's Twilio account, out of tokens. This is checked every few minutes, so a meeting can run a few minutes past the moment the allowance or balance reaches zero. Everyone in it sees **"The meeting ended because your workspace ran out of meeting minutes"** (or **"…ran out of tokens"**) with the same **Upgrade plan** / **Buy tokens** button, and the meeting chat records why it ended. Joining again is refused until the minutes or tokens are topped up.

If something changed since Meet appeared — your plan, your Meet access, or your workspace's video account — or you open a Meet link in a workspace that can't run meetings yet, the join screen says which it is (**not included in your workspace's plan**, **you don't have access to Meet**, or **isn't set up for this workspace yet**) instead of starting the meeting. See [Who can use Meet](#who-can-use-meet) for what each one needs.
