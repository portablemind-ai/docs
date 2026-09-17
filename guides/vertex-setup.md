# Connecting Google Vertex AI

Google Vertex AI serves several model families through one Google Cloud project — Anthropic's Claude, Google's Gemini, and open models such as Llama, Mistral and Qwen. Connecting Vertex is useful when you want **all** of your AI spend to run through Google Cloud billing (including any committed-spend discounts or credits you already have) rather than paying each model vendor separately.

Vertex works differently from the other providers on [Setting Up AI Models](ai-setup.md). Those use a per-model API key that you paste in. Vertex authenticates with **one workspace-level connection to your Google Cloud project**, shared by every Vertex model. There is no per-model API key.

> **Note:** Vertex does not use API keys for Claude. Google's key-based "Express mode" covers only some Gemini use, and Anthropic's Claude models on Vertex require Google Cloud credentials. The connection below is what makes Claude on Vertex work.

## Before you start

You need:

- A Google Cloud project, and permission to manage IAM in it (the **Project IAM Admin** or **Owner** role).
- The **Vertex AI API** enabled in that project. In the Cloud Console go to *APIs & Services → Library*, search for "Vertex AI API", and click **Enable**.
- For Claude specifically, approved Claude quota — see [Enabling Claude models](#enabling-claude-models) below.

## Choose how to authenticate

There are three ways to connect, and they trade off security against how much setup they need. **Impersonation is recommended** — Google discourages downloading service-account keys, because a downloaded key is a long-lived secret that can be copied and is awkward to rotate.

| Method | What you store with us | Setup effort | Use when |
|---|---|---|---|
| **Service account impersonation** *(recommended)* | Nothing secret — only an email address | One IAM grant | Almost always |
| Service account JSON key | The full private key, encrypted | Download a key file | You cannot grant cross-project IAM |
| OAuth access token | A short-lived token, encrypted | Run one command | Quick tests only — expires in about an hour |

---

## Option 1 — Service account impersonation (recommended)

### How it works

You create a service account in **your** Google Cloud project and give it permission to use Vertex AI. You then grant Portablemind's own service account permission to *act as* that account.

When one of your models runs, Portablemind asks Google for a short-lived token on behalf of your service account, and Google issues one only because you granted that permission. Nothing secret is ever stored on our side — the "credential" is just an email address. You can revoke access at any time from your own Cloud Console, without involving us.

Think of it like adding someone to a shared drive: you are not handing over your password, you are granting a named account access that you can withdraw.

### Step 1 — Create a service account for Vertex

In the Cloud Console, go to *IAM & Admin → Service Accounts → Create service account*.

- **Name:** something recognisable, e.g. `portablemind-vertex`
- Click **Create and continue**
- Under **Grant this service account access to project**, choose the role **Vertex AI User** (`roles/aiplatform.user`)
- Click **Done**

Copy the email address it creates. It looks like:

```
portablemind-vertex@your-project-id.iam.gserviceaccount.com
```

### Step 2 — Let Portablemind act as that service account

This is the step that makes impersonation work, and it is the one people miss.

You are granting the **Service Account Token Creator** role (`roles/iam.serviceAccountTokenCreator`) **on the service account you just created** — not on the whole project — to the Portablemind service account for **your workspace**.

1. Still in *Service Accounts*, click the service account you just created.
2. Open the **Permissions** tab.
3. Click **Grant access**.
4. In **New principals**, paste Portablemind's platform service account address.

   **Where to find it:** open *AI Studio*, add or edit a Vertex model, and look at the **Google Vertex AI Connection** panel. The address is displayed there with a **Copy** button, above the "Service Account to Impersonate" field. It is created for your workspace automatically the first time you open that panel — there is nothing to request and nobody to wait on.

   It looks something like `pm-vertex-t42@portablemind-platform.iam.gserviceaccount.com`.

   > **This address is unique to your workspace** — it is not shared with other Portablemind customers. That is deliberate: a single shared identity would accumulate every customer's grant, which would let one customer's workspace impersonate another's service account simply by naming it. Because your grant applies only to your own workspace's identity, nobody else's workspace can use it. Copy the value from your own panel rather than reusing one from elsewhere.

   The address is an identifier, not a secret — it identifies who is asking, and only your grant decides whether they are allowed.
5. In **Role**, select **Service Account Token Creator**.
6. Click **Save**.

The same thing from the command line, if you prefer:

```bash
gcloud iam service-accounts add-iam-policy-binding \
  portablemind-vertex@YOUR-PROJECT-ID.iam.gserviceaccount.com \
  --member="serviceAccount:PORTABLEMIND-PLATFORM-SA" \
  --role="roles/iam.serviceAccountTokenCreator"
```

Replace `YOUR-PROJECT-ID` with your project and `PORTABLEMIND-PLATFORM-SA` with the address copied from the connection panel.

> **Why on the service account, not the project?** Granting Token Creator at the project level would let Portablemind impersonate *every* service account you have. Granting it on this one account limits access to exactly the Vertex permissions you chose in step 1.

> **Note: allow a minute or two before testing.** Google Cloud takes time to
> propagate an IAM change — typically under a minute, occasionally a few. Until
> it lands you will see a **403 "Permission denied"** on
> `iam.serviceAccounts.getAccessToken`, even though the grant is saved and
> correct. This is expected and is *not* a configuration error. If you see it
> right after granting access, wait a minute and send another message before
> changing anything. If it is still failing after about five minutes, then
> check the grant against the troubleshooting table below.

### Step 3 — Fill in the connection in Portablemind

In *AI Studio*, add or edit a Vertex model. In the **Google Vertex AI Connection** panel:

- **GCP Project ID** — your project id, e.g. `my-project-123456` (the id, not the display name)
- **Region** — use `global` unless you have a data-residency requirement. Regional endpoints cost about 10% more
- **Service Account to Impersonate** — the email from step 1
- Leave **Service Account JSON Key** and **OAuth Access Token** blank

Save, then send a test message to the model.

---

## Option 2 — Service account JSON key

Use this if you cannot grant cross-project IAM — for example when your organisation's policy blocks it.

1. Create a service account with the **Vertex AI User** role, as in step 1 above.
2. Open the service account, go to the **Keys** tab, and choose *Add key → Create new key → JSON*. A file downloads.
3. In Portablemind, paste the **entire contents of that file** into **Service Account JSON Key** — including the outer `{` and `}`.
4. Leave **Service Account to Impersonate** blank.

> **Warning:** That file is a long-lived private key. Store it as you would a password, delete your local copy once pasted, and rotate it periodically. This is exactly what impersonation avoids, which is why it is the recommended option.

We encrypt the key at rest and never display it again — the field stays blank when you reopen the dialog, and leaving it blank keeps the stored value.

---

## Option 3 — OAuth access token

For quick testing only. Run:

```bash
gcloud auth print-access-token
```

Paste the result into **OAuth Access Token**. It expires in about an hour, after which the model stops working until you paste a new one. Do not use this for anything ongoing.

---

## Enabling Claude models

Claude on Vertex needs quota that Google does not grant by default. If Claude models return a **429 "Quota exceeded"** error, that is what's happening — your connection is working, but the project has no Claude capacity yet.

1. In the Cloud Console go to *IAM & Admin → Quotas & System Limits*.
2. Filter by the service **Vertex AI API** and search for `online_prediction_requests_per_base_model`.
3. Select the row matching the Claude model you want (for example `anthropic-claude-sonnet`) and the endpoint type you configured — `global` if you used the `global` region.
4. Click **Edit quota**, request a limit, and submit the justification form.

Approval is typically quick but is not instant. Gemini and the open models work immediately and need no quota request.

## Which models can I use?

Once connected, Claude and Gemini models appear in the model picker like any other. Prices shown are Google's published Vertex rates.

Open models from Model Garden (Llama, Mistral, Qwen, gpt-oss) are supported by the connection but are not pre-loaded into the catalog, because Google does not publish their per-token prices publicly — adding them without a confirmed rate would under-report your AI spend. If you want them, ask your administrator to add them with the rate from your Google Cloud invoice.

## Troubleshooting

| What you see | What it means |
|---|---|
| `429 Quota exceeded ... anthropic-claude-*` | Connection is fine; request Claude quota (above) |
| `403 Permission denied` on a token request, immediately after granting access | Almost always IAM propagation — wait a minute and retry before changing anything |
| `403 Permission denied` on a token request, persisting past ~5 minutes | The Token Creator grant in step 2 is missing, or was made on the wrong service account |
| The connection panel shows no service account address | Portablemind could not resolve its own project (e.g. running outside Google Cloud) — use a service-account JSON key instead |
| `403` mentioning your workspace's `pm-vertex-...` account | Your workspace's identity has not been provisioned yet — contact your Portablemind administrator |
| `is not a valid GCP identifier` | Project id or region contains unexpected characters — use the plain id, e.g. `my-project-123456` and `global` |
| `not valid JSON` | The JSON key was pasted partially — paste the whole file including the braces |
| Model works, then fails about an hour later | You used an OAuth access token; switch to impersonation or a key |

## Related

- [Setting Up AI Models](ai-setup.md) — connecting the other AI providers
- [Building AI Agents](agents.md) — giving agents their own model
