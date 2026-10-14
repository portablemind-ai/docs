# Automind

Automind answers your direct messages and @mentions for you while you're away. It replies **as you**, and every reply it sends is marked with the agent icon so people can tell it wasn't typed by you. Notifications for its replies read **Your Name · Automind**.

You're "away" when you haven't used Portablemind for about 3 minutes — the same signal push notifications use. As soon as you're back, Automind steps aside.

## What it does

When someone messages you or @mentions you while you're away, Automind:

1. **Answers what it can** — using your work in Portablemind and your [How I work](#how-i-work) instructions.
2. **Otherwise tells the person you'll get back to them**, and messages you in your private **Automind** conversation with what they asked.
3. **Relays your answer.** Reply in your Automind conversation to tell it what to do, and it passes your answer back to the person who asked.

You'll find your Automind conversation in Team Chat, or open it from **Settings → Automind**. Each item under **Recent activity** there shows who asked, what Automind did, and a link to see it.

## Turn it on

1. Open **Settings → Automind**.
2. Switch on **Turn on Automind**.

It's saved as soon as you switch it. While it's on you'll see *On — works while you're away*.

### Pause it

When it's on, you can pause it without turning it off:

- **Pause 1 hour**
- **Pause until tomorrow** — until 8:00am tomorrow, your time.

While paused you'll see when it starts again, and a **Resume** button to start it straight away.

## Choose a model

Pick the AI model Automind uses under **Model**. Leave it on **Default** to use your workspace's default model. Automind runs as you, so its work counts towards your own usage.

## How I work

**How I work** is optional: standing instructions Automind follows every time — who to prioritise, what it may answer on its own, and what to always ask you about. For example:

- Answer Rick's questions about releases yourself.
- Anything about pricing, ask me first.
- Keep replies short.

Click **AI Assist** to have AI draft or improve your instructions, then **Save**.

## What it never does without asking

Automind always checks with you before it:

- commits you to a **date or deadline**
- agrees to anything involving **money**
- accepts or books a **meeting**
- sends **email outside your workspace**

It also never answers another person's Automind, so two people who are both away don't end up in a loop of automatic replies.

## Coding with SiloLink (optional)

If you write code with [SiloLink](coding-agents.md), Automind can hand coding work to a Claude Code session you've set up — and keep it going until it's done, the way a teammate would.

1. **Set up SiloLink and create a SiloLink channel in Team Chat.** See [Launching a session from Portablemind](coding-agents.md#launching-a-session-from-portablemind).
2. **Pick that channel in Settings → Automind**, under **Coding (SiloLink)**.
3. **Give it work.** Tell Automind what to work on in your Automind conversation, or let it pick up a code change someone asks you for. It sends the task to the session, checks each report, sends the next step (fix what failed, run the tests) until the work is done, then tells you and the person who asked.

**What it checks with you first.** By default: anything touching production, merging or deploying to shared branches, and spending money. Change that in **How I work**: for example, "Merging to development and deploying DEV is fine; never touch production."

**A safety stop.** If a session goes back and forth with Automind more than 20 times in an hour, Automind pauses and tells you, so a task that never finishes can't keep running up costs.

If you don't write code, leave it on **None — no coding work**.
