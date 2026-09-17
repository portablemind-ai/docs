# Agent Orchestration

Agent Orchestration lets you define multi-stage pipelines where AI agents perform work in sequence, with human approval gates between stages. Each stage can use a different agent with specialized skills, and the engine manages transitions, artifact passing, and lifecycle automatically — you review the output at each gate and decide whether the work moves forward.

Pipelines are defined as **YAML templates** that describe agents, stages, transitions, and coordinator behavior. Templates are domain-agnostic: the same engine powers code improvement pipelines, RFP responses, meeting notes processing, and full software development lifecycle (SDLC) workflows. If you're new to agents in Portablemind, start with [Building AI Agents](agents.md) — orchestration builds on the same agent foundation.

> **Note:** Agents handle work *within* their stage. The engine handles flow *between* stages. Humans approve at gates. This separation exists because agents cannot reliably self-orchestrate handoffs — the engine keeps every run on rails.

## How orchestration works

| Component | Role |
|---|---|
| **Template** | YAML definition of agents, stages, transitions, and coordinator persona |
| **Run (execution)** | A running instance of a template with its own stage history, artifacts, and cost tracking |
| **Coordinator agent** | Conversational agent in the run's chat that starts the pipeline, summarizes results, and handles approvals |
| **Stage agents** | Specialized agents that do the actual work (analysis, implementation, verification) — code stages run via [coding agent](coding-agents.md) sessions |
| **Artifacts** | Documents and data produced by stages, passed forward to subsequent stages |
| **Approval gates** | Human checkpoints between stages where you review the output and approve or request changes |

## The life of a run

Every run follows the same shape:

1. **Pick a pipeline template** from the catalog — Bug Fix, SDLC, Code Improvement, Nightly Health, and more.
2. **Start the run** — @mention the coordinator agent in a conversation, or use the start dialog in **AI Studio → Operate → Orchestrations**, choosing the inputs and (where required) the approvers.
3. **Each stage repeats a cycle:**
   - The **stage agent does the work** — for code pipelines, it writes code through a coding agent session and produces an artifact.
   - An **independent reviewer verifies it** — always a *different* agent than the one that produced the work.
   - The **approval gate opens** — the designated approver is notified and either approves or requests changes. Requested changes send the stage back to the agent with your feedback; approval passes the artifacts forward to the next stage.
4. **Completion** — approving the final gate completes the run. For code pipelines this typically means opening a merge request or parking the results for review.

Throughout the run, the coordinator agent keeps the conversation going — announcing stage transitions, summarizing each stage's output, and answering your questions. Some pipelines also maintain a **traceability matrix** tracking each requirement from stated to satisfied to verified.

## Approvals and reviewers

Pipelines keep a clear separation between the AI that does the work and the people who sign off on it. You don't have to set up the review rules yourself — the platform applies them automatically.

- **Independent review is automatic.** The agent that reviews or verifies a stage is always a different agent than the one that produced the work. The system enforces this "producer is never the reviewer" rule — there's nothing to configure.
- **Who can approve a gate.** Each human approval gate is open to *anyone authorized* (the default), restricted to a *specific person or role* (for example, a "Dev Manager"), or restricted to a *team's lead*.
- **Choose approvers when you start a run.** If a pipeline's gate is restricted, the start dialog shows a picker — choose the people (shown by name and email) or the team that should sign off before the run begins. Assign approvers before the gate opens; assigning afterward only affects the next gate.
- **The right person gets notified.** When a stage reaches its gate, the designated approver is notified — not just whoever started the run. Only a designated approver can approve; everyone else sees the gate as read-only.
- **Requirements traceability** (some pipelines). A run can track numbered requirements as tasks and show a traceability matrix — which requirement was satisfied and verified — so nothing slips through review.

### Approving and rejecting

When a gate opens, the coordinator posts a summary of the stage's output in the conversation and asks for your decision:

- **Approve** — tell the coordinator you approve (a simple "approved" works). The run advances and the stage's artifacts pass to the next stage.
- **Request changes** — give the coordinator your feedback instead. The stage re-runs with your notes, and the gate opens again when the revised work is ready.
- **Cancel** — you can also cancel a run entirely if it's no longer needed.

Gates can also be worked from the run's detail view in **AI Studio → Operate → Orchestrations**, which has explicit **Approve** and **Reject** buttons and lets you assign the gate's approver.

```recording
title: Approve a gate
src: https://www.dsiloed.com/api/v1/public/llm_files/2198/raw?key=5281108aac7bfde5adde48c625f9245a
```

## Starting a run

The easiest way to use a pipeline is to @mention its coordinator agent in a Team Chat conversation. Describe what you want and the coordinator starts the pipeline automatically:

1. **Install a template** from the catalog (see below) and provide its setup — for example, the repositories a code pipeline works on — in the install dialog.
2. **Choose the approver(s)** — if the pipeline has a restricted gate, the start dialog lets you pick who signs off before the run begins.
3. **@mention the coordinator** with your request — for example, `@Code-Pipeline fix the login bug in auth.rb`.
4. **Review stage output** — the coordinator summarizes each stage's results and asks for approval.
5. **Approve or reject** — say "approved" to advance, or provide feedback to re-run the stage.

```recording
title: Start an orchestration run
src: https://www.dsiloed.com/api/v1/public/llm_files/2202/raw?key=61918e527e2a3a8e4a023c5db4e1d594
```

> **Note:** Pipeline stages that write code run through coding agent sessions, which require the SiloLink bridge to be running on the target machine. See [Coding Agents](coding-agents.md) before starting a code pipeline.

Runs can also be started and managed programmatically. For API-level details, see the [API guide](https://www.dsiloed.com/apps/apiguide/index.html).

## The template catalog

Portablemind ships a catalog of ready-made pipeline templates you can browse and install into your workspace from **AI Studio → Agents & Skills → Pipelines**:

| Template | What it does |
|---|---|
| **SDLC Pipeline** | Full software development lifecycle with human approval gates: spec, architecture, planning, parallel development with code review, testing, then runbook-driven promotion to DEV and PROD. |
| **Bug Fix** | A leaner bug-fix track: triage and reproduce, fix on a branch, verify, then runbook-driven promotion with approval gates. |
| **Code Improvement Pipeline** | General-purpose refactoring: an analyst plans, a developer implements, a tester verifies, then promotion. |
| **Backlog Delivery Pipeline** | Works an existing project and a human-selected set of its tasks through triage, implementation, and delivery. |
| **Nightly Codebase Health Pipeline** | Unattended scheduled runs that keep a codebase healthy: DRY/SOLID cleanups, dependency security patches, safe upgrades. |
| **Agent Fleet Review Pipeline** | Unattended scheduled audit of every agent in the workspace, producing an evidence-backed findings report. |
| **Meeting Notes Pipeline** | Turns raw meeting notes or transcripts into structured summaries and real task records. |
| **RFP Response Pipeline** | Extracts requirements and a compliance matrix, designs the technical approach, estimates WBS, timeline, and costs — with an optional demo build. |
| **Runbook Preflight** | Read-only validation that a project's runbook and deploy environment are ready before running real pipelines. |

More templates are on the way.

Installed templates stay current automatically — persona updates, tool list changes, and stage configuration modifications in the catalog are picked up without reinstalling.

> **Tip:** An administrator can package a whole team — its agents, their know-how, the pipeline, and [skills](skills.md) — and install it into another workspace as a single unit.

```recording
title: Install a pipeline from the catalog
src: https://www.dsiloed.com/api/v1/public/llm_files/2204/raw?key=6ad94c7059f6707364223e07908ba6e2
```

## Setting up a pipeline at install

A pipeline often needs some workspace-specific setup before it can run — the repositories it builds and deploys, a directory of files to process, a webhook URL to post results to. A template declares these needs as a list of typed fields (its *install schema*), and the install dialog renders an editor for each one under a **"Set up this pipeline"** section:

- Anything already configured shows a green **configured** check — you're only prompted for what's missing.
- **Required** fields must be filled before you can install.
- Values are saved to a visible, editable configuration — set once and reused by every run, nothing hidden.
- You can edit the setup later with the pipeline's **Configure** option — the same form, pre-filled with current values, saved without reinstalling.
- If a required value is still missing at run time, the run fails fast with an actionable message instead of an agent guessing and hanging.

For code pipelines, the key field is the **repositories** list (name, checkout path, and branch for each repo the pipeline operates on). Pipelines that push branches and open merge requests against a remote also need git provider credentials, which an administrator sets in the workspace configuration; pipelines whose agents work purely on a local checkout need only the repositories.

## Building your own template

Templates are self-contained YAML files that define everything a pipeline needs: the coordinator, the stage agents, the stages themselves, and the transitions between them. A minimal template looks like this:

```yaml
name: My Pipeline
domain: engineering
description: Brief description of what this pipeline does.
cost_limit: 15.0

# Setup the installer provides in the install dialog
install_schema:
  - key: repos
    type: repo_list        # Name / Checkout path / Branch rows
    required: true

coordinator:
  name: My-Coordinator
  description: Pipeline coordinator
  persona: |
    Your coordinator persona here...

agents:
  - name: My-Worker
    description: What this agent does
    daily_cost_limit: 10.0
    persona: |
      Your worker agent persona here...

stages:
  - name: my_stage
    label: Human-Readable Label
    position: 0
    agent: My-Worker
    requires_approval: true
    timeout_minutes: 30
    expected_outputs:
      - my_artifact_key

transitions:
  - from: my_stage
    to: my_stage
    condition: approval_rejected   # rejected work loops back for another pass
    priority: -1
```

Each stage names the agent that performs it, whether it needs human approval, a timeout, and the artifacts it's expected to produce. Transitions define how stages connect — including the "rejected work loops back to the same stage" pattern every approval stage should have. Document-style artifacts (plans, reports, analyses) are stored as files the next stage can read; structured metadata (branch names, commit SHAs) passes as data.

A few practices that make templates reliable:

- **Don't add a redundant final review stage** — if the last working stage requires approval, approving it completes the pipeline.
- **Every approval stage needs a rejection self-loop** so requested changes re-run the stage instead of stranding the run.
- **Be literal in agent personas** — agents follow instructions exactly, so spell out ordering (for code stages: create the branch, then commit, then push, then open the merge request).
- **Set sensible cost limits** — a per-run `cost_limit` on the template, plus daily limits per agent. Coordinators run on every stage transition and user message, so give them more headroom than workers.
- **Set stage timeouts to match the work** — shorter for analysis stages, longer for implementation.

The full template reference — stage types, tool lists, and configuration keys — lives in the [API guide](https://www.dsiloed.com/apps/apiguide/index.html).

## Run lifecycle and monitoring

Every run reports a status you can watch from the moment it starts — the run list and per-run detail live in **AI Studio → Operate → Orchestrations**:

| Run status | Meaning |
|---|---|
| Pending | Run created but not yet started |
| Running | Pipeline is actively executing stages |
| Paused | Paused by a user or the system |
| Completed | All stages completed successfully |
| Failed | The run failed — a timeout, cost limit, or stage failure |
| Cancelled | Cancelled by a user |

Within a run, each stage moves through its own states: waiting to start, agent actively working, **awaiting approval** (work done, gate open), **awaiting input** (the agent asked you a question and is waiting for an answer), then approved, rejected (re-running with your feedback), completed, or failed. The two "awaiting" states are the ones that need you — the coordinator surfaces both in the conversation so you always know when it's your turn.

### Cost tracking

Each run tracks cumulative AI cost across all of its stages. The template's `cost_limit` caps total spend for a run — a background monitor automatically fails any run that exceeds its limit, so a stuck pipeline can't burn budget indefinitely. Individual agents also carry their own daily cost limits, enforced separately; if an agent hits its daily limit, a message is posted to the conversation so you know why work paused.
