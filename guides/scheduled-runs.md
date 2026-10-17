# Scheduled Runs

A scheduled run is work you ask an agent to do **later**. Instead of waiting until Thursday to remind an agent to check something, you ask it now, in the conversation where you want the answer, and it acts at the time you gave.

A run is always tied to three things: the **agent** that will do the work, the **conversation** the result goes to, and **you**, the person who asked.

## Asking for one

Mention the agent and say when, in plain words:

> @Ralph on Oct 23 at 9am review the open tickets and tell me which ones are blocked

> @Ralph every weekday at 8:30am, summarise yesterday's deploys here

The agent sets up the run and replies with the time it understood, in your time zone and in UTC (for example *Thu 23 Oct 2026 09:00 America/New_York (13:00 UTC)*), plus a run number. Check that time. If it's wrong, ask the agent to cancel it and try again with a clearer date, or cancel it yourself (see below).

When the time comes, your request is posted into the same conversation **as a message from you**, marked with a clock and the word **Scheduled** so nobody thinks you typed it then. The agent then answers it there, as if you had just asked.

## One-off or recurring

- **One-off** runs happen once, at a set date and time, up to a year ahead.
- **Recurring** runs repeat on a schedule: every day, every weekday, every Monday, on the 1st of the month, and so on. You can give an end date ("every Friday until the end of the year"); without one, a recurring run continues until someone cancels it.

Times follow the time zone you gave, or your own if you didn't give one. A recurring run at 9am stays at 9am local time when the clocks change.

Each occurrence runs **at most once**; nothing is retried. What happens when a run can't go ahead:

- **The agent hit its daily cost limit:** that one occurrence of a recurring run is skipped, and the next one runs as normal.
- **The agent was switched off, or you can no longer use it or post in the conversation:** the run stops for good, and you get a notification. Clicking it opens **Settings → Scheduled runs**, which shows the reason.
- **Your workspace reached a plan limit** (such as its monthly messages): a one-off run stops; a recurring run misses that occurrence and tries again next time. Either way the list shows the limit.

## Seeing and cancelling your runs

There are two places to see scheduled runs:

- **Settings → Scheduled runs** lists every run you have asked for, with its agent, conversation, next run time (in your time zone), schedule, status, and what happened last time.
- In **AI Studio**, an agent's **⋯** menu has **Scheduled runs**, listing that agent's runs you can see: your own, or everyone's in your workspace if you're an admin.

To stop a run, choose **Cancel** next to it and confirm. Cancelling can't be undone; to start again, ask the agent for a new run. Runs that have already finished, failed or been cancelled stay in the list for reference and can't be cancelled.

## Who can see and cancel a run

- **You** can see and cancel the runs you asked for.
- **Workspace admins** can see and cancel every run in the workspace. In **Settings → Scheduled runs** they get a **Mine / Workspace** switch, and the workspace view shows who asked for each run.

Nobody else sees your runs. Agents and API keys can't create runs on their own: every run has a person behind it.

A run belongs to the workspace of the person who asked for it. If someone from a partner workspace schedules your agent in a shared conversation, the run shows in their workspace's lists, not yours.

## What the agent needs

The agent must have the **scheduled run tool** (`scheduled_run_tool`) granted. It isn't added to agents automatically: whoever manages the agent turns it on in its **Tools & Roles** step in AI Studio (see [Building AI Agents](agents.md)). Without it, the agent can't set up runs and will say so.

When a run fires, it checks again that you can still use the agent and post in the conversation. If you can't, the run fails and you get a notification.

A run can't set up another run. If you want something to happen repeatedly, ask for a recurring run ("every weekday at 9am") rather than asking the agent to keep rescheduling itself.

## Limits

A scheduled run acts as a message from you, so it counts toward **your limits and your workspace's limits** in the same way as a message you type. See [Plans, Limits & Fair Use](plans-and-limits.md).

Your plan also sets how many runs can be waiting at once and how often a recurring run can repeat:

| Plan | Pending runs per person | Pending runs per workspace | Recurring runs |
|---|---|---|---|
| Free | 5 | 20 | Not included |
| Starter | 25 | 200 | Not included |
| Professional | 100 | 1,000 | At most every 15 minutes |
| Business | 250 | 5,000 | At most every 5 minutes |
| Enterprise | 1,000 | 20,000 | At most every 5 minutes |

One-off runs are available on every plan. Recurring runs need a plan that includes agent scheduling. If you ask for more than your plan allows, the agent tells you why.
