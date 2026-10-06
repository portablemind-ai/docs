# Custom Statuses

Projects, tasks and tickets each move through a list of **statuses**, such as Open, In Progress or Closed. Portablemind comes with a standard set for each, and your workspace can add its own alongside them, for example **On Hold**, **Targeted** or **Delivered**.

Statuses are managed in **Administration → System Defaults → Status Management**. You need access to Administration to change them.

## The Status Management page

The page has a tab for each kind of status:

- **Project Statuses**
- **Task Statuses**
- **Ticket Statuses**

Each tab shows how many statuses it holds, and lists them with these columns:

| Column | What it shows |
|---|---|
| **Name** | The name people see on forms, filters and badges |
| **Identifier** | A fixed, machine-readable name (lowercase letters, numbers and underscores) |
| **Category** | **To Do**, **In Progress** or **Done**. See [Categories and resolutions](#categories-and-resolutions) |
| **Resolution** | For a **Done** status, either **Done** or **Won't Do**. Shows a dash for any other category |
| **Type** | **System** for the standard statuses, **Custom** for ones your workspace created |

### System and custom statuses

- **System statuses** are the standard set every workspace starts with. They're **read-only**: you can't edit or delete them, and the Actions column says *Read-only*.
- **Custom statuses** belong to your workspace. Only your workspace sees them, and you can edit and delete them with the pencil and bin icons.

If you need a status the standard set doesn't have, create your own rather than trying to change a system one.

## Adding a status

1. Open the tab for the kind of status you want (Project, Task or Ticket).
2. Choose **Add Status**.
3. Fill in the form:
   - **Status Name**: what people will see, for example *On Hold*.
   - **Identifier**: a unique name such as `on_hold`, using lowercase letters, numbers and underscores. It **can't be changed later**.
   - **Category**: To Do, In Progress or Done. A new status starts in **To Do**.
   - **Resolution**: only appears when the category is **Done**. Pick **Done** or **Won't Do**.
4. Choose **Create**.

To change a custom status, use its pencil icon. You can change the name, category and resolution. The identifier stays as it was.

## Categories and resolutions

Every status, system or custom, has a **category** that says where work in that status stands:

| Category | Meaning |
|---|---|
| **To Do** | Not started yet |
| **In Progress** | Being worked on |
| **Done** | Finished. Nothing more will happen to it |

**Done** means the item's life is over. It doesn't say whether the work actually got done. That's what the **resolution** is for, and only Done statuses have one:

| Resolution | Meaning | Example |
|---|---|---|
| **Done** | The work was completed | *Resolved*, *Delivered* |
| **Won't Do** | It was closed without the work being done | *Cancelled*, *Rejected*, *Duplicate* |

So a *Cancelled* status would be **Done / Won't Do**: finished, but not completed. If you've used Jira, these work the same way as its status categories and resolutions.

System statuses come with their category already set. For example, the task statuses *Blocked* and *On Hold* are **In Progress** (work that started and then stopped), *Ticket Resolved* is **Done / Done**, and the task status *Cancelled* is **Done / Won't Do**.

Custom statuses start in **To Do**. Set the right category when you create one, or edit it afterwards, so that a status like *Delivered* is recorded as **Done / Done** rather than To Do.

## What a category changes

### Lists, counts and filters go by category

These views decide what is open, finished or completed from the **category** (and, for "completed", the **resolution**) of each status. That applies to every status, system or custom:

| Where | What it does |
|---|---|
| **Tickets: Active view and its sidebar count** | Hides tickets in **any Done** status: *Ticket Resolved*, *Ticket Closed*, and your own Done statuses such as *Delivered* |
| **Tickets: status badges** | System statuses keep their usual colours. Your own ticket statuses in **In Progress** or **Done** are coloured by category, so a custom Done status looks like *Ticket Resolved*. Your own statuses still in **To Do** stay grey. Desktop and mobile use the same colours |
| **Tickets on mobile** | The badge shows the ticket's status by name, in the same colour as on desktop. The menu shows counts for **Active**, **My Tickets**, **All Tickets** and **Starred**, which match the desktop sidebar |
| **Dashboard Tickets widget** (*Open*, *Assigned to me*, *High priority*) | Hides tickets in any Done status |
| **Dashboard Tasks widget** (*My open tasks*, *Overdue*, *Due this week*) | Hides tasks in any Done status: *Completed*, *Cancelled*, *Failed*, and your own Done statuses |
| **Tasks page: Show Completed** (unticked) | Hides every task in **any Done** status, so only work still to do shows. That covers *Completed*, *Cancelled*, *Failed*, and your own Done statuses of either resolution. Tasks with no status stay visible |
| **Gantt: Show Completed** (unticked) | Same rule as the Tasks page: hides tasks in any Done status, including *Cancelled* and *Failed* |
| **Project pickers** (Tasks page, Gantt, Kanban board, the task dialog) | Leave out projects in any Done status: *Completed*, *Cancelled*, *Rejected*, and your own Done statuses |
| **Projects: Active Projects view and its sidebar count**, and the project picker when you start a pipeline | Hide projects in **any Done** status: *Completed*, *Cancelled*, *Rejected*, and your own Done statuses |
| **Kanban board checklists and predecessor warnings** | A checklist item is ticked, and a predecessor counts as complete, when its status is **completed** (**Done / Done**), including your own Done / Done statuses. A *Cancelled* item isn't ticked, and a *Cancelled* predecessor still triggers the warning. A status no longer counts as complete just because its name contains "completed", "done" or "approved" |
| **Roadmap summary on a ticket** (from its linked task) | **Shipped** when the task is **Done / Done**. **In Progress** when the task's status is In Progress, which now includes *Blocked* and *On Hold*. **Planned** for To Do and for **Done / Won't Do** (*Cancelled*, *Failed*). A custom status whose category was never set is still read by its name, as before |

Records with no status at all are never hidden by these filters.

### Everything else keeps its built-in meaning

For the rest, **system statuses behave as they always have**: *Task Completed* counts as finished work, *Ticket Resolved* and *Ticket Closed* close a ticket, and so on, whatever category they show. The one exception is agent waits (below), which also wake on other Done statuses such as *Cancelled*.

**A custom status is treated like its system equivalent once you set its category.** While a custom status is in **To Do** (where every new one starts), nothing below applies to it.

| Your custom status | What happens |
|---|---|
| **Task status set to Done / Done** | It counts as completed work, the same as *Task Completed*: the task's progress goes to 100%, and it counts towards sprint velocity (story points) and burndown |
| **Task status set to Done / Won't Do** | The task is finished but **not** completed. It doesn't count as completed work, and the task keeps the progress it had |
| **Ticket status set to Done** (either resolution) | The ticket is closed, the same as *Ticket Resolved* or *Ticket Closed*: a customer can no longer reply on it from the support portal and opens a new ticket instead. Your own team can still write on it |
| **Project status set to Done** (either resolution) | The project is treated as finished, the same as *Completed* or *Cancelled*. It's no longer offered as an Application to file tickets against |

**Agents waiting for a task.** An AI agent told to wait until a task is completed also wakes up when the task reaches **any** Done status, system or custom, including *Cancelled*. In that case the agent is told the task was resolved without being completed.

## Where your statuses appear

- **Tickets**: your workspace's ticket statuses, custom ones included, appear in the Status field when you create or edit a ticket, in the Tickets **Status** filter, and on each ticket's status badge, using the names you gave them. See [Tickets, Partners & Support Portal](tickets-and-partners.md#ticket-statuses).
- **Dashboard ticket widgets**: a widget that filters tickets by status also accepts your custom ticket statuses.
