# File Management

Portablemind includes a full-featured file management system that works like **Google Drive**. You can upload documents, images, spreadsheets, and other files, organize them into folders, and control exactly who can see each file — all from the same interface you use for chat and projects. You'll find it in the **Files** area of the app.

If you've used Google Drive, Dropbox, or SharePoint, you'll feel right at home. The key concepts are the same: folders, sharing, and privacy controls.

## Supported file types

- **Documents** — PDF, Word (.docx), Markdown, plain text
- **Spreadsheets** — Excel (.xlsx, .xls), CSV, OpenDocument (.ods)
- **Presentations** — PowerPoint (.pptx, .ppt)
- **Images** — PNG, JPG, GIF, and other image formats
- **Audio & video** — MP3, WAV, MP4, and more

### Viewing files in the app

Most files preview directly inside Portablemind — no download needed:

- **PDFs, images, and CSV files** open in the built-in viewer.
- **Office documents** — Word, Excel, and PowerPoint (including .pptx decks) — render inline: the platform converts them to PDF on its own servers for viewing, so your files are never sent to a third-party viewer. If a particular file can't be converted, you're offered a download instead.
- **Video files** play in a built-in player that streams and seeks without downloading the whole file.
- **Markdown and text files** render as formatted documents.

## Folders

Files are organized into **folders** (directories), just like on your computer or in Google Drive. Folders can be nested to any depth, and empty folders are allowed — you don't have to put a file in them straight away.

Files upload into the folder you're currently viewing — navigate to the right place first, or move files later. You can create folders with the **New Folder** action, and if you drag & drop an entire folder from your computer, its structure (including subfolders) is recreated automatically.

> **Tip:** Use a logical folder structure that matches your projects or teams. For example: `/Marketing/2026/Q2` or `/Client Documents/Acme Corp`.

```recording
title: Organize and share files
src: https://www.dsiloed.com/api/v1/public/llm_files/2137/raw?key=9e1f1e2cbc85c0d2eedfdfa6b234fe40
```

## File privacy

Every file has a **privacy setting** that controls who can see it. This works just like the "Restricted" vs "Anyone with the link" setting in Google Docs:

| Setting | Who can see the file | Google Drive equivalent |
|---|---|---|
| **Public** | Everyone in your organization | "Anyone in [Your Company]" |
| **Private** | Only you, people you share with, and people in conversations where the file was shared | "Restricted" |

### Setting privacy at upload

When you upload a file, the upload dialog includes a **Private** toggle. The default depends on your organization's settings (set by your admin):

- If your org uses **"All Tenant Members"** access, files default to **Public**.
- If your org uses **"Specific People/Teams"** access, files default to **Private**.

You can always override the default by flipping the toggle before uploading.

> **Warning:** Only the file owner (the person who uploaded it) can change a file's privacy setting after upload. Even organization admins cannot change another person's privacy setting.

## Sharing files and folders

### Sharing a folder

When you share a folder with someone (or a team), they can see **all the files inside that folder** — including files uploaded in the future. This is the same as sharing a Google Drive folder: share once, and everything inside is accessible.

### Private files in shared folders

Here's where it gets interesting. If you mark a file as **Private** and place it in a shared folder, the file stays hidden from everyone the folder is shared with. **Privacy always wins over folder sharing.**

This is the same pattern as Google Drive: you can have a restricted document inside a shared folder, and people with folder access still can't see that specific file.

> **Note:** Example — you share the `/Team Reports` folder with your team, then upload a performance review as *Private* to that folder. Your team can see all the other files in the folder, but the performance review is invisible to them unless you share it with them directly.

### Who can see a private file?

- **The file owner** — you can always see your own files.
- **People you share it with directly** — using the sharing feature to grant specific access.
- **People in a conversation where the file was shared** — if you attach the file to a chat message, everyone in that conversation can access it.

### Who cannot see a private file?

- **Other people in your organization** — even if they have general file access.
- **People with folder access** — privacy overrides folder sharing.
- **Organization admins** — admin status does not bypass file privacy.

```recording
title: Set file privacy and share with specific people
src: https://www.dsiloed.com/api/v1/public/llm_files/2143/raw?key=d4f66eccb32afb1ef570a4e11f206057
```

## Sharing folders across organizations

Folders can be shared across organizations. When someone from another organization shares a folder with you, it appears under the **Shared Files** section of your folder tree (labeled with the owning organization's name), and you can browse and open files inside it just like your own.

This works the same way as Google Drive's "Shared with me" — you see the shared folder and its contents, but the files still belong to (and are stored in) the other organization.

Private files in a shared folder are still hidden — the privacy rules apply across organizations too. To learn more about collaborating across organizations, see [Workspace Sharing](workspace-sharing.md).

## AI and your files

Files you upload are automatically processed so that AI assistants can understand their contents. When you attach a file to a chat conversation, the AI can read documents, analyze spreadsheets, and describe images. See [AI Assistant](ai-assistant.md) for more on working with AI in conversations.

How the AI uses each file type:

- **Documents & Markdown** — the full text is extracted and included in the conversation.
- **Spreadsheets** — the data is structured for AI analysis: small files are included directly; large files are queryable.
- **Images** — sent to vision-capable AI models for description and analysis.

> **Note:** Privacy is respected by AI too. AI assistants and their tools can only access files that the current user has permission to see. A private file you didn't create or weren't shared on is invisible to AI tools as well.

## For admins: configuring file access defaults

Organization administrators can control the default file visibility for all users from the **Access Defaults** page in Administration settings.

| Setting | What it means | Upload default |
|---|---|---|
| **All Tenant Members** | Everyone in the organization can browse and see all files by default | **Public** |
| **Specific People/Teams** | Files are only visible to the owner and people explicitly shared with | **Private** |

This setting controls the *default* only. Individual users can always override it when uploading by toggling the Private switch in the upload dialog.

> **Tip:** If your organization handles sensitive client data, use **"Specific People/Teams"** so that files are private by default and must be explicitly shared. For open, collaborative teams, **"All Tenant Members"** gives everyone immediate access and reduces friction.

## Quick reference

| I want to... | How |
|---|---|
| Upload a file | Go to Files, drag & drop or click Upload. Set the title and privacy, then upload. |
| Make a file private | Toggle the **Private** switch at upload, or click the lock icon on the file's row afterward (owner only). |
| Share a file with someone | Use the sharing feature to grant specific people or teams access to the file. |
| Share a whole folder | Share the folder — all current and future files inside become visible to the recipient (except private files). |
| Hide a file in a shared folder | Mark it as **Private**. It will be invisible to everyone the folder is shared with. |
| Let AI read my file | Attach the file to a chat message. The AI will automatically process and understand its contents. |
| Change the org-wide default | (Admin only) Go to Administration and update the file visibility setting under Access Defaults. |
