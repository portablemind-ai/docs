# Apps

Apps add whole new areas to your workspace without adding to Portablemind itself. An app is a web application that runs on its own server — ours, or yours — and opens **inside** Portablemind: same sign-in, same navigation, and it works as the person using it, within limits your workspace controls. Install one from the catalog, or build your own.

Apps come with every paid plan. The first app in the catalog is [the AI Office](ai-office.md).

## Where apps appear

Once an app is installed and enabled, its entries appear in the **app switcher** (the grid icon in the top bar) under **Apps**, and in the **Jump Bar** if you use it. Opening one shows the app in the main area with Portablemind's header and navigation around it, and the app's own name in a title strip. Nothing about the app is downloaded or installed on your computer.

> **Note:** an app has no page of its own outside Portablemind. If you reach its address directly, it tells you to open it from the app switcher.

## Installing and managing apps

Apps are managed by workspace administrators in **Administration → Platform → Apps**. If the page says Apps are not turned on for your workspace yet, ask Portablemind support to switch them on; if it says they are not included in your plan, that is a plan change.

### Installed

Every app the workspace has, with:

| Control | What it does |
|---|---|
| **Enabled** switch | Off hides the app's menu entries at once and ends its sessions, without removing it. On brings it back exactly as it was |
| **Open** | Takes you to the app |
| **Rotate secret** (your own apps only) | Replaces the app's secret — see [Your own apps](#your-own-apps) |
| **Uninstall** | Removes the app, its menu entries and its sessions. Roles it added stay in the workspace, and the dialog lists them, so remove them in Security roles if nobody needs them |

### Catalog

Portablemind's own apps. Choose **Install** on one and you see a review first:

- **New roles and permissions** the app brings with it.
- **Additions to roles people already hold** — a permission the app adds to a role your members have today.
- **Existing roles it takes over** — a role already in the workspace that the app will manage from now on.

Nothing changes until you confirm. Many apps, the AI Office among them, add no roles or permissions at all and use the access people already have.

### Custom apps

Your own, or a partner's. Paste or upload the app's **manifest** — a short JSON file that names the app, where it runs and what it may ask Portablemind for — and any role files it lists, then choose **Review**. The review is the same dry run as a catalog install: nothing is created until you confirm. A manifest that names an address that is not `https://`, points somewhere outside the app's own site, or asks for something the platform does not offer is refused with the reason.

On install you are shown the app's **secret once**. Copy it straight into the app's server configuration and confirm you have stored it; it cannot be shown again. If it may have leaked, **Rotate secret** on the Installed tab makes a new one: the old one stops working at once and everyone using the app is signed out of it until its server has the new one.

## What an app can and cannot do

This is the part worth knowing before you install anything.

- **It runs in a sealed frame.** The app's page comes from the address its manifest named and nowhere else. It cannot read Portablemind's page, your other tabs or your cookies, and Portablemind cannot see inside the app. The two talk only over a narrow set of messages: the app may set its title, show a toast, ask to open a conversation, file, task, board or ticket, or hand a question to the AI assistant — and only the kinds it declared in its manifest.
- **It acts as you, in this workspace only.** When an app needs data it asks Portablemind for a pass; the pass lasts a minute and is good for that app alone. The app's server trades it for its own access, which is yours — it sees what you can see and does what you can do, in the workspace you opened it from. It never receives your password or your own sign-in, and it cannot switch workspaces.
- **It is weaker than you.** Even acting as you, an app cannot manage security roles, users or API keys, change sharing or invitations, add members, connect AI tools, or issue further passes. Those stay with people.
- **Disable it and it is gone.** Switching an app off or uninstalling it removes its menu entries at once and ends every session it holds; its server can no longer act for anyone in the workspace.

Every install, change of status, uninstall and secret rotation is recorded in the workspace's audit trail.

> **Tip:** a custom app you install can only do what the person using it can do — but it can do all of that. Install apps from people you trust, and give app-only users a role scoped to what the app needs (see [Shipping a role with your app](developers.md#shipping-a-role-with-your-app)).

## Your own apps

Anyone who can build a web page can build an app. The smallest one is a single static page and a manifest of about thirty lines; an app that reads or writes workspace data adds a small server that holds the secret. Developers start at [Building an embedded app](developers.md#building-an-embedded-app).
