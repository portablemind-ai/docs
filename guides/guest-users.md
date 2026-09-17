# Guest Users

Guest users let you bring people into your Portablemind workspace who have never used the platform before — contractors, clients, and consultants who need temporary or limited access to your work. A guest starts from a simple email invitation into one of your conversations, tries the platform right there, and can grow into a full account in your organization with access scoped to just the resources you choose.

Guests use the same Portablemind app as everyone else. What makes them different is how they arrive (invited by you, starting from a single conversation) and how tightly their access can be scoped.

## Guest users vs workspace sharing

Portablemind has two ways to collaborate with people outside your organization. Guest users are for people who are **new to the platform**; [Workspace Sharing](workspace-sharing.md) is for people who **already have their own Portablemind organization**.

| Factor | Guest user | Workspace sharing |
|---|---|---|
| User status | New to the platform | Existing user in another organization |
| How they join | Email invitation into one of your conversations | Account already exists |
| Their experience | A single workspace (yours) | Shared content appears in their own workspace |
| Best for | Contractors, clients, consultants | Partners, service providers |
| Growth path | Can be upgraded later | Already has a full organization |

If you're setting up an ongoing partnership with another company — especially around shared tickets — see [Tickets and Partners](tickets-and-partners.md), which builds on workspace sharing.

## How the guest workflow works

Inviting a guest is a three-part flow: you invite them into a conversation, they join and (when ready) sign up as a guest, and (optionally) you tighten their access to specific records.

### 1. Invite the guest into a conversation

Guests start from a **Team Chat conversation**. Open the conversation's **More actions** menu and choose **Invite Guest to Conversation**: all you provide is the guest's email address (plus an optional personal message).

The guest receives an invitation email with a secure link straight into that conversation — no account, username, or password needed to get started. The invitation is scoped and safe by design:

- **One conversation** — the link opens just the conversation they were invited to, nothing else.
- **Message limits** — guests can send a configurable number of messages before being asked to sign up.
- **Time-limited** — invitation links expire automatically.

You can review all guests from **User Management → Guests**.

```recording
title: Invite a guest user
src: https://www.dsiloed.com/api/v1/public/llm_files/2206/raw?key=c11baf64132012f3783f54f3560b1d5c
```

### 2. The guest joins — and grows into an account

From the guest's side, the experience is progressive:

1. They click the emailed link and land directly in the shared conversation — participating immediately, with their email shown as their name.
2. As they reach the guest message limit, Portablemind invites them to sign up to keep collaborating.
3. Signing up (password or Google sign-in) converts them into a real **guest account** inside your organization — they keep their conversation history and can now sign in normally.

> **Note:** Converted guest users are real accounts inside your organization, not separate organizations. They're simply flagged as guests, and the roles you assign determine what they can reach.

### 3. (Optional) Scope access to specific records

If the security roles you assigned are enough — say, read-only access across projects — you're done. Use record-level scoping when a guest should only see **specific records**: one project, one client's documents, a single ticket queue.

Portablemind's security model makes this possible through **capabilities**: fine-grained permissions that pair an action (view, edit, delete) with a resource, and can be narrowed to particular records or even particular fields. A few concepts worth understanding:

- **Roles bundle capabilities.** A security role is a named collection of capabilities. Assign the role to a user and they get everything in the bundle.
- **Capabilities can be scoped.** A capability can apply to all records of a type, or be filtered — "view only Project #42 and its tasks," or "view only these fields."
- **Scoped capabilities can be record-specific.** Access created for a single collaboration can be marked to clean itself up automatically when the assignment is removed — ideal for temporary engagements.
- **Scoping can be dynamic.** For scenarios with many guests (like a client portal), a single shared role can grant each guest access to "the projects tagged with *my* user" — so one role serves hundreds of clients without any per-person configuration. You just tag the relevant projects and assign the same role to each new client.

The practical pattern: use roles for general permissions, and add scoped capabilities when a guest should be restricted to specific records. Administrators manage roles and capabilities from the Administration area of Portablemind.

> **Tip:** Start with the least access that works. It's easy to widen a guest's access later; it's harder to un-see data.

For API-level details, see the [API guide](https://www.dsiloed.com/apps/apiguide/index.html).

## What guests can and can't do

- Guests can use the Portablemind app like any other user — chat, projects, tasks, files — **within the boundaries of their roles and capabilities**. If they don't hold a capability for something, it isn't available to them.
- Guests belong to a single workspace: yours. They don't have their own organization (people who do are covered by the [Workspace Sharing](workspace-sharing.md) model).
- Guests are full audit-tracked users, so their activity is visible in the same places as everyone else's.

## Converting a guest

Collaborations grow. When a guest is ready to stand on their own, they can upgrade themselves into the owner of a brand-new Portablemind organization — the conversion is self-service, done by the guest, not by you.

Once a guest has a full guest account with their own password, a prominent **Become a Tenant Owner** button appears in their top bar. Clicking it asks for an organization name and a workspace identifier, then creates the new organization with the guest as its owner and administrator, on the free plan. Portablemind automatically creates a **sharing relationship** between their new organization and yours, so they keep access to your workspace — the guest-user model graduates into the [Workspace Sharing](workspace-sharing.md) model. This is the right path when a contractor or partner is standing up their own practice and needs their own space while continuing to work with you.

```recording
title: Convert a guest to a tenant owner
src: https://www.dsiloed.com/api/v1/public/llm_files/2165/raw?key=fd6cbf8b1e3fa6c33e4fb977252e9fe0
```

## Related pages

- [Workspace Sharing](workspace-sharing.md) — cross-organization access for people who already have their own workspace.
- [Tickets and Partners](tickets-and-partners.md) — partnership flows built on cross-organization sharing, including shared ticket management.
