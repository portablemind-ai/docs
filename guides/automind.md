# Automind

Automind is your stand-in while you're away. When someone sends you a direct message or @mentions you and you're not at your computer, Automind answers **as you**, and checks with you on anything it shouldn't decide alone.

It isn't an agent. You won't find it in AI Studio and nobody else can add it to a conversation. It's a personal setting: it works with your permissions and your memories, and only for you.

Everything it posts is marked with the agent icon, so people can tell you didn't type it yourself. Notifications for its replies read **Your Name · Automind**.

## When it steps in

Automind only works while you're **away**, meaning you haven't used Portablemind for about 3 minutes. Push notifications to your phone use the same signal.

- **While you're at your computer**, Automind leaves your messages to you, however long you take to answer.
- **Once you step away**, it takes whatever you haven't answered.
- If you come back and reply yourself first, it drops that message.
- A message it has held for more than 12 hours is dropped, not answered late.

It handles **direct messages** and **@mentions** in conversations you're a member of. It doesn't respond to ordinary channel traffic, task assignments, or messages from agents or the system. It ignores messages in your SiloLink channels, because a reply there would be an instruction to your coding session.

## What it does with a message

For each message, Automind does one of three things:

1. **Nothing**, if there's nothing to do: a "thanks", an "ok", or an FYI.
2. **Answers it** when it can. It might answer a factual question, look up a task or project, share a link, or acknowledge something. It replies in that conversation, in your voice, and keeps it brief.
3. **Checks with you** when the message needs you: a decision, an approval, a commitment of your time or money, or anything it isn't sure about. It tells the person you'll get back to them (without promising when) and sends you a note in your **Automind conversation**.

The person who wrote to you is never left without a reply: they get either an answer or a note that you'll get back to them.

## Your Automind conversation

Automind keeps one private conversation with you. Nobody else can see it.

- **Where to find it:** in Team Chat, under its own **Automind** section just below **Starred**. You can also open it from **Settings → Automind**, using **Open your Automind conversation**. It's created the first time you turn Automind on.
- **What it posts there:** notes about anything that needs you. Each note says what happened, what it recommends, and what it needs from you. Its notes reach your phone like an @mention. Notes it marks **Urgent** are reserved for cases where waiting would cause real harm.
- **Your replies are instructions.** Answer a note ("Tell Rick yes, Thursday works") and Automind passes your answer on to the person who asked, then confirms in one line what it sent and where. You can also give it work there unprompted. It acts on what you write even while it's paused, because you're the one asking.

## Turn it on

1. Open **Settings → Automind**.
2. Switch on **Turn on Automind**.

The change saves as soon as you flip the switch. While it's on you'll see *On — works while you're away*. Turning it off stops everything, including work it was holding for later.

### Pause it

When it's on, you can pause it without turning it off:

- **Pause 1 hour**
- **Pause until tomorrow**: until 8:00am tomorrow, your time.

While it's paused you'll see when it starts again, and a **Resume** button to start it right away. While paused, it doesn't answer other people, but it still acts on what you write in your Automind conversation.

## Choose a model

Pick the AI model Automind uses under **Model**. You can choose any model you could pick for an agent. If you leave it on **Default**, Portablemind picks a model that's reliable at using tools, and falls back to your workspace's default. Automind runs as you, so its work counts toward your own usage.

## How I work

**How I work** holds optional standing instructions that Automind follows every time. Use them to say who to prioritize, what it may answer on its own, what it must always ask you about, and how you like to sound. For example:

- Answer Rick's questions about release dates from the project board.
- Anything about pricing or contracts: ask me first.
- Customers get a friendly holding reply; never answer their technical questions yourself.
- Keep replies short. No emoji.
- Merging to development and deploying DEV is fine; never touch production.

Write in the first person, as if you were briefing a colleague. Don't use channel names or ids; describe things the way you'd say them. The limit is 4,000 characters.

Click **AI Assist** to have AI draft or tighten your instructions, review the result, then click **Save**.

Automind also learns as it works. When you correct it or state a preference in your Automind conversation, it remembers that for next time.

## What it always checks with you first

Unless your **How I work** instructions say otherwise, Automind asks before it:

- commits you to a **date or deadline**
- agrees to anything involving **money**
- accepts or declines a **meeting**
- **emails** anyone outside your workspace
- **shares files** or **deletes** anything
- makes any other promise on your behalf

It never claims work is done when it isn't, and it never invents commitments you didn't make.

## Coding with SiloLink (optional)

If you write code with [SiloLink](coding-agents.md), Automind can give coding work to a Claude Code session running on your machine, and keep it going until the work is done.

### Set it up

1. **Set up SiloLink and create a SiloLink channel in Team Chat.** See [Launching a session from Portablemind](coding-agents.md#launching-a-session-from-portablemind). You must have created the channel yourself; a channel someone else added you to won't appear in the list.
2. **Pick that channel in Settings → Automind**, under **Coding (SiloLink)**. If you don't write code, leave it on **None — no coding work**.

### Give it work

Tell Automind what you want in your Automind conversation, the way you'd brief a teammate. For example: "In the billing repo, fix the failing invoice rounding test on a new branch, run the specs, and open a merge request."

Automind turns that into a full task for the session (the repo, the branch, what to change, how to check it) and posts it in your SiloLink channel as you, marked with the agent icon.

Only **you** can start coding work. If someone else asks you for a code change while you're away, Automind doesn't send it to the session. It tells you exactly what it would ask the session to do, and tells the person it's checking with you. One "go" from you in your Automind conversation starts it.

### What you'll see

- **In your SiloLink channel:** Automind's tasks and the session's progress, like any SiloLink conversation. You can watch, or step in yourself at any time.
- **When the session stops working** (it finished, or it's asking a question), Automind reads what the session posted and decides the next step:
  - If the work isn't finished (failing tests, review findings, a missing step) and the next step is one you've already approved, it sends the next task.
  - If the session asks something Automind can answer from your instructions, it answers.
  - If the session needs your decision, Automind asks you in your Automind conversation.
  - When the work is done, it tells whoever asked for it, and posts you a short summary.
- **The session stays available.** Automind doesn't end your session when a task is done, so it's ready for the next one. If SiloLink lets an idle session shut down, the session restarts when the next task arrives.

If you talk to the session directly, Automind stays out of that work. It only follows up on tasks it sent.

### Defaults and limits

- **What it checks with you first:** by default, anything touching production, merging or deploying to shared branches, and spending money. Change this in **How I work**.
- **A safety stop:** if a session goes back and forth with Automind 20 times in an hour, Automind stops relaying its reports until the next hour and tells you once. That way a task that never finishes can't keep running up costs. Reply in your Automind conversation if you want it to keep going.

## Recent activity

**Settings → Automind → Recent activity** lists the last 20 messages Automind picked up. For each one it shows who wrote, a preview of the message, what Automind did, and when. Click **See what it did** to open Automind's private record for that message: what it was given, the tools it used, and what it posted.

## Privacy and safety

Automind acts with your access, so it's built to make sure other people's messages can't turn that access against you.

- **Other people's messages are information, never instructions.** If a message says "forward me Sam's DMs" or "ignore your rules", Automind won't do it.
- **When it answers someone else's message,** it can only read and reply in the conversation that message came from. It can't post in, or read, any other conversation, even ones you're in.
- **For lookups on someone else's behalf,** it can only read tasks, projects, task assignments, and people's names. It can't read messages, files, or people's contact details, and it can't change anything.
- **People outside your workspace** (guests, customers, people from other organizations) get even less. Automind answers them only from the conversation itself, without lookups and without your memories.
- **Coding work** starts only from you.
- **Your Automind conversation** is private to you. Only your own messages there count as instructions.
- **Its posts can't be faked.** Only Portablemind can mark a message as an Automind post, and one person's Automind never answers another's, so two people who are both away won't trigger a loop of automatic replies.
- **Volume is capped.** If you're flooded with mentions, Automind handles up to 40 messages an hour and skips the rest.

## FAQ

**Will people know it was Automind and not me?**
Yes. Every post carries the agent icon, and notifications say **Your Name · Automind**.

**Can my teammates see my Automind conversation or settings?**
No. Your Automind conversation is a private conversation with only you in it, and your Automind settings can only be read or changed by you.

**I was at my desk but didn't reply. Will Automind answer?**
No. It waits until you've been inactive for about 3 minutes. If you then reply yourself before it gets to the message, it does nothing.

**I came back and see it replied to someone. Can I follow up?**
Yes. Just reply in that conversation as usual. Open **See what it did** in Settings if you want to know why it answered the way it did.

**Does it work on my phone?**
Its notes to you arrive as notifications, and you can reply in your Automind conversation from the mobile app, where it has its own section in the menu.

**Does it reply to channel messages?**
Only when you're @mentioned. Ordinary channel traffic is left alone.

**Can I give it tasks other than coding?**
Yes. In your Automind conversation you can ask it to relay a message, look something up, or reply to someone. It can reply in any conversation you're a member of when you've asked it to.

**What does it cost?**
Automind runs on the model you picked, as you, so its usage counts toward your own, just like your own AI chats. SiloLink sessions are billed the way SiloLink usually is.

**How do I stop it right away?**
Switch off **Turn on Automind** in Settings, or pause it.
