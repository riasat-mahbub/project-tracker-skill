---
name: project-tracker
description: File-based project knowledge graph. Before editing code, search related bugs, features, ADRs, tasks — then validate and rebuild after changes.
runAs: inline
---

# Project Tracker

This skill manages a `tracker/` directory that acts as a **project knowledge
graph** — bugs, features, decisions (ADRs), tasks, and epics.  Every entry is a
Markdown file with YAML frontmatter.  A `tracker rebuild` step generates
dashboards, a JSON adjacency graph (`graph.json`), and automatic backlinks.

## Prerequisites

Run this once to set up the skill and CLI tool:

    bash scripts/install.sh

If the `tracker` command is not available after that, tell the user.

## Workflow: Before editing code

1. **Search for context** — `tracker search <topic>` (finds entries matching
   the topic in frontmatter fields and body text)
2. **Read matches** — read the entries returned by search, especially their
   `RELATIONS` (what they depend on, what depends on them) and `AFFECTS.files`
   (which source files they touch)
3. **Validate state** — `tracker validate` (checks schema, catches broken
   references before you start editing)

## Workflow: After editing code

1. **Update tracker** — update the relevant entry's `STATUS`, add
   `RELATIONS` linking to related entries, and list changed files under
   `AFFECTS.files`
2. **Rebuild** — `tracker rebuild` (regenerates all index pages,
   `README.md`, `graph.json`, and computed backlinks)
3. **Validate** — `tracker validate` (confirm consistency)

## Workflow: Creating a new entry

    tracker new bug "Login race condition" --priority High --effort M
    tracker new feature "Bulk export" --effort L
    tracker new adr "Choose Postgres over MySQL" --status DONE
    tracker new task "Audit dependencies" --tags security
    tracker new epic "Authentication rewrite"

After creation, edit the entry file to fill in:

- **RELATIONS** — link to existing entries (`depends_on: [FEAT-018]`,
  `epic: [EPIC-001]`)
- **AFFECTS.files** — list source files the entry touches
- **Body sections** — Background, Investigation, Decision, Implementation,
  Verification, Follow-up

Then run `tracker rebuild && tracker validate`.

## Workflow: Reading the project graph

After `tracker rebuild`, the file `tracker/graph.json` contains every entry
as a node with its relations, affected files, and computed backlinks.
Read this file once to get the full project graph in a single load:

```json
{
  "BUG-001": {
    "type": "bug", "status": "IN_PROGRESS", "priority": "High",
    "relations": { "depends_on": ["FEAT-018"], "epic": ["EPIC-001"] },
    "affects": { "files": ["backend/api/auth.py"] },
    "referenced_by": ["BUG-003"]
  }
}
```

## Workflow: Closing an entry

    tracker close BUG-001 --resolution "Fixed with write lock"

Before closing, ensure the Verification section is complete and all relations
are valid.

## Quick command reference

| Command | What it does | When to use |
|---------|-------------|-------------|
| `init` | Scaffold tracker/ + folders | Once per project |
| `new <type> <name>` | Create entry with auto-ID | Adding a bug, feature, ADR, task, or epic |
| `close <id>` | Mark entry DONE | After fix or feature ships |
| `validate` | Check schema + refs | Before/after any edit |
| `rebuild` | Regenerate indexes + graph.json | After any edit |
| `migrate` | Upgrade old v1 entries to v2 | Once when adopting SCHEMA 2 |
| `doctor` | Validate + auto-fix issues | When validate reports warnings |
| `search <query>` | Full-text + field search | Before editing, to find context |
| `stats` | Counts by type/status | Quick project overview |
