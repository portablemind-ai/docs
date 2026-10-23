# Git Repositories & Merge Requests

Portablemind agents can work with your source code in two ways. A [coding agent](coding-agents.md) such as Claude Code runs on your own machine through SiloLink and uses that machine's git setup. Separately, any agent in your workspace can open, review, approve and merge **merge requests** (GitLab) or **pull requests** (GitHub) directly against your git provider, with no machine involved. That second path is what this guide sets up: a one-time workspace configuration that tells Portablemind which provider you use, which repositories agents may touch, and the token to act with.

Once it is in place you can build your own agents to manage the flow: a developer agent that opens a merge request when its work is done, a reviewer that reads the diff and leaves comments, a release manager that merges once a human has approved. [Orchestration](orchestration.md) code pipelines use the same configuration to open merge requests from their stages.

## The `dev_team` configuration

Everything lives in one workspace configuration whose **Internal Identifier** is `dev_team`. Open **Administration → Configuration Manager → Configurations** and create it with **Create Configuration**, or edit it if a pipeline install already created one.

Add these values:

| Key | Type | What it holds |
| --- | --- | --- |
| `git_provider` | string | `gitlab` or `github`. |
| `git_url` | string | Your provider's base URL: `https://gitlab.com`, `https://github.com`, or your self-hosted GitLab / GitHub Enterprise address. The API endpoint is derived from it. |
| `project_id` | string | The default repository, as the provider names it: `group/project` on GitLab (sub-groups included, e.g. `acme/platform/api`) or `owner/repo` on GitHub. Used when an agent does not say which repository it means. |
| `default_branch` | string | The branch merge requests target when the agent does not specify one, for example `main` or `develop`. |
| `repos` | JSON | The list of repositories agents may work with. See [Registering repositories](#registering-repositories). Optional for a single-repository workspace. |

Then add the token under **Sensitive values**:

| Key | What it holds |
| --- | --- |
| `git_token` | An access token for the provider. Keys ending in `_token` are treated as secrets automatically: the value is stored encrypted, served back only as `[REDACTED]`, and never appears in exports or logs. |

Save, and the configuration is live for every agent in the workspace straight away.

### Creating the token

Use a token that belongs to the project or group rather than to a person, so it keeps working when people leave and so the audit trail on your provider shows the agent's actions as the agent's.

- **GitLab** — create a **Project Access Token** (Settings → Access tokens on the project) or, for several repositories, a **Group Access Token**. Give it the `api` scope. The **Developer** role is enough to open merge requests, comment and approve; merging into a protected branch needs **Maintainer**.
- **GitHub** — create a **fine-grained personal access token** scoped to the repositories you will register, with **Contents: Read and write** and **Pull requests: Read and write**. A classic token with the `repo` scope also works. For GitHub Enterprise, set `git_url` to your server; Portablemind calls its `/api/v3` endpoint.

A token that reaches many repositories (a group token, or a GitHub token with access to a whole organization) is convenient, but it is exactly why the next section exists.

## Registering repositories

Agents may only act on repositories you have **registered** in the `repos` list. The token may well reach far more than that: a GitLab group token can see every project in the group, infrastructure repositories included. The registry is how you say which of them agents are allowed to touch. An agent that names any other repository is refused with:

> project_id … is not one of this workspace's registered repositories (the dev_team configuration and its repos list).

`repos` is a JSON array with one entry per repository:

```json
[
  { "key": "backend",  "role": "backend",  "project_id": "acme/api",      "default_branch": "develop", "deploy_order": 1 },
  { "key": "frontend", "role": "frontend", "project_id": "acme/web",      "default_branch": "develop", "deploy_order": 2 },
  { "key": "site",     "role": "site",     "project_id": "acme/website",  "default_branch": "main",    "deploy_order": 3 }
]
```

| Field | What it means |
| --- | --- |
| `key` | A short name agents and pipelines use to refer to the repository. |
| `role` | What the repository is in your system (`backend`, `frontend`, `docs`…). Usually the same as `key`. |
| `project_id` | The repository as the provider names it, same form as the top-level `project_id`. This is what the registry checks. |
| `default_branch` | The branch merge requests for this repository target by default. |
| `deploy_order` | The order orchestration pipelines deploy the repositories in. |
| `repo_path` | Optional. Where the repository is checked out on the machine a pipeline's coding agents run on. Only needed for pipelines that work on a local checkout. |

Each entry inherits the provider, URL and token from the top-level values, so one `dev_team` token covers them all. Once the list has entries, **only the entries count**: include your default repository in it too, or an agent that names it explicitly is refused. A workspace with a single repository can skip `repos` entirely; the top-level `project_id` and `default_branch` then act as the one registered repository.

When you add a repository later, add it here. There is nothing to restart; the next agent call sees it.

### Repositories a pipeline registers for you

When you install a code pipeline from the [orchestration catalog](orchestration.md#setting-up-a-pipeline-at-install), the install dialog's **Repositories** rows (name, checkout path, branch) are saved into this same `repos` list. Those rows describe where the pipeline's coding agents find the code on the run host; they do not carry the provider-side `project_id`. If the pipeline also opens merge requests, add `project_id` to each entry here in the Configuration Manager, together with the provider and token.

## Giving an agent the git tool

The tool agents use is `git_provider_tool`. A workspace admin grants it in the agent wizard's **Tools & Roles** step (granting it needs the admin's own git capabilities), or you can start from the **Software Developer** or **Code Reviewer** agent template, which include it. See [Building AI Agents](agents.md) for the wizard.

With the tool, an agent can:

| Operation | What it does |
| --- | --- |
| `create_mr` | Open a merge request from a branch, with a title, description and optional assignee. |
| `list_mrs` | List merge requests, open by default or filtered by state. |
| `get_mr`, `get_diff` | Read a merge request and its full diff. |
| `comment_mr` | Leave a review comment. |
| `update_mr` | Change the title, description, target branch or assignee. |
| `approve_mr`, `merge_mr` | Approve, then merge, optionally squashing and deleting the source branch. |

Give merge rights deliberately. A reviewer agent that only needs to read and comment can be told so in its instructions, and the human approval gates in [orchestration](orchestration.md#approvals-and-reviewers) put a person between a passing review and a merge. Every call is made as the agent, in your workspace, and is recorded in the agent's activity.

One limit comes from the providers rather than Portablemind: both refuse to let the author of a merge request approve it (GitLab's *Prevent approval by author* setting and GitHub's rule against approving your own pull request, both on by default). Every agent acts with the one workspace token, so an agent cannot approve a merge request another agent opened with it. Have a person approve, or let your branch rules merge without a formal approval.

> **Tip:** When you write an agent's instructions, tell it to pass the repository (`project_id`) on every call. Merge request numbers are only unique within one repository, so `get_mr 18` without a repository falls back to the default `project_id` and may return an unrelated change. The tool's response carries a `warning` whenever it had to fall back.

## Working in a multi-repository workspace

With several repositories registered, the same agent can review the backend change and the frontend change that go together, and a pipeline run can span repositories, deploying them in `deploy_order`. Pipelines that span repositories declare it; an ordinary run works on the first repository unless the template says otherwise. The [orchestration guide](orchestration.md) covers how a template declares the repositories it needs.

## Troubleshooting

| Message | What it means |
| --- | --- |
| *No dev_team configuration found for tenant* | The workspace has no configuration with the Internal Identifier `dev_team`. Create it as above; the identifier has to be exactly that. |
| *project_id … is not one of this workspace's registered repositories* | The agent named a repository that is not in `repos` (with an empty `repos`, not the top-level `project_id`). Add it to the list, your default repository included. Repository paths compare case-insensitively, so this is a missing entry, not a spelling difference. |
| *Unsupported git provider* | `git_provider` must be `gitlab` or `github`, in lower case. |
| *Authentication/authorization error (401)* or *(403)* | The token is missing, expired or lacks the scope or role for that operation. Merging into a protected branch is the usual culprit. Re-enter the token under Sensitive values. |
