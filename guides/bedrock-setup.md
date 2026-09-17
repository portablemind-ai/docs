# Connecting AWS Bedrock

AWS Bedrock serves several model families through one AWS account — Anthropic's Claude, Amazon's Nova, and open models such as Llama, Mistral, Qwen and Kimi. Connecting Bedrock is useful when you want your AI spend to run through AWS billing (including existing committed spend or credits) rather than paying each model vendor separately.

Bedrock works differently from the providers on [Setting Up AI Models](ai-setup.md). Those use a per-model API key that you paste in. Bedrock authenticates with **one workspace-level connection to your AWS account**, shared by every Bedrock model. There is no per-model API key.

## Before you start

You need:

- An AWS account, and permission to manage IAM in it.
- **Model access granted** for the models you want. This is the step people miss — Bedrock hides every model until you request access. In the AWS console go to *Bedrock → Model access*, click **Modify model access**, tick the models you want (e.g. the Anthropic Claude family), and submit. Most approve within minutes; some ask a few questions about your use case first.

> **Note:** Brand-new AWS accounts are sometimes gated for a day or so even after model access is granted, returning a 403 that says the model "is not available for this account". This usually clears itself within 24 hours — it is not a configuration error on your side.

## Choose how to authenticate

There are two ways to connect. Both are workspace-level.

| Method | What you store with us | Use when |
|---|---|---|
| **Bedrock API key** *(simplest)* | A bearer token, encrypted | Almost always |
| IAM access key pair | Access key id plus secret, encrypted | Your organisation standardises on IAM keys |

If both are filled in, the Bedrock API key is used.

---

## Option 1 — Bedrock API key (recommended)

Bedrock supports long-lived API keys, which are simpler than IAM credentials and scoped to Bedrock alone.

1. In the AWS console, open **Amazon Bedrock**.
2. In the left-hand navigation choose **API keys**.
3. Click **Generate long-term API key**, choose an expiry, and copy the value shown. AWS displays it once.
4. In Portablemind's *AI Studio*, add or edit a Bedrock model. In the **AWS Bedrock Connection** panel:
   - **AWS Region** — `us-east-1` is the safest default; it has the widest model availability
   - **Bedrock API Key** — paste the key
   - Leave the IAM fields blank

Save, then send a test message.

---

## Option 2 — IAM access key pair

1. In *IAM → Users*, create a user (or reuse one) for Portablemind.
2. Attach a policy granting Bedrock model invocation — the AWS managed policy **AmazonBedrockFullAccess** works, or scope it down to `bedrock:InvokeModel` and `bedrock:Converse` for least privilege.
3. Under **Security credentials**, create an access key. Copy both the access key id and the secret.
4. In the connection panel, fill in **AWS Access Key ID** and **AWS Secret Access Key**, and leave the Bedrock API Key blank.

> **Warning:** The secret access key is shown once. Treat it like a password and rotate it periodically.

We encrypt secrets at rest and never display them again — those fields stay blank when you reopen the dialog, and leaving them blank keeps the stored values.

## Choosing a region

Region matters more on Bedrock than on most providers, because model availability and price both vary by region.

- `us-east-1` has the broadest model coverage and is the recommended starting point.
- Claude models are billed at the same rate as Anthropic's own API when you use the **global** inference profile. Region-specific profiles cost about 10% more.
- If a model works in one region and 404s in another, that model simply isn't offered there — switch the region rather than debugging the connection.

## Which models can I use?

Once connected, both Claude and the non-Anthropic models appear in the model picker.

Claude models on Bedrock support the full feature set — tool use, prompt caching, and image input. Some open models are text-only; the model picker reflects what each one supports, and attachments they cannot read are replaced with a short placeholder rather than being sent and rejected.

## Troubleshooting

| What you see | What it means |
|---|---|
| `403 ... not available for this account` | Model access not granted yet, or a new-account gate that clears within ~24h |
| `AccessDeniedException` | The API key or IAM policy lacks Bedrock invoke permission |
| `ValidationException` about the model id | That model isn't offered in the configured region — try `us-east-1` |
| `unable to sign request without credentials set` | Partially filled IAM fields — supply both the key id and the secret, or use an API key instead |

## Related

- [Setting Up AI Models](ai-setup.md) — connecting the other AI providers
- [Connecting Google Vertex AI](vertex-setup.md) — the equivalent setup on Google Cloud
