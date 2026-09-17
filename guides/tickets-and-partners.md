# Tickets, Partners & the Support Portal

Tickets are Portablemind's way of tracking work requests — support issues, change requests, feature asks, or anything else your organization needs to log, prioritize, and resolve. You'll find them in the **Tickets** area of the app, where each ticket carries its own status, discussion, and history from open to close.

If you provide support to other people, there are **two ways to let them raise tickets with you**, and which one fits depends on whether they already use Portablemind.

## Choosing a path

| | **Partnership** | **Support Portal** |
|---|---|---|
| Your customer | Already has (or will get) a Portablemind organization | Has no Portablemind account and doesn't want one |
| Where they work | In their own organization, in the normal Tickets app | On a branded public web page you host |
| Their identity | A user in **their** organization | A scoped account in **your** organization |
| Who sees what | Teams on both sides govern visibility | They see only their own tickets |
| AI support agent | Not available in the shared thread (see below) | Answers automatically, around the clock |
| Setup | Send a partner invitation | Deploy the portal and hand out an access code |

You can run both at once. A software vendor might partner with its enterprise customers while pointing everyone else at a public support page.

Within a partnership there are also two distinct directions tickets can flow, and they solve different problems:

| You want… | Use | What the other side sees |
|---|---|---|
| A partner team to **work the tickets you receive** | The partnership's standing ticket share (this page, below) | Your shared tickets, in their Tickets app |
| A partner to **file tickets with you** against the right product | [Publish an Application to that partner](#letting-partners-file-tickets-against-your-applications) | Just the Application's name in their ticket dropdown — never the project itself |
| Specific partner people to **see or work in a project, chat, or file** | Ordinary sharing from the item's share dialog — see [Workspace Sharing](workspace-sharing.md) | The shared item, at the access level you chose |

> **The AI difference is the one to weigh.** The Support Portal includes an AI agent that triages and answers tickets on its own. In a partnership, AI conversations stay inside the organization that owns them and are never shared across the partnership — so partners collaborate person-to-person on shared tickets. This is deliberate: an AI conversation carries context from its own organization, and sharing it could surface that organization's private data to the other side.

---

# Path 1 — Partnerships

The **Partners** feature lets your organization share its tickets with a partner organization so the two of you can work them together. A provider can even onboard a brand-new (optionally sponsored) organization through the same invitation flow. For general-purpose sharing of chats, projects, and files across organizations, see [Workspace Sharing](workspace-sharing.md) — Partners is the dedicated flow for ticket-management collaboration.

## How a partnership works

A partnership is a simple link between two organizations. Once it's active, a *standing share* covers the ticket owner's tickets — by default, sharing is **automatic**: every ticket is shared with the partner for the life of the partnership, with no ticket-by-ticket granting. The ticket owner (and only the owner) can switch the partnership to **manual** sharing from its Manage dialog, in which case new tickets stay private until shared individually — existing shares are kept.

### Owner and Manager roles

Every partnership has exactly two roles, determined by the *direction* of the invitation:

| Role | Meaning |
|---|---|
| **Owner** | The organization whose tickets are shared out. |
| **Manager** | The organization (and one of its **teams**) that works those tickets. |

When you send an invitation, you choose the direction:

- **"We manage"** — you are the Manager; the organization you invite is the Owner. You also pick which of *your* teams will work the tickets.
- **"They manage"** — you are the Owner; the organization you invite is the Manager.

> **Note:** Co-manage is the only access level in the current version — both organizations collaborate on the shared tickets rather than one side having read-only visibility.

## Partnership shapes

An invitation can reach three kinds of organizations, and the shape affects billing:

| Shape | Invitee organization | Billing |
|---|---|---|
| **Peer** | An existing, independent Portablemind organization | Each pays its own |
| **Independent new** | Created fresh when the invitee signs up | Invitee sets up its own billing |
| **Sponsored** | Created fresh at signup, sponsored by the inviter | Inviter picks a plan tier; billed to the inviter |

Sponsoring is useful when you want to bring a client or sub-organization onto the platform at your expense — you choose their plan tier when you send the invite.

> **Note:** A free-tier organization can *invite* partners but cannot *sponsor* one, since sponsoring requires billing of its own.

## Inviting a partner

Invitations are sent from the **Partners** page (**Administration → Partners**) using the **Invite Organization** button. You invite a partner organization by **email address** — there's no directory to browse. This is deliberate: you always see the same "Invitation sent" confirmation whether or not the email matched an existing organization, so the feature can't be used to probe which organizations exist on the platform.

When you send an invitation, you provide:

- The contact's **email address** at the partner organization.
- The **direction** — whether you or they will manage the tickets.
- Your **manager team**, if you're the Manager — which of your teams works the tickets.
- Optionally, an **organization name** to label the invite and pre-fill their signup.
- Optionally, a **sponsored plan tier** — only honored if the invitee turns out to be new to the platform.

```recording
title: Share tickets with a partner organization
src: https://www.dsiloed.com/api/v1/public/llm_files/2144/raw?key=bd67045b82f3fc231dec7e56d0e6e1be
```

Behind the scenes, one of two things happens:

- **The email is new to the platform** — the contact receives a branded signup email. Following it walks them through creating their organization and admin account; accepting activates the partnership and its standing ticket share in the same step. A sponsored organization is provisioned on the tier you chose (billed to you); an independent one sets up on its own.
- **The email belongs to an existing organization** — that organization's admins see an incoming partnership request in the **Pending** section of their own Partners page. When they accept, the partnership activates. (If they're the Manager, they can pick or change which of their teams works the tickets from the partnership's **Manage** dialog.)

```recording
title: Accept an incoming partnership request
src: https://www.dsiloed.com/api/v1/public/llm_files/2145/raw?key=b2bcb018e74e9c9bf7c394d4c54087a7
```

## Managing your partnerships

The **Partners** page (**Administration → Partners**) lists your partnerships in two groups — **Tickets we manage for others** and **Tickets others manage for us** — plus a **Pending** section covering incoming requests and the email invitations you've sent (which you can resend or cancel). Each partnership row shows the organization, its shape (Peer, Independent, or Sponsored with its plan tier), its status, whether the relationship is tickets-only or also includes workspace sharing, and how many tickets are currently shared. The row's **Manage** button opens the partnership's details, the Manager's team picker, the sharing mode (automatic vs. manual), and the revoke actions.

Partners that already share workspace content with you but don't yet manage tickets appear in a **Workspace Partners — Add Ticket Management** section, where you can invite them to add ticket management to the existing relationship.

## How shared tickets are worked

Once a partnership is active, members of the Manager's designated team see the Owner's shared tickets and can work them directly. The Manager can also link a shared ticket to a **Task** in its own organization — connecting the partner's request to the internal work that fulfills it. The Owner's ticket reflects the status of those linked tasks in its roadmap summary, so the Owner always sees progress without needing access to the Manager's task board.

## Letting partners file tickets against your Applications

Tickets can be linked to an **Application** — a project in your organization that represents the product or system the ticket is about. Within your own organization, anyone filing a ticket picks the Application from a dropdown.

With an active partnership you can **publish an Application to chosen partner organizations** so *their* members can pick it too when they file a ticket with you.

**When to use this:** you maintain a product or system on behalf of a partner (or take requests against one), and you want their tickets categorized against the right Application from the start — without giving the partner any access to the project itself.

**What the partner gets — and doesn't get:**

- Their members see the Application in the ticket **Application dropdown**, marked with your organization's initials so it's clearly yours, and can file tickets against it.
- That is *all* they get. The project never appears in their Projects area, and its tasks, dates, and members stay completely invisible to them. Publishing is not a share — if you want a partner to actually *see or work in* a project, share it from the project's **Access / Membership** dialog instead (see [Workspace Sharing](workspace-sharing.md)).

**How to publish** (administrators only):

1. Open **Projects**, edit the project, and turn on **Publish for ticket intake**.
2. In **Also publish to partner organizations**, pick the partner organizations that should see it when filing tickets. Only your active partners are offered.
3. Save. To withdraw later, remove the partner from the list — or turn the toggle off, which withdraws it everywhere at once.

> **Note:** the **Publish for ticket intake** toggle on its own covers your *own* organization's external reporters (the Support Portal below). The partner list extends the same publication to partner organizations — you can use either or both.

## Ending a partnership

Revoking a partnership (from the partnership's **Manage** dialog) is a hard unshare:

- **Every** ticket grant the partnership created is withdrawn.
- Every link between the Owner's tickets and the Manager's tasks is removed — the Manager can no longer work them.
- For a **sponsored** partner, the sub-organization is soft-landed: its sponsored subscription is cancelled, it becomes independent, and it drops to the **free plan**. It is **never locked out** — it keeps full access to its own data and receives an email letting it know it can upgrade at any time.

> **Tip:** Because revocation removes all cross-organization ticket-task links automatically, neither side needs to clean up manually — but the Manager should capture any in-flight notes before the partnership ends.

For a partnership that also includes workspace sharing, there's a gentler option: **Remove Ticket Management** withdraws just the ticket-management side while the workspace sharing relationship continues.

---

# Path 2 — The branded Support Portal

For customers who don't use Portablemind — and shouldn't have to — you can stand up a **public support page under your own domain and branding**. Your customers sign up there, file tickets, attach screenshots, and get answers. The tickets land in your Tickets app alongside everything else.

## What your customer experiences

1. They visit your support page (for example `support.yourcompany.com`) and sign up with an **access code** you gave them. No Portablemind account, no invitation to your organization.
2. They file a ticket — title, description, and any screenshots or logs.
3. **An AI support agent picks it up immediately**, reads the ticket *and its attachments*, and replies. The reply appears in their portal thread and is emailed to them.
4. They can reply back and the agent responds again. If it can't resolve the issue after a couple of attempts, it hands off to your team and tells the customer a person will follow up by email.
5. They can add teammates from their own company, who then see the same organization's tickets.

## What your team experiences

Portal tickets are ordinary tickets. They appear in the **Tickets** app with the reporter's details, so your team can prioritize, comment, change status, and link them to Tasks exactly as with any other ticket.

Two things behave differently, both deliberately:

- **Your internal notes stay internal.** Anything your team writes on a portal ticket is invisible to the customer. Only the AI agent's published replies reach them.
- **Replying to a customer means email.** Because internal notes are hidden, a team member picking up an escalated ticket should reply by email to the reporter's address — the portal thread is not a staff reply channel.

## What the customer can and cannot see

The portal account is deliberately narrow. A customer signed up through it can see:

- their own organization's tickets, and the files they attached to them;
- the AI agent's replies to those tickets.

They cannot see other customers' tickets or files, your internal chats, your users, or anything else in your workspace — enforced by the server on every request, not just hidden in the page.

## Setting it up

The portal is a small self-hosted web app that talks to your Portablemind organization. Standing it up is a one-time technical task for whoever runs your infrastructure:

- Deploy the portal app and point it at your organization.
- Set your **branding** — logo, colours, and product name come from your organization's branding settings, so the page looks like yours rather than ours.
- Point a subdomain such as `support.yourcompany.com` at it.
- Choose an **access code** and give it to customers who should be able to sign up. Codes can be rotated at any time, and you can issue a different code per customer so one can be retired without affecting the others.
- Create a dedicated service account for the portal to act as. Use a service account rather than a person's login — if that person is renamed or deactivated, ticket intake stops silently.

Setup instructions ship with the portal application itself.

---

For API-level details, see the [API guide](https://www.dsiloed.com/apps/apiguide/index.html).
