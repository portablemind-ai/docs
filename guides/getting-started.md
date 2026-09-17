# Getting Started

Getting up and running with Portablemind takes just a few minutes: create a workspace, sign in, and you're ready to explore. This page walks you through workspace creation and gives you a functional tour of the main areas of the app.

## Create your workspace

Your workspace (sometimes called a *tenant*) is your team's private environment on Portablemind — it holds your people, conversations, projects, files, and AI configuration.

To create one, go to [app.portablemind.ai/signup](https://app.portablemind.ai/signup) and provide:

- **Your account** — your name, email address, a username, and a password. The account you sign up with becomes the workspace administrator.
- **Organization details** — your organization's name, a unique identifier (used in URLs and API calls), and a shared key for secure authentication.
- **A plan** — pick the subscription plan that fits your team.

Complete the signup and your workspace is created immediately. You'll land in the app, signed in as the administrator, ready to invite teammates and set up AI.

```recording
title: Create your workspace and sign in
src: https://www.dsiloed.com/api/v1/public/llm_files/2214/raw?key=762caf392592db8e1e1b63689db3a973
```

> **Note:** Every workspace is fully isolated. Your data lives alongside other workspaces on the same platform, but security is enforced at the database row level — no other workspace can ever see or touch your data, and you can never see theirs.

## Signing in

Return visits are simple: sign in at [app.portablemind.ai](https://app.portablemind.ai) with your email (or username) and password. Your administrator controls who has access, so teammates join by invitation rather than open signup.

## A tour of the app

Once you're signed in, you land on the **AI Assistant** — the app's home page. The **app switcher** (the grid icon in the top bar) moves you between the other areas, and an optional **Jump Bar** adds one-click shortcuts to the core apps (toggle it from the app switcher menu). Here's what each area is for:

| Area | What you'll use it for |
|---|---|
| **AI Assistant** | Your home base — chat directly with your configured AI models. Ask questions, attach documents, and get work done conversationally. The Home button always brings you back here. |
| **Chat** (Team Chat) | Real-time conversations with your teammates — and with AI participants, who can join channels and discussions as collaborators. |
| **Plan & Track** | Plan and track structured work: projects, hierarchical tasks, assignments, and statuses, with Kanban, Gantt, time-reporting, and burndown views. |
| **Tickets** | Track support cases and requests from intake through resolution, including tickets shared with partner organizations. |
| **Files & Artifacts** | Store and organize your team's documents. Files can be attached to AI conversations so assistants can read and work with them. |
| **AI Studio** | Configure and operate the AI side of your workspace: providers, models, agents, prompts, and live monitoring of agent activity. This is where administrators shape how AI behaves. |
| **Settings** | Manage your profile and workspace preferences. Administrators also get **User Management** (users, roles, and permissions) and **Administration** (workspace configuration) as separate apps in the switcher. |

```recording
title: A tour of the Portablemind interface
src: https://www.dsiloed.com/api/v1/public/llm_files/2086/raw?key=40c6d3f4eb96423b3d2a49dc8ef28025
```

## Where to go next

Your workspace starts without any AI models connected, so the natural next step is [Setting up AI](ai-setup.md) — connect a provider and pick your models. From there, head to the [AI Assistant](ai-assistant.md) to start your first conversation.
