# White-label Branding & Single Sign-on

White-label lets you put **your** name on Portablemind: your logo, colours and emails, and a way for people who are already signed in to your own app to land in the workspace without a second login.

It's part of the **Enterprise** plan. If your workspace is a [sub-workspace](sub-workspaces.md) of an Enterprise workspace, it's included with theirs — you don't need Enterprise yourself.

## Switching it on

Go to **Administration → Branding**. At the top is **White-label & single sign-on**:

- If it says white-label is part of the Enterprise plan, your plan (or your parent workspace's) doesn't include it yet.
- Otherwise, flip **White-label is on**. The badge next to the title turns to **On**, and the rest of the Branding page — logo, theme and email templates — appears underneath.

A sub-workspace shows a small note saying whose plan it's included with.

> **Tip:** switching white-label off hides your branding and stops single sign-on, but keeps everything you configured. Switch it back on and it's all still there.

## Your brand

Once it's on, the Branding page gives you:

| Setting | What it changes |
|---|---|
| **Logo** | The mark in the app header and on the sign-in screen, with separate light and dark versions. PNG, JPEG or WebP, up to 5 MB — use a square icon rather than a wide wordmark, because it's shown small |
| **Theme** | Colours for the app's surfaces, in light and dark mode. Save themes to a library and switch between them |
| **Email templates** | The emails the workspace sends — invitations, activation, password reset and more — in your own words and look |

Every workspace brands itself. A sub-workspace's branding is its own and never changes its parent's or its siblings'.

## Single sign-on from your own app

If you run your own app or portal, its **server** can sign people straight into the workspace. Under **Single sign-on** you set:

| Setting | What it does |
|---|---|
| **Create an account the first time someone signs in through your app** | On: a person your app vouches for gets an account automatically. Off: only people who already have an account can come in this way |
| **Role for people who sign in this way** | The security role new accounts get. Pick a limited role so they see only what you intend. A role that can create users, grant roles or change configuration — admin roles included — is refused, and if the chosen role is later removed, new sign-ins are declined rather than given a broader one |
| **Your app's address** | Links in emails — password resets, invitations — point to your app instead of the Portablemind app. It must be a web address (`https://…`) |
| **Hosts people may return to after signing out** | Where the workspace is allowed to send people back to |

### The sign-on key

Your app's server proves who someone is by signing a short-lived pass with a **sign-on key**. Choose **Create a sign-on key**, and the key is shown **once**:

- Copy it straight into your server's secrets. It can't be shown again.
- Keep it on the server. Never put it in a web page or a mobile app.
- **Replace the sign-on key** makes a new one. The old key stops working immediately, so sign-in from your app fails until its server has the new one.

Creating and replacing a key are both recorded in the workspace's audit log — if the record can't be written, the key isn't changed. While a new key is on screen the dialog stays open until you confirm you've stored it. The API guide listed in [Developer Resources](developers.md) has the technical details for your developers.

## Setting it up for your sub-workspaces

If you run sub-workspaces for your customers, you can do all of the above for each of them without signing in to it. On the **Tenants** page, use the **White-label & single sign-on** button on a sub-workspace's row: switch it on, set its sign-on settings, and create its sign-on key.

Each sub-workspace has its **own** switch and its **own** key — a key for one never works for another. When you create a key for a sub-workspace, that's recorded in the sub-workspace's own audit log, so its admins can see it happened.

> **Tip:** whoever holds a workspace's sign-on key can sign people in to it. Create keys for your sub-workspaces only on servers you run, and replace a key straight away if it may have leaked.

The sub-workspace's own admins can also do this for themselves, and they manage their own logo, theme and email templates from their Branding page.

You'll see the button when your own plan includes white-label. For a sponsored partner account (that's their own workspace to set up), or a sub-workspace that is in the middle of leaving your agreement, the dialog tells you it isn't set up from here.

When a sub-workspace becomes independent of you — straight away for one that pays for itself, or at the end of its grace period otherwise (see [Enterprise Sub-workspaces](sub-workspaces.md)) — white-label is switched off for it and **its sign-on key is removed**, so a key you hold can never open a workspace that is no longer yours. Its logo, theme and email templates are kept, and come back if it moves to Enterprise itself and switches white-label on again.

## What Portablemind support can and can't do

Sometimes it's easier to ask us. If you're entitled to white-label, **Portablemind support can switch it on or off for your workspace** — for example when you're setting up with us on a call, or if you need single sign-on shut off quickly and can't reach your own admin.

That switch is the *only* thing we can touch:

- **Our support tools can't create, replace or show your sign-on key.** Only your own admins can — or, for a sub-workspace, the admins of the Enterprise workspace it belongs to. A key lets its holder sign people in to your workspace, so it is never ours to hold.
- **We can't change your sign-on settings** — where your links point, or the role new people get.
- **We can't give white-label to a workspace whose plan doesn't include it.** That's a plan change.

Whenever we flip the switch, it's recorded in **your** audit log (the **Audit Trail** in Administration) as a white-label settings change marked **platform operator**, so your admins can always see that it happened and when.

Switching off stops *new* sign-ins from your app and hides your branding straight away; people who are already signed in stay signed in until their session ends.

> **Tip:** if you switched white-label off because a sign-on key may have leaked, **replace the key before anyone switches it back on** — switching on re-opens sign-in for whoever holds the existing key.
