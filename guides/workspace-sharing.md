# Workspace Sharing

Workspace sharing lets users from one Portablemind organization work with another organization's content — with real, role-controlled permissions. Two companies collaborating on a project can grant each other's people exactly the access they need, while each organization's data stays isolated and under its own control.

This is the right model when your collaborators **already have their own Portablemind organization** — partners, service providers, agencies. If you're bringing in someone who's new to the platform entirely, start with [Guest Users](guest-users.md) instead; that page also has a side-by-side comparison of the two models.

## What workspace sharing gives you

- **A formal request/accept flow** — sharing between organizations is established deliberately, by mutual agreement, never unilaterally.
- **Resource-level access** — you share the specific things the collaboration needs — a conversation, a project, a folder — not your whole workspace.
- **Role-based permissions** — everything a visiting user can see or do is controlled by the access levels on each share and the security roles and capabilities the host grants.
- **Work from your own workspace** — content shared with you appears inside your own workspace; you don't log out or move somewhere else to reach it.

## Core concepts

### Sharing relationships

A sharing relationship is a formal link between two organizations. It moves through a small set of statuses:

| Status | Meaning |
|---|---|
| Pending | Requested, awaiting the other organization's acceptance |
| Active | Accepted and functional |
| Suspended | Temporarily paused |
| Revoked | Permanently ended — the access it granted is removed |

> **Tip:** Revoking is permanent — it's a hard unshare, and re-establishing access afterwards requires a brand-new invitation.

### Hosts and guests

In any relationship there are two sides:

- The **host** organization is the one granting access to its content.
- The **guest** users are the people from the other organization who receive that access.

Host users only ever see their own workspace — they provide access, they don't receive it. Guest users work from their own workspace, where the content shared with them appears alongside their own.

### Roles and shares control everything

A relationship on its own is **not enough** to see a host's content. What a visiting user can actually reach is determined by what the host shares and the permissions attached — each share carries an access level, and the host's security roles and capabilities govern everything beyond it, using the same permission system that governs the host's own members.

## The sharing workflow

Establishing a partnership between two organizations works like this:

1. **Invite** — from the **Partners** page (**Administration → Partners**), an administrator clicks **Invite Organization** and enters the email address of a contact at the other organization. There's no directory to browse — invitations always go to a specific email address.
2. **Accept** — the other organization sees the incoming request in the **Pending** section of its own Partners page and accepts (or declines) it. The relationship becomes active.
3. **Share and grant** — access to actual content is granted by sharing specific resources — conversations, projects, files — with the partner, and by the roles and capabilities the host assigns. Until something is shared, there's nothing for the partner to see.
4. **Access** — the partner's users now see the shared content from inside their own workspace, within whatever their access levels allow.

```recording
title: Request and accept a workspace share
src: https://www.dsiloed.com/api/v1/public/llm_files/2148/raw?key=ecbad4fbb9aa8073ab420b15ad10eee2
```

For API-level details, see the [API guide](https://www.dsiloed.com/apps/apiguide/index.html).

## Sharing an individual item with a partner

Day to day, most cross-organization sharing happens from an item's own **share dialog** — the **Access / Membership** button on a project, chat, or file. The dialog's search offers three kinds of grantee:

- **A person** — anyone you can see, including people from partner organizations (marked with their organization's name).
- **A team** — one of your own teams.
- **A partner team** — under the **Partners** group (handshake icon), each active partnership offers its designated manager team, shown as *"Organization — team"*. Sharing with it grants access to the members of that specific team, at the access level you pick. This is the usual way to hand a whole partner working-group access to something in one step.

**Which flow do I want?**

| You want… | Do this |
|---|---|
| One partner person to see or edit an item | Share the item with that **person** |
| A partner's working team to see or edit an item | Share the item with the **partner team** from the Partners group |
| A partner organization to file tickets against a project **without seeing it** | Don't share — [publish the Application for ticket intake](tickets-and-partners.md#letting-partners-file-tickets-against-your-applications) |
| A partner team to work the tickets you receive | The partnership's [standing ticket share](tickets-and-partners.md) |

> **Tip:** a share always grants real visibility at the level you choose — viewer and up. If what you actually want is "they can raise tickets against this, nothing more," that's intake publishing, not sharing.

## Where shared content appears

Your top bar always shows which workspace you're working in, with an **Owner** or **Guest** badge indicating your role there. Content shared with you from another organization doesn't require moving anywhere: it appears directly inside your own workspace, filtered by the permissions you hold on each shared resource. The workspace menu also links to **Workspace Sharing**, which opens the Partners administration page.

If someone shares content with a person who doesn't have a Portablemind account yet, the share invitation email walks them through creating their own workspace — and the pending shares activate as part of signup.

```recording
title: Accept a workspace share
src: https://www.dsiloed.com/api/v1/public/llm_files/2166/raw?key=e2ae0e477dc17e09ba7456781ae1954f
```

## Ending a share

Relationships don't have to be forever. From the Partners page, opening a partnership's **Manage** dialog offers **Revoke** — a permanent, hard unshare: the access granted through the relationship is removed in one step. If the organizations want to collaborate again later, they start over with a new invitation.

## Security model

Workspace sharing is designed so that collaboration never weakens isolation:

- **Deliberate grants required** — no user can touch another organization's data unless that organization explicitly shared it with them.
- **Role-gated access** — every action a visiting user takes is checked against the access levels, security roles, and capabilities the host granted. There is no implicit access.
- **Resource-level granularity** — access is granted share by share, role by role — never wholesale to an entire workspace.
- **Audit trail** — every relationship change and access grant is logged.
- **Clean revocation** — revoking a relationship removes the access it granted in one step, so nothing lingers.

## Related pages

- [Guest Users](guest-users.md) — invite brand-new users into your workspace with scoped access, and see how guests compare to workspace sharing.
- [Tickets and Partners](tickets-and-partners.md) — partner onboarding and cross-organization ticket management built on top of workspace sharing.
